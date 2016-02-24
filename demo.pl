#!/usr/bin/perl

use warnings;
use strict;
use userModule;
use systemModule;
use Data::Dumper;

sub printHash {
  my %hash = %{$_[0]};
  my $sortAfter = $_[1];
  my $longestString = longestString(keys %hash);
  my $padding = "%-$longestString"."s  %s\n";
  if ( $sortAfter eq "values" ){
    foreach my $key (sort { $hash{$b} <=> $hash{$a} } keys %hash) {
        printf $padding, $key, "=>  $hash{$key}";
    }
  }
  elsif ( $sortAfter eq "keys" ){
    foreach my $key (sort {lc $a cmp lc $b} keys %hash) {
      printf $padding, $key, "=>  $hash{$key}";
    }
  }
  elsif ( $sortAfter eq "none" ){
    foreach my $key (keys %hash) {
      printf $padding, $key, "=>  $hash{$key}";
    }
  }
}
sub longestString {
  my @keys = @_;
  my $first = length($keys[0]);
  my $longest;
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

print '###'."\n";
print '#'." User Storage"."\n";
print '###'."\n";
print "Show user who stored over \"x\" (MiB): ";
my $minSize = <STDIN>;
chomp $minSize;
print "Sort list after (keys,values,none): ";
my $sortAfter = <STDIN>;
chomp $sortAfter;
printHash(userModule::userStorage($minSize),$sortAfter);
print '###'."\n";
print '#'." User Logins"."\n";
print '###'."\n";
print "Sort list after (keys,values,none): ";
$sortAfter = <STDIN>;
chomp $sortAfter;
printHash(userModule::userLogins(),$sortAfter);
print '###'."\n";
print '#'." User Password Age"."\n";
print '###'."\n";
print "Did the users change their passwords in the last \"x\" days? (Days in numbers): ";
my $days = <STDIN>;
chomp $days;
print "Sort list after (keys,values,none): ";
$sortAfter = <STDIN>;
chomp $sortAfter;
printHash(userModule::passwordAge($days),$sortAfter);

print '###'."\n";
print '#'." System Listening Sockets"."\n";
print '###'."\n";
print "Query (Divided by whitespace): ";
my $query = <STDIN>;
chomp $query;
print Dumper @{systemModule::network($query)};

print '###'."\n";
print '#'." System Service Status"."\n";
print '###'."\n";
print "Query (Service name): ";
$query = <STDIN>;
chomp $query;
my $status = systemModule::serviceStatus($query) ? "Yes" : "No";
print "$query"."  =>  ".$status."\n";
