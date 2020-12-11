use Test::Most tests => 5;

require_ok('BinaryBoarding');

my %seat_codes = (
    FBFBBFFRLR => 357,
    BFFFBBFRRR => 567,
    FFFBBBFRRR => 119,
    BBFFBBFRLL => 820);

for my $seat_code (keys %seat_codes) {
    ok(BinaryBoarding->calc_seat_id($seat_code) == $seat_codes{$seat_code}, "seat code $seat_code");
}

my $boarding = BinaryBoarding->new('t/day05_input1.txt');

note "Day 5a answer: ", $boarding->get_max_seat_id;
note "Day 5b answer: ", $boarding->find_empty_seat_id;
