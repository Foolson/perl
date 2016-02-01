#!/usr/bin/perl
################## METADATA ##################
# NAME: Johan Olsson
# USERNAME: d15johol
# COURSE: IT341G VT16: Scriptprogrammering G1F, 7.5hp
# ASSIGNMENT: Script A
# DATE OF LAST CHANGE: 2016-02-01
##############################################

use warnings;
use strict;
use Term::ANSIColor;

my $exit = 0;

while ( ! $exit ) {
  print "Input text: ";
  my $input = <STDIN>;
  chomp $input;
  
  if ( $input =~ /\S/ ){
  print "$input\n";
  }
  elsif ( $input =~ /\s/  ) {
    print color('red')."ERROR: ".color('reset');
    print "Only whitespace detected!\n"
  }
  else {
    $exit = 1;
  }
}