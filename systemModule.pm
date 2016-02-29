#!/usr/bin/perl
################## METADATA ##################
# NAME: Johan Olsson
# USERNAME: d15johol
# COURSE: IT341G
# ASSIGNMENT: Task 5.2
# DATE OF LAST CHANGE: 2016-02-29
##############################################

package systemModule;

use warnings;
use strict;
use List::Compare;

sub network {
  my @query = split / /, shift;
  my @network;
  my @netstat = `netstat -plntu`;
  chomp @netstat;
  for my $i (0...$#netstat){
    my @match = $netstat[$i] =~ /^(\w{3}).+\d+\s(.+):(\d+).+\s(\d+)\/(\S+)/g;
    if ( length $match[0] ) {
      if ( $match[1] =~ /:/ ) {
        push @match, "ipv6";
      }
      else {
        push @match, "ipv4";
      }
      my $lc = List::Compare->new(\@query, \@match);
      if ( $lc->is_LsubsetR ) {
        my %hash = (
          protocol         => "$match[0]",
          ipVersion        => "$match[5]",
          portNumber       => "$match[2]",
          listeningDevice  => "$match[1]",
          processId        => "$match[3]",
          processName      => "$match[4]"
        );
        push @network, \%hash;
      }
    }
  }
  return \@network;
}
sub serviceStatus {
  my $service = shift;
  my $serviceStatus = 0;
  my @systemctl = `systemctl status $service`;
  if ( $systemctl[2] =~ /Active: active/ ) {
    $serviceStatus = 1;
  }
  return $serviceStatus;
}
1;
