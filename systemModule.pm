#!/usr/bin/perl

package systemModule;

use warnings;
use strict;
use Data::Dumper;
# Start
my @carola;
my @netstat = `netstat -anptu`;
chomp @netstat;
for my $i (0...$#netstat){
  my $ipVersion;
  my @match = $netstat[$i] =~ /^(\w+).+\d+\s{1}(.+):(\d+)\s+.+:(?:\*|\d+)\s+(?:\w+\s+)?(?:\-|(\d+)\/)(\S+[ ]?\S+)?(?:\s{2,})?/g;
  if ( length $match[0] ) {
    my $test = $match[1] =~ /[:]/;
    if ( $test == 1 ) {
      $ipVersion = 6;
    }
    else {
      $ipVersion = 4;
    }

    push @carola, {
      protocol        => "$match[0]",
      ipVersion       => "$ipVersion",
      portNumber      => "$match[2]",
      listeningDevice => "$match[1]",
      processId       => "$match[3]",
      processName     => "$match[4]"
    };
  }
}
print Dumper @carola;
# End
1;
