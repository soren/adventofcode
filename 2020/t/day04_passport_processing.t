use Test::Most tests => 12;

require_ok('PassportProcessing');

my $processor = PassportProcessing->new();

my $passport = 'eyr:2033 hgt:177cm pid:173cm ecl:utc byr:2029 hcl:#efcc98 iyr:2023';

ok($processor->is_valid($passport), 'valid passport without cid');
ok($processor->count_valid('t/day04_input0.txt') == 2, 'number of valid passports');

my $invalid_passport = 'pid:7328393469 hgt:175cm ecl:gry iyr:2012 byr:1963 hcl:#623a2f eyr:2026';

ok(!$processor->is_valid($invalid_passport, 1), 'invalid passport with 10 digit pid');

my @invalid_passports = (
    'eyr:1972 cid:100 hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926',
    'iyr:2019 hcl:#602927 eyr:1967 hgt:170cm ecl:grn pid:012533040 byr:1946',
    'hcl:dab227 iyr:2012 ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277',
    'hgt:59cm ecl:zzz eyr:2038 hcl:74454a iyr:2023 pid:3556412378 byr:2007');

for my $i (0..$#invalid_passports) {
    ok(!$processor->is_valid($invalid_passports[$i], 1), "invalid passport $i");
}

my @valid_passports = (
    'pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980 hcl:#623a2f',
    'eyr:2029 ecl:blu cid:129 byr:1989 iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm',
    'hcl:#888785 hgt:164cm byr:2001 iyr:2015 cid:88 pid:545766238 ecl:hzl eyr:2022',
    'iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719');

for my $i (0..$#valid_passports) {
    ok($processor->is_valid($valid_passports[$i], 1), "valid passport $i");
}

note "Day 4a answer: ", $processor->count_valid('t/day04_input1.txt');
note "Day 4b answer: ", $processor->count_valid('t/day04_input1.txt', 1);
