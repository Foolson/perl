#!/usr/bin/perl

use warnings;
use strict;
use userModule;
use systemModule;
use Text::CSV;
use MIME::Entity;
use Email::Sender::Simple qw(sendmail);
use Email::Sender::Transport::SMTP qw();
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
sub email {
  my $top;
  my @header = split /;/, shift;
  my @files = split /;/, shift;
  $top = MIME::Entity->build(From     => "$header[0]",
                             To       => "$header[1]",
                             Subject  => "$header[2]",
                             Boundary => "$header[3]",
                             Type     => "multipart/mixed");
  for my $i (0...$#files) {
    $top->attach(Path     => "$files[$i]",
                 Type     => "text/csv");
  }
  sendmail($top->stringify);
}
###
# Generate .csv-files
###
my @network;
my $networkColumns = "portNumber listeningDevice processName";
# Network tcp ipv4
@network = @{systemModule::network("tcp ipv4")};
createCSV("/tmp/tcp-ipv4.csv",convertAoh($networkColumns, @network));
# Network tcp ipv6
@network = @{systemModule::network("tcp ipv6")};
createCSV("/tmp/tcp-ipv6.csv",convertAoh($networkColumns, @network));
# Network udp ipv4
@network = @{systemModule::network("udp ipv4")};
createCSV("/tmp/udp-ipv4.csv",convertAoh($networkColumns, @network));
# Network udp ipv6
@network = @{systemModule::network("udp ipv6")};
createCSV("/tmp/udp-ipv6.csv",convertAoh($networkColumns, @network));
# Service status
my @serviceQuery = ("fprintd","firewalld","sshd","named","httpd","cups");
my @serviceStatus;
for my $i (0...$#serviceQuery) {
  my $status = (systemModule::serviceStatus($serviceQuery[$i]) ? "yes" : "no");
  my @array = ("$serviceQuery[$i]", $status);
  push @serviceStatus, \@array;
}
createCSV("/tmp/serviceStatus.csv",@serviceStatus);
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
createCSV("/tmp/userData.csv",@userData);
###
# Send E-Mail
###
my $time = time;
my $date = `date`;
email("task5\.3\@localhost;d15johol\@localhost;Task 5\.3 mail at $date;==== Task 5\.3 ==== Epoch=$time ====","/tmp/tcp-ipv4.csv;/tmp/tcp-ipv6.csv;/tmp/udp-ipv4.csv;/tmp/udp-ipv6.csv;/tmp/serviceStatus.csv;/tmp/userData.csv");
