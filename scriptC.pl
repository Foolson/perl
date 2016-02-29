#!/usr/bin/perl
################## METADATA ##################
# NAME: Johan Olsson
# USERNAME: d15johol
# COURSE: IT341G
# ASSIGNMENT: Task 4.3
# DATE OF LAST CHANGE: 2016-02-29
##############################################

use warnings;
use strict;

my $f = "alphabet.txt";

open FH, "<", "$f" or die "Can't open $f: $!";
my @alphabet;
while( my $line = <FH> ) {
    push @alphabet, $line;
}
close FH or die "Can't close $f: $!";

for my $i (0..$#alphabet) {
    print "Letter number ".($i + 1)." is ".$alphabet[$i];
}
