#!/usr/bin/perl

package BobboBot::excuse;

use warnings;
use strict;

use BobboBot::users;
use POSIX;

sub run
{
  open(my $fh, '<', 'excuses.list');
  my @excuses = <$fh>;
  close($fh);

  my $i = floor(rand(@excuses));
  my $excuse = $excuses[$i];
  return $excuse;
}

sub help
{
  return 'excuse - Returns a random excuse, courtesy of http://pages.cs.wisc.edu/~ballard/bofh/';
}

sub auth
{
  return accessLevel('normal');
}

BobboBot::module::addCommand('excuse', 'run', \&BobboBot::excuse::run);
BobboBot::module::addCommand('excuse', 'help', \&BobboBot::excuse::help);
BobboBot::module::addCommand('excuse', 'auth', \&BobboBot::excuse::auth);

1;
