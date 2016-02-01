#!/usr/bin/perl
################## METADATA ##################
# NAME: Johan Olsson
# USERNAME: d15johol
# COURSE: IT341G
# ASSIGNMENT: Script D
# DATE OF LAST CHANGE: 2016-02-01
##############################################

use warnings;
use strict;

my $file = "users.csv";
my $newFile = "sortedUsers.csv";

open FH, "<", "$file" or die "Can't open $file: $!";
my @users = split /,/, <FH>;
close FH or die "Can't close $file: $!";

@users = sort { lc($a) cmp lc($b) } @users;

open FH, ">", "$newFile" or die "Can't open $newFile: $!";
while (my $line = <@users>) {
    chomp $line;
    print FH "$line\n";
}
close FH or die "Can't close $newFile: $!";