package TobogganTrajectory;

use Boilerplate;

sub new($class) {
    bless { base_map => [] };
}

sub load($self, $map_file) {
    open my $file_handle, '<', $map_file or die $!;
    chomp (@{$self->{base_map}} = <$file_handle>);
    close $file_handle;
}

sub get_row_count($self) {
    scalar @{$self->{base_map}};
}

sub get_col_count($self) {
    length $self->{base_map}->[0];
}

sub is_tree($self, $x, $y) {
    my $row = $self->{base_map}->[$y];
    while ($x > $self->get_col_count-1) {
        $x -= $self->get_col_count;
    }
    return substr($row, $x, 1) eq '#';
}

sub calc_tree_count($self, $slope) {
    my ($x, $y) = (0,0);
    my $tree_count = 0;
    while ($y < $self->get_row_count) {
        $tree_count += $self->is_tree($x, $y);
        $x+=$slope->[0]; $y+=$slope->[1];
    }
    return $tree_count;
}

sub calc_tree_product($self, $slopes) {
    my $product = 1;
    for my $slope (@$slopes) {
        $product *= $self->calc_tree_count($slope);
    }
    return $product;
}

1;
