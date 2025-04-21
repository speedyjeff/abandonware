#Searches for patterns in a list of numbers.

$fileNam = "pattern.txt";

### $N == length of datam string
### $M == length of patern
##  @p is the patern
##  @a is the datam string

unlink @a;
unlink @p;

# READ IN ARRAY's
$ct = 0;
open(IN,"$fileNam") || die "cant open $fileNam";
while (<IN>) {
	chomp($_);
	$a[$ct] = $_;
	$p[$ct++] = $_;
}
close IN;


# ASSIGN LENGTH's
$N = @a;
$M = 3;
# Global for TAB
$currPOS = 0;

while ($M <= $N) {
	print "\nSize:  $M\n";
	printArr($N,@a);
	print "\n";
	$result = &kmpSearch();
	$M++;
}

exit(0);


# FUNCTIONS
sub printHdr() {
	my($result) = @_;
	
	&tab($result-($M+$currPOS));
	&printArr($M,@p);
	
	$currPOS = $result;
}

sub printArr() {
	my($t,@t) = @_;

	for($k=0; $k < $t; $k++) {
		if ($t[$k] < 10) {
			print " ";
		}
		print "$t[$k]";
	}
}

sub tab() {
	my($t) = @_;

	for($k = 0; $k < $t; $k++) {
		print "  ";
	}
}

sub kmpSearch () {
	&initnext();
	$i=0;
	$j=0; 
	while ($i <= $N) {
		$j = 0;
		while ($j<$M && $i<=$N) {
			if ($j == -1 || $a[$i] == $p[$j]) {
		      		$i++; 
				$j++;
			} else {
				$j = $next[$j];
			}
		}
	
		if ($j >= $M) { 
			&printHdr($i-$M);
		} 
	} #while
}

sub initnext() {
	$i = 0;
	$j = -1;
	unlink @next;
	for($k=0; $k<$M; $k++) {
		$next[$k] = 0;
	}
	$next[0] = -1;

	while ($i < $M) {
		if ($j == -1 || $p[$i] == $p[$j]) {
			$i++;
			$j++;
			$next[$i]=$j;
		} else {
			$j = $next[$j];
		}
	}
}
