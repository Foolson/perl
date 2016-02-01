#!/usr/bin/perl
################## METADATA ##################
# NAME: Johan Olsson
# USERNAME: d15johol
# COURSE: IT341G
# ASSIGNMENT: Script E
# DATE OF LAST CHANGE: 2016-02-01
##############################################

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

foreach my $key (sort {lc $a cmp lc $b} keys %hash) {
  printf $key.":".$hash{$key}."\n";
}