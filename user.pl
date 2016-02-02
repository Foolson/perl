#!/usr/bin/perl

use warnings;
use strict;

my $user = "root";

my @users;

my @last = `last $user`;

my @logins = @last;

print "$user - $#logins\n"

my $f;

$f = "/etc/login.defs";

open FH, "<", "$f" or die "Can't open $f: $!";
my @UID;
while( my $line = <FH> ) {
  if ( /GID_MIN/ ) {
    chomp $line;
    push @UID, $line;
  }
}
close FH or die "Can't close $f: $!";

print @UID;