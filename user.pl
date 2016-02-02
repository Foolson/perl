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

#my @passwd = `getent passwd | awk -F: '\($firstUID <= \$3\) && \(\$3 <= $lastUID\) {print \$1}'`;

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

my %usersLogins;
for my $i (0 ... $#users) {
  my $user = $users[$i];
  my @last = `last $user`;
  my @logins = @last;
  $usersLogins{$user} = ($#logins - 1);
}

foreach my $key (sort {lc $a cmp lc $b} keys %usersLogins) {
  print $key.":".$usersLogins{$key}."\n";
}
print "\n";
foreach my $key (sort { $usersLogins{$b} <=> $usersLogins{$a} or $a cmp $b } keys %usersLogins) {
  print $key.":".$usersLogins{$key}."\n";
}
