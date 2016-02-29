#!/usr/bin/perl
################## METADATA ##################
# NAME: Johan Olsson
# USERNAME: d15johol
# COURSE: IT341G
# ASSIGNMENT: Task 4.4
# DATE OF LAST CHANGE: 2016-02-29
##############################################

use warnings;
use strict;

# Store the filenames in strings
my $file = "users.csv";
my $newFile = "sortedUsers.csv";

# Open users.csv and store each user in an element in the array users
open FH, "<", "$file" or die "Can't open $file: $!";
my @users = split /,/, <FH>;
close FH or die "Can't close $file: $!";

# Sort users
@users = sort { lc($a) cmp lc($b) } @users;

# Open sortedUsers.csv and print each user on a new line
open FH, ">", "$newFile" or die "Can't open $newFile: $!";
while (my $line = <@users>) {
    chomp $line;
    print FH "$line\n";
}
close FH or die "Can't close $newFile: $!";
