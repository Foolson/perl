#!/usr/bin/perl

use warnings;
use strict;
use userModule;
use systemModule;
use Data::Dumper;

print "\# User Storage\n";
print "Size: ";
my $size = <>;
my %userStorage = userModule::userStorage($size);
print Dumper %userStorage;
print "\n";

print "\# Password Age\n";
print "Days: ";
my $days = <>;
my %passwordAge = userModule::passwordAge($days);
print Dumper %passwordAge;
print "\n";

print "\# User Logins\n";
my %userLogins = userModule::userLogins();
print Dumper %userLogins;
print "\n";

print "\# System network\n";
my @network = systemModule::network();
print Dumper @network;
