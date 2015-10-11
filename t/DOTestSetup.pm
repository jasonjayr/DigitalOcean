package DOTestSetup;
use Test::More;
my $tokens;
sub tokens { 
	$tokens ||=do "../tokenlist.pl";
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

1;
