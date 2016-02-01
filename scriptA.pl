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
  
  if ( $input =~ /\S/ ){
  print $input;
  $exit = 1;
  }
  elsif ( $input =~ /\s{2,}/  ) {
    print color('red');
    print "ERROR: ";
    print color('reset');
    print "Only whitespace detected\n"
  }
  else {
    $exit = 1;
  }
}