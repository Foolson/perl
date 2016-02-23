#!/usr/bin/perl

use warnings;
use strict;
use userModule;
use systemModule;
use Data::Dumper;
use Text::CSV;
###
# Subrutines
###
sub createCSV {
  my $csv = Text::CSV->new ( { binary => 1 } ) or die "Cannot use CSV: ".Text::CSV->error_diag ();
  $csv->eol ("\r\n");
  $csv->sep_char (";");
  my $filename = shift;
  open(my $fh, '>', "$filename");
  $csv->print ($fh, $_) for @_;
  close $fh;
}
sub convertAoh {
  my @query = split / /,shift;
  my @aoh = @_;
  my @aoa;
  for my $i (0...$#aoh) {
    my @hash;
    for my $j (0...$#query) {
      push @hash, $aoh[$i]{$query[$j]};
    }
    push @aoa, \@hash;
  }
  return @aoa;
}
###
# Generate .csv-files
###
my @network;
my $networkColumns = "portNumber listeningDevice processName";
# Network tcp ipv4
@network = @{systemModule::network("tcp ipv4")};
createCSV("/root/tcp-ipv4.csv",convertAoh($networkColumns, @network));
# Network tcp ipv6
@network = @{systemModule::network("tcp ipv6")};
createCSV("/root/tcp-ipv6.csv",convertAoh($networkColumns, @network));
# Network udp ipv4
@network = @{systemModule::network("udp ipv4")};
createCSV("/root/udp-ipv4.csv",convertAoh($networkColumns, @network));
# Network udp ipv6
@network = @{systemModule::network("udp ipv6")};
createCSV("/root/udp-ipv6.csv",convertAoh($networkColumns, @network));
# Service status
my @serviceQuery = ("fprintd","firewalld","sshd","named","httpd","cups");
# User data
my %userLogins = %{userModule::userLogins()};
my %passwordAge = %{userModule::passwordAge(100)};
my %userStorage = %{userModule::userStorage(0)};
my @users = keys %userLogins;
my @userData;
for my $i (0...$#users) {
  my @array = ("$users[$i]","$userLogins{$users[$i]}","$passwordAge{$users[$i]}","$userStorage{$users[$i]}");
  push @userData, \@array;
}
print Dumper @userData;
createCSV("/root/userData.csv",@userData);
