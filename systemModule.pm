#!/usr/bin/perl

package systemModule;

use warnings;
use strict;

# Start
sub network{
  my @network;
  my @netstat = `netstat -plntu`;
  chomp @netstat;
  for my $i (0...$#netstat){
    my $ipVersion;
    my @match = $netstat[$i] =~ /^(\w+).+\d+\s{1}(.+):(\d+)\s+.+:(?:\*|\d+)\s+(?:\w+\s+)?(?:\-|(\d+)\/)(\S+[ ]?\S+)?(?:\s{2,})?/g;
    if ( length $match[0] ) {
      my $ip = $match[1] =~ /[:]/;
      if ( $ip == 1 ) {
        $ipVersion = "IPv6";
      }
      else {
        $ipVersion = "IPv4";
      }
      push @network, {
        protocol        => "$match[0]",
        ipVersion       => "$ipVersion",
        portNumber      => "$match[2]",
        listeningDevice => "$match[1]",
        processId       => "$match[3]",
        processName     => "$match[4]"
      };
    }
  }
  return @network;
}
# End
1;
