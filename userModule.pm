#!/usr/bin/perl
package userModule;
use warnings;
use strict;

my $f;

# Get min and max UID for regular users
$f = "/etc/login.defs";
open FH, "<", "$f" or die "Can't open $f: $!";
my @UID;
while( my $line = <FH> ) {
  if ( $line =~ /^(UID_M\w{2}\s+)\d+/ ) {
    $line =~ s/\D+//;
    push @UID, $line;
  }
}
close FH or die "Can't close $f: $!";

my $firstUID = $UID[0];
my $lastUID = $UID[1];

# Get list of regular users from /etc/passwd
my @passwd;
$f = "/etc/passwd";
open FH, "<", "$f" or die "Can't open $f: $!";
while( my $line = <FH> ) {
  my @match = ($line =~ /(?<=:x:)\d+/g);
  if ( $match[0] >= $firstUID and $match[0] <= $lastUID ) {
    @match = ($line =~ /\S+(?=:x:)/g);
    push @passwd, $match[0];
  }
}
close FH or die "Can't close $f: $!";

my @users = @passwd;
chomp @users;

# Create hash with regular users as keys and their number of logins as values
sub userLogins {
  my %userLogins;
  for my $i (0 ... $#users) {
    my $user = $users[$i];
    my @last = `last $user`;
    my @logins = @last;
    $userLogins{$user} = ($#logins - 1);
  }
  return %userLogins;
}

# Create hash with users and the number of days since password change and only add users if days exeeds $days
sub passwordAge {
  my %passwordAge;
  my $days = shift;
  my @epochSeconds = `date +%s`;
  my $epochDays = ($epochSeconds[0] / 86400);
  for my $i (0...$#users) {
    my @grep = `grep $users[$i] /etc/shadow | cut -d: -f3`;
    chomp @grep;
    if ( $grep[0] < ($epochDays - $days)) {
      @passwordAge{$users[$i]} = int($epochDays - $grep[0]);
    }
  }
  return %passwordAge;
}

# Add users and their storage size to a hash if it exceeds $size

sub userStorage {
  my %userStorage;
  my $size = shift;
  for my $i (0...$#users) {
    my @du = `du -b /home/$users[$i]`;
  
    my @match = ($du[0] =~ /^\d+/g);
    
    my $mebibyte = int($match[0] / 1048576);
    if ( $mebibyte >= $size ) {
      $userStorage{$users[$i]}=$mebibyte;
    }
  }
  return %userStorage;
}
1;
