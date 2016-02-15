#!/usr/bin/perl

use warnings;
use strict;

my $f;

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

my %userLogins;
for my $i (0 ... $#users) {
  my $user = $users[$i];
  my @last = `last $user`;
  my @logins = @last;
  $userLogins{$user} = ($#logins - 1);
}
print %userLogins."\n";

my %passwd;
my $days = 13;
my @epochSeconds = `date +%s`;
my $epochDays = ($epochSeconds[0] / 86400);
for my $i (0...$#users) {
  my @grep = `grep $users[$i] /etc/shadow | cut -d: -f3`;
  chomp @grep;
  if ( $passwd{$users[$i]} < ($epochDays - $days)) {
    @passwd{$users[$i]} = $grep[0];
  }
}
print %passwd."\n";

my %userStorage;
my $size = 0;
for my $i (0...$#users) {
  my @du = `du -b /home/$users[$i]`;

  my @match = ($du[0] =~ /^\d+/g);
  
  my $mebibyte = int($match[0] / 1048576);
  if ( $mebibyte > $size ) {
    $userStorage{$users[$i]}=$mebibyte;
  }
}
print %userStorage."\n";