#!/usr/bin/env perl

use strict;
use warnings;

use Mojolicious::Lite;
use Mojo::JSON qw(decode_json);
use Mojo::IOLoop;

use FindBin;
use lib "$FindBin::Bin/lib";

use Life;

app->defaults(layout => 'default', title => 'Cellular Automaton');

get '/' => sub { 
	my $self = shift;
	$self->redirect_to('/index.html');
};


my $clients = {};
my $client_counter = 0;
my $timer;

my $MAX_CLIENTS = 100;
my $MAX_GENERATIONS = 10_000;
my $LOOP_DELAY = 0.75;
my $INACTIVITY_TIMEOUT = 60;

sub incubate {
	app->log->debug("Incubate called.");
	foreach my $cid(keys %$clients) {
		if($clients->{$cid}->{life}) {
			app->log->debug("[$cid]: " . $clients->{$cid}->{life});
			my $life = \$clients->{$cid}->{life};
			if ($$life->generation < $MAX_GENERATIONS) {
				$$life = $$life->spawn();
				_send_life($cid);
			}
		}
	}
}

websocket '/ws' => sub {
	my $self = shift;

	return if ($client_counter >= $MAX_CLIENTS);

	$self->inactivity_timeout($INACTIVITY_TIMEOUT);

	my $tx = $self->tx;
	
	my $cid = $self->tx->connection;

	$clients->{$cid}->{tx} = $tx;

	$client_counter++;

	my $ip = $tx->remote_address;

	app->log->debug("Client '$ip' [$cid] connected [$client_counter]");

	$self->on( message => sub {
		my ($self, $message) = @_;

		$message = eval { decode_json($message) };

		return if ( !$message );
		return if ( !defined($message->{cmd}));

		my $cmd = $message->{cmd};

		return if ($cmd !~ /^(start|stop)$/);

		my $cid = $self->tx->connection;
		app->log->debug("$cid: $cmd");

		if ($cmd eq 'start') {
			return if ($clients->{$cid}->{life});
		
			my %args = (
				universe => [ Cell->new() ]
			);	

			if(defined($message->{rule}) && $message->{rule} =~ /^\d+$/) {
				if ($message->{rule} >= 0 && $message->{rule} <= 255) {
					$args{rule} = $message->{rule};
				}
			}
			$clients->{$cid}->{life} = Life->new( %args );
			_send_life($cid);

			if ($client_counter >= 1) {
				if(!defined($timer)) {
					app->log->debug("Starting Timer");
					$timer = Mojo::IOLoop->recurring($LOOP_DELAY => \&incubate);
				}
			}
		} elsif ($cmd eq 'stop') {
			return if (!defined($clients->{$cid}->{life}));
			$self->finish;
		}
	});
	$self->on( finish => sub {
		my ($self, $code, $reason) = @_;
		_close_ws($self);
	});
};

sub _close_ws {
	my $controller = shift;
	my $cid = $controller->tx->connection;
	$clients->{$cid}->{life} = undef;
	delete $clients->{$cid};
	$client_counter--;

	if ($client_counter == 0) {
		app->log->debug("Removing Timer");
		Mojo::IOLoop->remove($timer);
		$timer = undef;
	}

	app->log->debug("Client [$cid] disconnected [$client_counter]");
}

sub _send_life {
	my $cid = shift;
	my $life = $clients->{$cid}->{life};
	$clients->{$cid}->{tx}->send({ json => { generation => $life->generation, universe => [ $life->flatten ] }});
}

app->start;
