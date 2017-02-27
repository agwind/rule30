package Cell;

=head1 NAME

Cell - A simple cell

=head1 SYNOPSIS

    use Cell;
    my $cell = Cell->new();

=head1 DESCRIPTION

A Cell belonging to the universe in L<Life>

=cut

use Moose;
use Moose::Util::TypeConstraints;

has state => (
	is => 'ro',
	isa => enum([qw/ alive dead /]),
	default => 'alive',
	documentation => q{The state of our cell can be alive or dead},
);

no Moose;
__PACKAGE__->meta->make_immutable;

=head1 AUTHOR

Benjamin Noggle - <http://agwind.net>

=cut
