#!/usr/bin/perl

use warnings;
use strict;

my $user = "root";

my @last = `last $user`;

my @logins = @last;

print "$user - $#logins\n"
