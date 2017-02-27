package Life;

=head1 NAME

Life - A container for L<Cell>s

=head1 SYNOPSIS

    use Life;
    my $life = Life->new( rule => 126, universe => [ Cell->new() ] );
    my $newlife = $life->spawn();

=head1 DESCRIPTION

Life is a container for our cells.  This uses one-dimensional cellular 
automata rules for spwaning new life.

=cut

use Moose;
use Moose::Util::TypeConstraints;

use Cell;

has universe => (
	is => 'rw',
	isa => 'ArrayRef[Cell]',
	default => sub { return [] },
	documentation => q{Where all of our cells live},
);

subtype 'Byte',
	as 'Int',
	where { ( $_ >= 0 ) && ( $_ <= 255 ) };

has rule => (
	is => 'ro',
	isa => 'Byte',
	default => 30,
	documentation => q{The rule for how our cells change},
);

has generation => (
	is => 'ro',
	isa => 'Int',
	default => 1,
	documentation => q{How many times our cells have changed},
);

has '_evolution_map' => (
	is => 'ro',
	isa => 'ArrayRef[Int]',
	builder => '_build_evolution_map',
	lazy => 1,
);

# Convert our rule into a bit map
sub _build_evolution_map {
	my $self = shift;
	my @bits = (1, 2, 4, 8, 16, 32, 64, 128);
	return [ map { ($self->rule & $_) == $_ ? 1 : 0 } @bits ];
}


=head2 Methods

=over 12

=item C<flatten>

Flattens our universe into a simple array.  Each item in the area is either
1 for alive or 0 for dead.

=cut

sub flatten {
	my $self = shift;
	return map { $_->state eq 'alive' ? 1 : 0 } @{$self->universe};
}

=item C<spawn>

Returns a new L<Life> container with a new set of Cell's based on our rule for
our cellular automata.  With each spawn, a new dead cell is added on both ends
before we calculate the new set.  Generation is also incremented with each
spawn.

=cut

# The general algorithem is to grow the universe so I have neighbors I can look
# at to see what my new generation is going to look like.  The eight possible
# transition states are stored in _evolution_map.  As I iterate through the
# universe (Array of Cells), I use my neigherbors and current Cell to calculate
# my new Cell and push that onto the newly created universe. 
sub spawn {
	my $self = shift;
	my @temp_universe = @{$self->universe};
	unshift @temp_universe, Cell->new( state => 'dead'), Cell->new( state => 'dead');
	push @temp_universe, Cell->new( state => 'dead'), Cell->new( state => 'dead');
	my $newlife = Life->new( rule => $self->rule, generation => $self->generation + 1 );
	for (my $i = 1; $i <= ( scalar(@{$self->universe}) + 2 ); $i++ ) {
		my $evolution_index = (2**2 * ($temp_universe[$i-1]->state eq 'alive' ? 1 : 0)) +
									 (2**1 * ($temp_universe[$i]->state eq 'alive' ? 1 : 0)) +
									 (2**0 * ($temp_universe[$i+1]->state eq 'alive' ? 1 : 0));
		push @{$newlife->universe}, $self->_evolution_map->[$evolution_index] ? Cell->new ( state => 'alive' ) : Cell->new( state => 'dead' );
	}
	return $newlife;
}

=back

=head1 AUTHOR

Benjamin Noggle - <http://agwind.net>

=cut

no Moose;
__PACKAGE__->meta->make_immutable;
