#!/usr/bin/perl

use warnings;
use strict;
use userModule;
use systemModule;

print "\# User Storage\n";
print "Size: ";
my $size = <>;
my %userStorage = userModule::userStorage($size);
print %userStorage;
print "\n\n";

print "\# Password Age\n";
print "Days: ";
my $days = <>;
my %passwordAge = userModule::passwordAge($days);
print %passwordAge;
print "\n\n";

print "\# User Logins\n";
my %userLogins = userModule::userLogins();
print %userLogins;
print "\n";
