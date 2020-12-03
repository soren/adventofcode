use Test::Most tests => 3;

require_ok('PasswordPhilosophy');

my $policy = PasswordPhilosophy->new(1);
ok($policy->count_valid('t/day02_input0.txt') == 2, 'valid count according to policy');

my $new_policy = PasswordPhilosophy->new(2);
ok($new_policy->count_valid('t/day02_input0.txt') == 1, 'valid count according to correct policy');

note "Day 2a answer: ", $policy->count_valid('t/day02_input1.txt');
note "Day 2b answer: ", $new_policy->count_valid('t/day02_input1.txt');
