use Test::Most tests => 4;

require_ok('HandheldHalting');

my $handheld = HandheldHalting->new();

$handheld->load('t/day08_input0.txt');
my $ip = $handheld->run;
ok($ip < 0, 'early exit');
ok($handheld->accumulator == 5, 'accumulator after early exit');
$handheld->run_fixes;
ok($handheld->accumulator == 8, 'accumulator after termination');


$handheld->load('t/day08_input1.txt');
$handheld->run;
note "Day 8a answer: ", $handheld->accumulator;
$handheld->run_fixes;
note "Day 8b answer: ", $handheld->accumulator;

