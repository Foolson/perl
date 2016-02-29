#!/usr/bin/perl
################## METADATA ##################
# NAME: Johan Olsson
# USERNAME: d15johol
# COURSE: IT341G
# ASSIGNMENT: Task 4.1
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
  print "Input text: ";
  # Catch the users input
  my $input = <STDIN>;
  # Remove newline from the end of the input
  chomp $input;

  # If the user enters anything but whitespaces (it can include whitespaces though) the program will print the input and loop back
  if ( $input =~ /\S/ ){
  print "$input\n";
  }
  # If the user only enters whitespaces the program will print an error message and loop back
  elsif ( $input =~ /\s/  ) {
    # I used the module 'Term::ANSIColor' to make the error message more fancyfancy
    print color('red')."ERROR: ".color('reset');
    print "Only whitespace detected!\n"
  }
  # If the user press enter without text the script will exit the loop
  else {
    $exit = 1;
  }
}
