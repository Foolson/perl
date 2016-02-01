#!/usr/bin/perl
################## METADATA ##################
# NAME: Johan Olsson
# USERNAME: d15johol
# COURSE: IT341G VT16: Scriptprogrammering G1F, 7.5hp
# ASSIGNMENT: Script C
# DATE OF LAST CHANGE: 2016-02-01
##############################################

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