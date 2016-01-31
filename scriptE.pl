#!/usr/bin/perl

use warnings;
use strict;

my $f = "alphabet.txt";

open FH, "<", "$f" or die "Can't open $f: $!";
my @keys;
while( my $line = <FH> ) {
    chomp $line;
    push @keys, $line;
}
close FH or die "Can't close $f: $!";

my @values;
for my $i (0..$#keys) {
    $values[$i] = ($i + 1);
}

my %hash;
@hash{@keys} = @values;

@keys = sort { $a cmp $b } keys %hash;

foreach my $key ( @keys ) {
    printf $key.":".$hash{$key}."\n";
}
