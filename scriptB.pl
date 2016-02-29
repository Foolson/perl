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

# Initiate exit variable for the while-loop
my $exit = 0;

# While loop which holds the main part of the script, it will exit if the variable $exit is true
while ( ! $exit ) {
  # Tell the user to input some text
  print "Input a number: ";

  # Catch the users input
  my $input = <STDIN>;
  # Remove newline from the end of the input
  chomp $input;

  # If the user enters digits the program will print the proper response and move on
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
  # If the user enters anything but digits the script will print an error and loop back
  elsif ( $input =~ /\D+/ ) {
    # I used the module 'Term::ANSIColor' to make the error message more fancyfancy
    print color('red')."ERROR: ".color('reset');
    print "Only numbers are accepted!\n"
  }
  # If the user press enter without any input the script will exit the loop
  else {
    $exit = 1;
  }
}
