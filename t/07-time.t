#!perl

use strict;
use warnings;

use Test::Command tests => 3;

use Test::More;

## determine whether we can run perl or not

system qq($^X -e 1) and BAIL_OUT('error calling perl via system');

my $time = time_value(_sleep_secs(0.01));
ok( $time > 0.001 && $time < 0.1,
    'command sleeps between 0.001 and 0.1 seconds' );

time_lt(_sleep_secs(0.01), 0.1);

time_gt(_sleep_secs(0.01), 0.005);

## sleep given seconds using system calling perl
sub _sleep_secs
   {
   my ($seconds) = @_;

   my $MICROSECONDS_IN_ONE_SECOND = 1_000_000;
   $seconds *= $MICROSECONDS_IN_ONE_SECOND;

   return qq($^X -MTime::HiRes=usleep -e "usleep $seconds");
   }
