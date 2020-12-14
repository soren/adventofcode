use Test::Most tests => 2;

require_ok('HandyHaversacks');

my $bag_color = 'shiny gold';
my $rules = HandyHaversacks->new('t/day07_input0.txt');
ok($rules->calc($bag_color) == 4, 'number of bags');

$rules = HandyHaversacks->new('t/day07_input1.txt');
note "Day 7a answer: ", $rules->calc($bag_color);
#note "Day 7b answer: ", $customs->calc_yes_count(1);
