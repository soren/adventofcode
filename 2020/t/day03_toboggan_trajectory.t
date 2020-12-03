use Test::Most tests => 12;

require_ok('TobogganTrajectory');

my $trajectory = TobogganTrajectory->new();
my $slopes = [[1,1],[3,1],[5,1],[7,1],[1,2]];

$trajectory->load('t/day03_input0.txt');

ok($trajectory->get_row_count == 11, 'number of rows');
ok($trajectory->get_col_count == 11, 'number of columnss');

ok($trajectory->is_tree(0,0) == 0, 'starting position is empty');
ok($trajectory->is_tree(0,1) == 1, 'tree one down');
ok($trajectory->is_tree(11,1) == 1, 'wrap-around work');
ok($trajectory->calc_tree_count($slopes->[1]) == 7, 'tree count 1');

ok($trajectory->calc_tree_count($slopes->[0]) == 2, 'tree count 0');
ok($trajectory->calc_tree_count($slopes->[2]) == 3, 'tree count 2');
ok($trajectory->calc_tree_count($slopes->[3]) == 4, 'tree count 3');
ok($trajectory->calc_tree_count($slopes->[4]) == 2, 'tree count 4');
ok($trajectory->calc_tree_product($slopes) == 336, 'tree product');

$trajectory->load('t/day03_input1.txt');

note "Day 3a answer: ", $trajectory->calc_tree_count($slopes->[1]);
note "Day 3b answer: ", $trajectory->calc_tree_product($slopes);
