#!/usr/bin/perl

use warnings;
use strict;
use userModule;
use systemModule;
use Data::Dumper;

print "\# User Storage START\n";
print "Size: ";
my $size = <STDIN>;
my %userStorage = userModule::userStorage($size);
print Dumper \%userStorage;
print "\# User Storage END\n\n";

print "\# User Password Age START\n";
print "Days: ";
my $days = <STDIN>;
my %passwordAge = userModule::passwordAge($days);
print Dumper \%passwordAge;
print "\# User Password Age END\n\n";

print "\# User Logins START\n";
my %userLogins = userModule::userLogins();
print Dumper \%userLogins;
print "\# User Logins END\n\n";

print "\# System network START\n";
print "Query: ";
my $query = <STDIN>;
chomp $query;
my @network = systemModule::network($query);
print Dumper \@network;
print "\# System network END\n\n";

print "\# System Service Status START\n";
print "Service name: ";
my $serviceName = <STDIN>;
chomp $serviceName;
my $serviceStatus = systemModule::serviceStatus($serviceName);
print Dumper $serviceStatus;
print "\# System Service Status END\n";
