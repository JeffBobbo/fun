#!/usr/bin/perl

package BobboBot::core;

use warnings;
use strict;

use BobboBot::users;
use POSIX;

my $source = 'core.list';

sub run
{
  my $match = join(' ', @{$_[0]->{arg}});

  open(my $fh, '<', $source) or return 'Failed to open core list: ' . $1;
  my @lines = <$fh>;
  close($fh);

  for (my $i = @lines - 1; $i >= 0; --$i)
  {
    splice(@lines, $i, 1) if (length($match) && $lines[$i] !~ /$match/i);
  }

  return 'No quotes found!' if (@lines == 0);
  return $lines[floor(rand(@lines))];
}

sub help
{
  return '!core [search] - Returns a quote from a Portal core, regex enabled search';
}

sub auth
{
  return accessLevel('normal');
}

BobboBot::module::addCommand('core', 'run', \&BobboBot::core::run);
BobboBot::module::addCommand('core', 'help', \&BobboBot::core::help);
BobboBot::module::addCommand('core', 'auth', \&BobboBot::core::auth);

1;
