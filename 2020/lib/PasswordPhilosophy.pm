package PasswordPhilosophy;

use Boilerplate;

sub new($class, $policy_version) {
    bless { policy_version => $policy_version };
}


sub is_valid($self, $rule, $password) {
    if ($rule =~ /(?<n1>\d+)-(?<n2>\d+) (?<letter>.)/) {
        my ($n1, $n2, $letter) = ($+{n1}, $+{n2}, $+{letter});

        if ($self->{policy_version} == 1) {
            my $count = length($password =~ s/[^\Q$letter\E]//rg);
            return $n1 <= $count && $count <= $n2;
        } else {
            my ($l1, $l2) = (substr($password, $n1-1, 1), substr($password, $n2-1, 1));
            return (($l1 eq $letter) xor ($l2 eq $letter));
        }
    }
    die "Unparsable rule: '$rule'";
}


sub count_valid($self, $password_file) {
    my $count = 0;

    open my $file_handle, '<', $password_file or die $!;
    while (my $line = <$file_handle>) {
        chomp $line;
        my ($rule, $password) = split ': ', $line;
        $count++ if $self->is_valid($rule, $password);
    }
    close $file_handle;

    return $count;
}


1;
