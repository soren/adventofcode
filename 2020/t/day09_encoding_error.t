use Test::Most tests => 4;

require_ok('EncodingError');
my $encoding = EncodingError->new(5, 't/day09_input0.txt');

ok(scalar($encoding->preamble) == 5, 'preamble len');

ok($encoding->find_invalid == 127, 'invalid number');
ok($encoding->find_set(127) == 62, 'encryption weakness');

$encoding = EncodingError->new(25, 't/day09_input1.txt');

my $invalid = $encoding->find_invalid;
note "Day 9a answer: ", $invalid;
note "Day 9b answer: ", $encoding->find_set($invalid);

