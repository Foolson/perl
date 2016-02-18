#!/usr/bin/perl

package systemModule;

use warnings;
use strict;

sub network{
  my @network;
  my @netstat = `netstat -plntu`;
  chomp @netstat;
  for my $i (0...$#netstat){
    my $ipVersion = "4";
    my @match = $netstat[$i] =~ /^(\w{3}).+\d+\s(.+):(\d+).+\s(\d+)\/(\S+)/g;
    if ( length $match[0] ) {
      if ( $match[1] =~ /:/ ) {
        $ipVersion = "6";
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
1;
