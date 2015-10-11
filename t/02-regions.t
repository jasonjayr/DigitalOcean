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
	'nyc1' => { 
		feature => 'backups',
		size    => '2gb',
		avilable => 1,
	},
	'nyc2' => { 
		feature => 'private_networking',
		size    => '4gb',
		avilable => 1,
	},
);


plan tests => 2 + (keys(%slug_test) * 4);

my $tokens = DOTestSetup->tokens();
my $do = DigitalOcean->new(oauth_token => $tokens->{read_only});

DOTestSetup->collection_harness(
	$do, 'regions', 
	\%slug_test,	
	sub {
		my ($slug, $item, $target) =  @_;

		ok(scalar(grep { $_ eq $target->{feature} } @{$item->features}), "$slug: feature $target->{feature} avilable");
		ok(scalar(grep { $_ eq $target->{size}    } @{$item->sizes}),    "$slug: size $target->{size} avilable");
		is($item->available, $target->{avilable},                        "$slug: availability matches expected value");
	}
)

