#!/usr/bin/perl
################## METADATA ##################
# NAME: Johan Olsson
# USERNAME: d15johol
# COURSE: IT341G
# ASSIGNMENT: Task 5.1/5.2
# DATE OF LAST CHANGE: 2016-02-29
##############################################

use warnings;
use strict;
use userModule;
use systemModule;
use Data::Dumper;

# Print hash sorted or not sorted
sub printHash {
  my %hash = %{$_[0]};
  my $sortAfter = $_[1];
  my $longestString = longestString(keys %hash);
  my $padding = "%-$longestString"."s  %s\n";
  # Print sorted hash after values
  if ( $sortAfter eq "values" ){
    foreach my $key (sort { $hash{$b} <=> $hash{$a} } keys %hash) {
        printf $padding, $key, "=>  $hash{$key}";
    }
  }
  # Print sorted hash after keys
  elsif ( $sortAfter eq "keys" ){
    foreach my $key (sort {lc $a cmp lc $b} keys %hash) {
      printf $padding, $key, "=>  $hash{$key}";
    }
  }
  # Print hash without sorting
  elsif ( $sortAfter eq "none" ){
    foreach my $key (keys %hash) {
      printf $padding, $key, "=>  $hash{$key}";
    }
  }
}
# Find the longest string in array
sub longestString {
  my @keys = @_;
  my $first = length($keys[0]);
  my $longest = 0;
  for my $i (0...$#keys){
    my $current = length($keys[$i]);
    if ($current > $first){
      $longest = $current;
    }
    else {
      $longest = $first;
    }
  }
  return $longest;
}

# Ask after MiB to print users who stored over that ammount
# Also ask for what so sort after
print '###'."\n";
print '#'." User Storage"."\n";
print '###'."\n";
print "List users who stored over \'n\' MiB (0 - ∞): ";
my $minSize = <STDIN>;
chomp $minSize;
print "Sort list after (keys,values,none): ";
my $sortAfter = <STDIN>;
chomp $sortAfter;
printHash(userModule::userStorage($minSize),$sortAfter);

# Ask for what so sort after and print usernames and ammount of logins
print '###'."\n";
print '#'." User Logins"."\n";
print '###'."\n";
print "Sort list after (keys,values,none): ";
$sortAfter = <STDIN>;
chomp $sortAfter;
printHash(userModule::userLogins(),$sortAfter);

# Ask for ammount of days and print users and if they changed the password in those days
# Also ask for what so sort after
print '###'."\n";
print '#'." User Password Age"."\n";
print '###'."\n";
print "List users who did not change their passwords in the last \'n\' days (0 - ∞): ";
my $days = <STDIN>;
chomp $days;
print "Sort list after (keys,values,none): ";
$sortAfter = <STDIN>;
chomp $sortAfter;
printHash(userModule::passwordAge($days),$sortAfter);

# Ask to input a query for listening sockets and output the data
print '###'."\n";
print '#'." System Listening Sockets"."\n";
print '###'."\n";
print "Query: ";
my $query = <STDIN>;
chomp $query;
print Dumper @{systemModule::network($query)};

# Ask user to input service name and output it's status
print '###'."\n";
print '#'." System Service Status"."\n";
print '###'."\n";
print "Query (Service name): ";
$query = <STDIN>;
chomp $query;
my $status = systemModule::serviceStatus($query) ? "It\'s alive\!" : "He\'s dead, Jim...";
print "$query"."  =>  ".$status."\n";
