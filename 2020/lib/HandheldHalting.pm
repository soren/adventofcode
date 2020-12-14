package HandheldHalting;

use Boilerplate;
use Data::Dump qw(dump);

sub new($class) {
    bless { accumulator => 0,
            instructions => [] };
}

sub clear($self) {
    $self->{accumulator} = 0;
    $self->{instructions} = [];
}

sub reset($self) {
    $self->{accumulator} = 0;
    delete $_->{executed} for (@{$self->{instructions}});
}

sub compile_instruction($self, $operation, $argument) {
    return {
        op => $operation, arg => $argument,
        add => $operation eq 'acc' ? $argument : 0,
        next => $operation eq 'jmp' ? $argument : 1
    }
}

sub load($self, $instruction_file) {
    $self->clear();
    open my $file_handle, '<', $instruction_file or die $!;
    while (my $instruction = <$file_handle>) {
        if ($instruction =~ /^(?<operation>acc|jmp|nop) (?<argument>[+-]\d+)$/) {
            push @{$self->{instructions}},
              $self->compile_instruction($+{operation}, int($+{argument}));
        } else {
            die "Cannot parse instruction: $instruction";
        }
    }
    close $file_handle;
}

sub accumulator($self) {
    $self->{accumulator};
}

sub run($self) {
    my $ip = 0;
    while ($ip >= 0 && $ip < scalar @{$self->{instructions}}) {
        my $instruction = $self->{instructions}->[$ip];
        return -1 if exists $instruction->{executed}; # Prevent infinite looping
        $self->{accumulator} += $instruction->{add};
        $instruction->{executed} = 1;
        $ip += $instruction->{next};
    }
    return $ip;
}

sub run_fixes($self) {
    for my $i (0 .. $#{$self->{instructions}}) {
        $self->reset;
        my $instruction = $self->{instructions}->[$i];
        if ($self->{instructions}->[$i]->{add} == 0) {
            my $save = \%{$self->{instructions}->[$i]};
            my $new = $self->compile_instruction(
                $self->{instructions}->[$i]->{op} eq 'nop' ? 'jmp' : 'nop',
                $self->{instructions}->[$i]->{arg});
            $self->{instructions}->[$i] = $new;
            return unless $self->run < 0;
            $self->{instructions}->[$i] = $save;
        }
    }
}

1;
