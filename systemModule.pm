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

# Get data about listening sockets from 'netstat'
sub network {
  # Get a list od queries and split the into an array
  my @query = split / /, shift;
  my @network;
  # Store 'netstat' in an array
  my @netstat = `netstat -plntu`;
  chomp @netstat;
  for my $i (0...$#netstat){
    # Regex out the parts that i want
    my @match = $netstat[$i] =~ /^(\w{3}).+\d+\s(.+):(\d+).+\s(\d+)\/(\S+)/g;
    # Find the ip-version and push it in the same array as the rest of the data
    if ( length $match[0] ) {
      if ( $match[1] =~ /:/ ) {
        push @match, "ipv6";
      }
      else {
        push @match, "ipv4";
      }
      # Compare the queries with the data from 'netstat'
      my $lc = List::Compare->new(\@query, \@match);
      # If the queries exist in the data from 'netstat'
      # Then create a hash and push it into an array
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
  # Return the data
  return \@network;
}
# Get status of service
sub serviceStatus {
  my $service = shift;
  my $serviceStatus = 0;
  # Store output of 'systemctl status' in an array
  my @systemctl = `systemctl status $service`;
  # Find out with regex if the service is active
  if ( $systemctl[2] =~ /Active: active/ ) {
    $serviceStatus = 1;
  }
  # Return 0 if not running and 1 if running
  return $serviceStatus;
}
1;
