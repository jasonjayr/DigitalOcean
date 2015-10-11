package DOTestSetup;
use Test::More;
use strict;
#use Data::Dump qw(ddx);
my $tokens;

sub tokens { 
	$tokens ||=do $ENV{TEST_DO_TOKEN_LIST}||"../tokenlist.pl";
	$tokens->{read_only}||=$tokens->{read_write};

	return $tokens;
}
sub write_available { 
	my $t = tokens();

	if($t->{read_write}) { 
		return 1;
	} else { 
		return 0;
	}
}

sub collection_harness {
	my ($class, $do, $item, $expected, $per_item_test) = @_;

	my $list = $do->$item();
	ok($list->isa('DigitalOcean::Collection'), "Return object is a collection");
	ok($list->total > 0,                       "At least one item returned (".$list->total." $item from Digital Ocean)");

	my @list;
	while(my $obj = $list->next)  { push @list, $obj }
	foreach my $slug (sort keys %$expected) { 
		my ($item_instance,@extra) = grep { $_->slug eq $slug } @list;
		my $target = $expected->{$slug};
		ok(scalar(@extra) == 0,                     "$item:$slug: No extra item returned while looking for target item");
		$per_item_test->($slug, $item_instance, $target);
	}

}
1;
