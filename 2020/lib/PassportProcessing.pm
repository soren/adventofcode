package PassportProcessing;

use Boilerplate;
use English;


our %REQUIRED_FIELDS = (
    byr => { name => 'Birth Year',
             re => qr/(?<val>\d{4})/, min => 1920, max => 2002 },
    iyr => { name => 'Issue Year',
             re => qr/(?<val>\d{4})/, min => 2010, max => 2020 },
    eyr => { name => 'Expiration Year',
             re => qr/(?<val>\d{4})/, min => 2020, max => 2030 },
    hgt => { name => 'Height',
             re => qr/(?<val>\d{2,3})(?<key>cm|in)/,
             cm => { min => 150, max => 193},
             in => { min => 59, max => 76 } },
    hcl => { name => 'Hair Color',
             re => qr/#[0-9a-f]{6}/ },
    ecl => { name => 'Eye Color',
             re => qr/amb|blu|brn|gry|grn|hzl|oth/ },
    pid => { name => 'Passport ID',
             re => qr/\d{9}/ }
    #cid => 'Country ID'
   );
our $REQUIRED_COUNT = scalar keys %REQUIRED_FIELDS;


sub new($class) {
    bless { };
}

sub is_required($self, $field_key) {
    exists $REQUIRED_FIELDS{$field_key};
}

sub is_valid($self, $passport, $strict=0) {
    my $count = 0;
    my $valid = 1;
    for my $field (split(' ', $passport)) {
        my ($key, $value) = split(':', $field);
        if ($self->is_required($key)) {
            $count++;
            if ($strict) {
                $valid &&= $value =~ /^(?:$REQUIRED_FIELDS{$key}{re})$/;
                $valid &&= $+{val} >= $REQUIRED_FIELDS{$key}{min} if exists $REQUIRED_FIELDS{$key}{min};
                $valid &&= $+{val} <= $REQUIRED_FIELDS{$key}{max} if exists $REQUIRED_FIELDS{$key}{max};
                if (defined $+{key}) {
                    $valid &&= $+{val} >= $REQUIRED_FIELDS{$key}{$+{key}}{min} if exists $REQUIRED_FIELDS{$key}{$+{key}}{min};
                    $valid &&= $+{val} <= $REQUIRED_FIELDS{$key}{$+{key}}{max} if exists $REQUIRED_FIELDS{$key}{$+{key}}{max};
                }
            }
        }
    }

    return $valid && $count == $REQUIRED_COUNT;
}

sub count_valid($self, $passport_file, $strict=0) {
    my $count = 0;

    open my $file_handle, '<', $passport_file or die $!;
    $INPUT_RECORD_SEPARATOR = ""; # read in paragraph mode
    while (my $passport = <$file_handle>) {
        chomp $passport;
        $count++ if $self->is_valid($passport, $strict);
    }
    close $file_handle;

    return $count;
}


1;
