package ReportRepair;

use Boilerplate;

sub new($class) {
    bless { expenses => [] };
}

sub load($self, $expense_report) {
    open my $file_handle, '<', $expense_report or die $!;
    chomp (@{$self->{expenses}} = <$file_handle>);
    close $file_handle;
}

sub get_expense_count($self) {
    scalar @{$self->{expenses}};
}

sub calc_double_product($self, $sum) {
    for my $i1 (0 .. $#{$self->{expenses}}) {
        for my $i2 ($i1 .. $#{$self->{expenses}}) {
            if ($self->{expenses}[$i1] + $self->{expenses}[$i2] == $sum) {
                return $self->{expenses}[$i1] * $self->{expenses}[$i2];
            }
        }
    }
    return -1;
}

sub calc_triple_product($self, $sum) {
    for my $i1 (0 .. $#{$self->{expenses}}) {
        for my $i2 (0 .. $#{$self->{expenses}}) {
            next if $i2 == $i1;
            for my $i3 (0 .. $#{$self->{expenses}}) {
                next if $i3 == $i1 || $i3 == $i2;
                if ($self->{expenses}[$i1] + $self->{expenses}[$i2] + $self->{expenses}[$i3] == $sum) {
                    return $self->{expenses}[$i1] * $self->{expenses}[$i2] * $self->{expenses}[$i3];
                }
            }
        }
    }
    return -1;
}

1;
