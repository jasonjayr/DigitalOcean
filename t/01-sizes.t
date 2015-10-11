#!perl 
use strict;
use warnings FATAL => 'all';
use Test::More;
use DigitalOcean;
require 't/DOTestSetup.pm';
use Data::Dump qw(ddx);


my %slug_test = (
	# NOTE: Digital ocean is free to change these properties on a whim.  In theory they should stay the same 
	# all the time.
	'2gb' => { 
		memory => '2048',
		vcpus  => 2
	},
	'4gb' => { 
		memory => '4096',
		vcpus  => 2
	},
);


plan tests => 2 + (keys(%slug_test) * 4);

my $tokens = DOTestSetup->tokens();
my $do = DigitalOcean->new(oauth_token => $tokens->{read_only});

DOTestSetup->collection_harness(
	$do, 'sizes', 
	\%slug_test,	
	sub {
		my ($slug, $item, $target) =  @_;

		ok($item->price_hourly > 0,                "$slug: Price is non-zero");
		is($item->vcpus, $target->{vcpus},         "$slug: CPU count matches expected value");
		is($item->memory, $target->{memory},       "$slug: Memory count matches expected value");
	}
)

