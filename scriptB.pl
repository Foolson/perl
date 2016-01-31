#!/usr/bin/perl

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
