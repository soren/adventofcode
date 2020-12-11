package CustomCustoms;

use Boilerplate;
use English;

sub new($class, $answer_file) {
    my @groups = ();

    open my $file_handle, '<', $answer_file or die $!;
    $INPUT_RECORD_SEPARATOR = ""; # read in paragraph mode
    while (my $group = <$file_handle>) {
        chomp $group;
        push @groups, $group;
    }
    close $file_handle;

    bless { groups => \@groups};
}

sub get_group_count($self) {
    return scalar @{$self->{groups}};
}

sub calc_yes_count($self, $all=0) {
    my $sum = 0;
    for my $group (@{$self->{groups}}) {
        my %yeses = ();
        my @persons = split /\n/, $group;
        for my $person (@persons) {
            $yeses{$_}++ for (split //, $person);
        }
        $sum += $all ? grep { $_ == scalar @persons } values %yeses : scalar %yeses;
    }
    return $sum;
}

1;
