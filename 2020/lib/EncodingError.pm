package EncodingError;

use Boilerplate;
use Data::Dump qw(dump);

sub new($class, $preamble_length, $xmas_file) {
    open my $file_handle, '<', $xmas_file or die $!;
    my @preamble;
    for (1 .. $preamble_length) {
        chomp(my $number = <$file_handle>);
        push @preamble, $number;
    }
    bless { preamble => \@preamble,
            file_handle => $file_handle};
}

sub DESTROY($self) {
    close $self->{file_handle};
}

sub preamble($self) {
    return @{$self->{preamble}};
}

sub is_valid($self, $number) {
    for my $i (0 .. $#{$self->{preamble}}) {
        for my $j ($i .. $#{$self->{preamble}}) {
            return 1 if $self->{preamble}->[$i] + $self->{preamble}->[$j] == $number;
        }
    }
    return 0;
}

sub find_invalid($self) {
    seek $self->{file_handle}, scalar $self->{preamble}, 0;
    while (!eof($self->{file_handle})) {
        chomp(my $number = readline($self->{file_handle}));
        return $number unless $self->is_valid($number);
        push @{$self->{preamble}}, $number;
        shift @{$self->{preamble}};
    }
    return undef;
}

sub find_set($self, $target) {
    seek $self->{file_handle}, 0, 0;
    chomp(my @numbers = readline($self->{file_handle}));
    my ($lo, $hi) = (0,1);
    my $sum = $numbers[$lo] + $numbers[$hi];
    while (1) {
        if ($sum == $target) {
            my ($min, $max);
            for ($lo .. $hi) {
                $min = $numbers[$_] if !defined $min || $numbers[$_] < $min;
                $max = $numbers[$_] if !defined $max || $numbers[$_] > $max;
            }
            return $min + $max;
        }
        if ($sum < $target) {
            $sum += $numbers[++$hi];
        } else {
            $sum -= $numbers[$lo++];
        }
    }
}

1;
