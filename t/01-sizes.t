#!perl 
use strict;
use warnings FATAL => 'all';
use Test::More;
use DigitalOcean;
use DOTestSetup;
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


plan tests => 2 + (keys(%slug_test) * 3);

my $tokens = DOTestSetup->tokens();
my $do = DigitalOcean->new(oauth_token => $tokens->{read_only});

my $sizes = $do->sizes();

ok($sizes->isa('DigitalOcean::Collection'), "Return object is a collection");
ok($sizes->total > 0,                       "At least one size returned (".$sizes->total." sizes from digital Ocean)");

my @list;
while(my $obj = $sizes->next)  { push @list, $obj }
foreach my $slug (sort keys %slug_test) { 
	my ($twogb,@extra) = grep { $_->slug eq $slug } @list;
	my $target = $slug_test{$slug};
	ok(scalar(@extra) == 0,                     "$slug: No extra sizes returned while looking for target size");
	ok($twogb->price_hourly > 0,                "$slug: Price is non-zero");
	is($twogb->vcpus, $target->{vcpus},         "$slug: CPU count matches expected value");
	is($twogb->memory, $target->{memory},       "$slug: Memory count matches expected value");
}
