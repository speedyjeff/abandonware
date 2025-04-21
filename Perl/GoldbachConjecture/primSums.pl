#If you can prove that there was a finite number of primes
#  then this script would prove that not all even numbers 
#  are the sum of primes.
#
# Method:
#  For a given largest prime, it the largest even number 
#    which the prime is an additive factor:  e = p1 + p2
#    It then shows all the even numbers that were not
#    mapped to.

$MAX_PRIME1 = $ARGV[0];

if ($MAX_PRIME1 eq "" || (&isPrime($MAX_PRIME1) == 0)) {
	print "usage:  primSums.pl [MAX _PRIME_ INT]\n\n";
	exit(0);
}
$MAX_PRIME0 = &lastPrime($MAX_PRIME1); 
$MAX_PRIME2 = &nextPrime($MAX_PRIME1);

unlink @primes;		# array of seen primes
unlink @evens;		# array of evens
$e = 0;			# current even number
$pInx = 0;		# prime array index
$p1 = 1;		# prime 1

$primes[$pInx++] = 1;

# INIT EVEN TO ALL FALSE (NOT MAPPED TOO) 
for($j=2; $j<=(($MAX_PRIME1+$MAX_PRIME2)/2); $j++) {
	$evens[$j] = 0;
}

# Add all possible prime pairs	
while ($p1 <= $MAX_PRIME1) {
	$p1 = &nextPrime($p1);	
	for($j=0; $j<$pInx; $j++) {
		$e = $p1 + $primes[$j];
		if ($evens[$e / 2] == 0 && $p1<=$MAX_PRIME1 && $primes[$j]<=$MAX_PRIME1) {
			print "$e ==> ($p1,$primes[$j])\n";
		}
		$evens[$e / 2] = 1;
	}
	$primes[$pInx++] = $p1;
}


# Print Even Mapped to array
print "\n\nPrime numbers             : 1 <= PRIME <= $MAX_PRIME1\n";
print "Even numbers NOT mapped to: 4 <=   e   <= ".($MAX_PRIME0+$MAX_PRIME1)."\n";
for($j=2; $j<=(($MAX_PRIME1+$MAX_PRIME2)/2); $j++) {
	if ($evens[$j] == 0 && ($j*2) <= ($MAX_PRIME1+$MAX_PRIME0)) {
		print "e = ".($j*2)."\n";
	}
}

# Functions
sub nextPrime() {
	my($p) = @_;
	$p+=2;

	while (&isPrime($p) == 0) {
		$p+=2;
	}

	return $p;
}

sub lastPrime() {
	my($p) = @_;
	$p-=2;

	while (&isPrime($p) == 0) {
		$p-=2;
	}

	return $p;
}

sub isPrime() {
	my($e) = @_;
	$found = 1;
	
	$j = $k = $e;
	while ($found != 0 && $j >= 3) {
		if (($j != $k) && ($k % $j) == 0) {
			$found = 0;
		}
		$j-=2;
	}

	return $found;
}

