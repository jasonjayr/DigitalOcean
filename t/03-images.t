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
	'ubuntu-14-04-x64' => { 
		distribution => 'Ubuntu',
		public       => 1,
		region       => 'nyc2',
	},
	'redmine' => { 
		distribution => 'Ubuntu',
		public       => 1,
		region       => 'nyc1',
	},
);


plan tests => 2 + (keys(%slug_test) * 4);

my $tokens = DOTestSetup->tokens();
my $do = DigitalOcean->new(oauth_token => $tokens->{read_only});
DOTestSetup->collection_harness(
	$do, 'images', 
	\%slug_test,	
	sub {
		my ($slug, $item, $target) =  @_;
		is($item->distribution, $item->{distribution},                 "$slug: distribution matches expected value");
		is($item->public,       $item->{public},                       "$slug: public status matches expected value");
		ok(scalar(grep { $_ eq $target->{region} } @{$item->regions}), "$slug: available in region $target->{region}");
	}
)

