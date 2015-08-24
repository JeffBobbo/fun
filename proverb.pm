#!/usr/bin/perl

package BobboBot::proverb;

use warnings;
use strict;

use BobboBot::users;

use LWP::Simple;

sub run
{
  my $page = get('http://www.idefex.net/b3taproverbs/');
  if (!defined $page) {
    return 'Couldn\'t get the connect to the generator, maybe the server is down?';
  }
  if ($page =~ /Your random proverb is:<br\/><br\/><center><h2>((?:.|\r|\n)*?)<\/h2><\/center>/) {
    my $proverb = $1;
    $proverb =~ s/(?:\r|\n)//g;
    return $proverb;
  }
  return 'Couldn\'t find the proverb, maybe the page has changed?';
}

sub help
{
  return 'proverb - Returns a random proverb (of questionable sense), courtesy of http://www.idefex.net/b3taproverbs/';
}

sub auth
{
  return accessLevel('normal');
}

BobboBot::module::addCommand('proverb', 'run', \&BobboBot::proverb::run);
BobboBot::module::addCommand('proverb', 'help', \&BobboBot::proverb::help);
BobboBot::module::addCommand('proverb', 'auth', \&BobboBot::proverb::auth);

1;
