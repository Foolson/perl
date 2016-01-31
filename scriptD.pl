#!/usr/bin/perl

use warnings;
use strict;

my $file = "users.csv";
my $newFile = "sortedUsers.csv";

open FH, "<", "$file" or die "Can't open $file: $!";
my @users = split /[\W]/, <FH>;
close FH or die "Can't close $file: $!";

@users = sort { lc($a) cmp lc($b) } @users;

open FH, ">", "$newFile" or die "Can't open $newFile: $!";
while (my $test = <@users>) {
    print FH "$test\n";
}
close FH or die "Can't close $newFile: $!";
