#!/usr/bin/perl
################## METADATA ##################
# NAME: Johan Olsson
# USERNAME: d15johol
# COURSE: IT341G
# ASSIGNMENT: Task 4.5
# DATE OF LAST CHANGE: 2016-02-29
##############################################

use warnings;
use strict;

# Initiate variable for the filename
my $f = "alphabet.txt";

# Open alphabet.txt and store each line in an array with newlines removed
open FH, "<", "$f" or die "Can't open $f: $!";
my @keys;
while( my $line = <FH> ) {
  chomp $line;
  push @keys, $line;
}
close FH or die "Can't close $f: $!";

# Create a new arry with the line numbers from alphabet.txt
my @values;
for my $i (0..$#keys) {
  $values[$i] = ($i + 1);
}

# Combine the content from alphabet.txt with its line numbers in a hash
my %hash;
@hash{@keys} = @values;

# Print the hash on screen sorted after its keys
foreach my $key (sort {lc $a cmp lc $b} keys %hash) {
  printf $key.":".$hash{$key}."\n";
}
