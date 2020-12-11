use Test::Most tests => 4;

require_ok('CustomCustoms');

my $customs = CustomCustoms->new('t/day06_input0.txt');

ok($customs->get_group_count == 5, 'group count');
ok($customs->calc_yes_count == 11, 'any yes sum');
ok($customs->calc_yes_count(1) == 6, 'all yes sum');

$customs = CustomCustoms->new('t/day06_input1.txt');

note "Day 6a answer: ", $customs->calc_yes_count;
note "Day 6b answer: ", $customs->calc_yes_count(1);
