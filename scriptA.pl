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

print "Input text: ";
my $input = <STDIN>;

if ( $input =~ /./ ){
print $input;
}