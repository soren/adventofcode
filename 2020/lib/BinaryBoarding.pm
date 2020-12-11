package BinaryBoarding;

use Boilerplate;

sub new($class, $boarding_file) {
    my @seat_ids = ();
    my $min_seat_id;
    my $max_seat_id;

    open my $fh, '<', $boarding_file or die;
    while (my $seat_code = <$fh>) {
        chomp $seat_code;
        my $seat_id = $class->calc_seat_id($seat_code);
        $seat_ids[$seat_id] = 1;
        $min_seat_id = $seat_id if !defined $min_seat_id || $seat_id < $min_seat_id;
        $max_seat_id = $seat_id if !defined $max_seat_id || $seat_id > $max_seat_id;
    }
    close $fh;

    bless { seat_ids => \@seat_ids,
            min_seat_id => $min_seat_id,
            max_seat_id => $max_seat_id };
}

sub calc_seat_id($class, $seat_code) {
    return oct('0b' . $seat_code =~ y/FBRL/0110/r);
}

sub get_max_seat_id($self) {
    return $self->{max_seat_id};
}

sub find_empty_seat_id($self) {
    for my $id ($self->{min_seat_id}+1 .. $self->{max_seat_id}-1) {
        if ($self->{seat_ids}->[$id-1] && !$self->{seat_ids}->[$id] && $self->{seat_ids}->[$id+1]) {
            return $id;
        }
    }
}

1;
