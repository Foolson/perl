#!/usr/bin/perl

package systemModule;

use warnings;
use strict;
# Start
my @netstat = `netstat -anptu` =~ /(tcp|tcp6|udp|udp6)\s+/g;
chomp @netstat;

my @test;
my @test2;
for my $i (0...$#netstat) {
  print "$netstat[$i]\n";
}
# End
1;
