use Test::More;
use Test::Deep;

use_ok 'Cell';
use_ok 'Life';

my $cell = Cell->new();
is($cell->state, 'alive', 'Default state is alive');
$cell = undef;
$cell = Cell->new( state => 'alive');
is($cell->state, 'alive', 'Can set state to alive with constructor');
$cell = undef;
$cell = Cell->new( state => 'dead');
is($cell->state, 'dead', 'Can set state to dead with constructor');

my $life = Life->new( universe => [ Cell->new() ]);
is($life->rule, 30, 'Default rule is 30');
my @methods = qw/universe rule generation _evolution_map _build_evolution_map flatten spawn/;
can_ok($life, @methods);

my $newlife = $life->spawn();
cmp_deeply($newlife->universe, [ Cell->new(), Cell->new(), Cell->new() ], '2nd Generation rule 30 looks good');
$newlife = $newlife->spawn();
cmp_deeply($newlife->universe, [ Cell->new(), Cell->new(), Cell->new( state => 'dead' ), Cell->new( state=> 'dead' ), Cell->new() ], '3rd Generation rule 30 looks good');
is($newlife->generation, 3, 'Generation is incrementing for spawns.');

cmp_deeply($newlife->flatten, [ 1, 1, 0, 0, 1], 'Life object flattens to a simple array');

#TODO
# different rules are creating different _evolution_map's
# _build_evolution_map

done_testing();

