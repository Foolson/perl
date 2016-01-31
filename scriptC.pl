#!/usr/bin/perl

use warnings;
use strict;

my $f = "alphabet.txt";

open FH, "<", "$f" or die "Can't open $f: $!";
my @alphabet;
while( <FH> ) {
    push @alphabet, $_;
}
close FH or die "Can't close $f: $!";

for my $i (0..$#alphabet) {
    print "Letter number ".($i + 1)." is ".$alphabet[$i];
}
