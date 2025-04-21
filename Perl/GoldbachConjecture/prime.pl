#This script points out the even numbers which are not
#  the sum of the next smallest prime + prime.
#
# This script uses this algorithm:
#   even number = e
#   previousPrime(e-1) = p
#
#   e = p + p2
#   where p2 = e - p
#   But not all p2 are prime.

# IMPORTANT THINGS:
#  1)  The even numbers which are not the sum of primes
#      like the formula above.
#  2)  The prime number and the even number that it produced.
#  3)  The prime numbers that finaly did made the addition 
#      possible.
#  4)  The number of tries to get the correct result.


$MIN_EVEN_INT = $ARGV[0];
$MAX_EVEN_INT = $ARGV[1];


if ($MAX_EVEN_INT eq "" || $MIN_EVEN_INT eq "") {
	print "usage:  prime.pl [MIN EVEN INT] [MAX EVEN INT]\n\n";
	exit(0);
}

if ($MIN_EVEN_INT > $MAX_EVEN_INT) {
	$t = $MIN_EVEN_INT;
	$MIN_EVEN_INT = $MAX_EVEN_INT;
	$MAX_EVEN_INT = $t;
}

if (($MIN_EVEN_INT % 2) != 0) {
	$MIN_EVEN_INT++;
}

# traverse through all the even numbers and show that they 
#  are indeed the sum of two primes.
for($e=$MIN_EVEN_INT; $e <= $MAX_EVEN_INT; $e+=2) {
	
	$pH = &largestPrime($e);
	$tE = $e;
	while (&isPrime($e - $pH) == 0) {
		# Point out those who are not playing by the rules
		if ($tE == $e) {
			print "\t$e == ($pH,>>".($e-$pH)."<<)\n";
		}
		$tE-=2;
		$pH = &largestPrime($tE);
	}
        print "$e == ($pH,".($e-$pH).")\n";
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

sub largestPrime() {
        my($e) = @_;
        $found = 1;		#NOT PRIME

        $j = $i = $e-1;
        while (($j > 7) && ($found == 1)) {
                $found = 0;
                $i = $e-1;
                while(($found != 1) && ($i >= 3)) {
                        if (($j != $i) && (($j % $i) == 0)) {
                                $found = 1;
			} else {
                        	$i-=2;
			}
                }
		if ($found == 1) {
			$j-=2;
		}
        }
        
        return $j;
}
