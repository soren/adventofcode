package HandyHaversacks;

use Boilerplate;
use Data::Dump qw(dump);

our $RULE = qr/(?<bag>.+) bags contain (?<list>.+)\./;

sub new($class, $rule_file) {
    my %contain;
    open my $file_handle, '<', $rule_file or die $!;
    while (my $rule = <$file_handle>) {
        chomp $rule;
        if ($rule =~ /^(?:$RULE)$/) {
            my $contained_in = $+{bag};
            for my $contains (split(/, /,$+{list})) {
                next if $contains eq "no other bags";
                $contains =~ /\d+ (.+) bags?/;
                my $bag = $1;
                $contain{$bag} = () unless exists $contain{$bag};
                push @{$contain{$bag}}, $contained_in;
            }
        } else {
            die "Cannot parse rule: $rule";
        }
    }
    close $file_handle;
    my %result = ();
    bless { contain => \%contain,
            result => \%result };
}

sub calc($self, $bag_color) {
    for (@{$self->{contain}->{$bag_color}}) {
        $self->{result}->{$_}++;
        if (exists $self->{contain}->{$_}) {
            $self->calc($_);
        }
    }

    return scalar keys %{$self->{result}};
}


1;
