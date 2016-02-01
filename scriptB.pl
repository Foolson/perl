#!/usr/bin/perl
################## METADATA ##################
# NAME: Johan Olsson
# USERNAME: d15johol
# COURSE: IT341G VT16: Scriptprogrammering G1F, 7.5hp
# ASSIGNMENT: Script B
# DATE OF LAST CHANGE: 2016-02-01
##############################################

use warnings;
use strict;

print "Input a number: ";

my $input = <STDIN>;

if ( $input =~ /\d+/ ) {
    if ( $input > 42 ) {
        print "Your number is greater than 42!\n";
    }
    if ( $input < 42 ) {
        print "Your number is less than 42!\n";
    }
    if ( $input == 42 ) {
        print "Your number is 42!\n";
    }
}