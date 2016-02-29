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

# Initiate variable for the filename
my $f = "alphabet.txt";

# Open the file and store it in the filehandle
open FH, "<", "$f" or die "Can't open $f: $!";
my @alphabet;
# Push each line in the file into the array 'alphabet'
while( my $line = <FH> ) {
    push @alphabet, $line;
}
close FH or die "Can't close $f: $!";

# Print each element in alphabet
for my $i (0..$#alphabet) {
    print "Letter number ".($i + 1)." is ".$alphabet[$i];
}
