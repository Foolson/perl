#!/usr/bin/perl
################## METADATA ##################
# NAME: Johan Olsson
# USERNAME: d15johol
# COURSE: IT341G
# ASSIGNMENT: Task 4.2
# DATE OF LAST CHANGE: 2016-02-29
##############################################

use warnings;
use strict;
use Term::ANSIColor;

my $exit = 0;

while ( ! $exit ) {
  print "Input a number: ";

  my $input = <STDIN>;
  chomp $input;

  if ( $input =~ /^\d+$/ ) {
    if ( $input > 42 ) {
        print "Your number is greater than 42!\n";
    }
    elsif ( $input < 42 ) {
        print "Your number is less than 42!\n";
    }
    elsif ( $input == 42 ) {
        print "Your number is 42!\n";
    }
  }
  elsif ( $input =~ /\D+/ ) {
    print color('red')."ERROR: ".color('reset');
    print "Only numbers are accepted!\n"
  }
  else {
    $exit = 1;
  }
}
