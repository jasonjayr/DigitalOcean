#!perl -T
use strict;
use warnings FATAL => 'all';
use Test::More;


BEGIN {
    plan tests => 1;

    use_ok( 'DigitalOcean' ) || print "Bail out!\n";
}

diag( "Testing DigitalOcean $DigitalOcean::VERSION, Perl $], $^X" );
