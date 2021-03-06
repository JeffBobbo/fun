#!/usr/bin/perl

package BobboBot::roll;

use warnings;
use strict;

use BobboBot::math;
use BobboBot::users;
use POSIX;

sub run
{
  my $max = shift(@{$_[0]->{arg}});
  my ($who) = split('!', $_[0]->{who});

  if (!defined $max)
  {
    return 'Usage: !roll (max)';
  }
  if (!isNumber($max))
  {
    return 'Argument must be a number';
  }
  if ($max <= 1)
  {
    return 'Can\'t roll on less than a two';
  }
  if (floor($max) != $max)
  {
    return 'Can\'t roll on a fraction';
  }

  my $rolled = 1 + floor(rand($max+0.5));
  return $who . ' rolled a ' . commifyNumber($rolled) . ' out of ' . commifyNumber($max) . '.';
}

sub help
{
  return '!roll (max) - Roll for a random integer in the range [1, max].';
}

sub auth
{
  return accessLevel('normal');
}

BobboBot::module::addCommand('roll', 'run', \&BobboBot::roll::run);
BobboBot::module::addCommand('roll', 'help', \&BobboBot::roll::help);
BobboBot::module::addCommand('roll', 'auth', \&BobboBot::roll::auth);

1;
