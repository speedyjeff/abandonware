#!/usr/bin/perl

print "Content-type:  text/html\n\n";

read(STDIN,$in,$ENV{'CONTENT_LENGTH'});


(@in) = split('&',$in);


foreach $var (@in) {
	($nam,$val) = split('=',$var);
	$val =~ s/\+/ /g;
	$val =~ s/%([\da-z]{1,2})/pack(C,hex($1))/eig;
	if ($nam eq "xst") {	
		(@x) = split(',',$val);
	} elsif ($nam eq "yst") {
		(@y) = split(',',$val);
	} else {
		$form{$nam} = $val;
	}
	
}


print <<APPLET; 
<HTML>
<HEAD>
<TITLE>View their Signatures</TITLE>
</HEAD>
<BODY BGCOLOR="black">
<CENTER>
<APPLET CODE="SigDecoder.class" CODEBASE="http://..." HEIGHT=150 WIDTH=590>
<PARAM NAME=fade VALUE="down">
<PARAM NAME=fadeby VALUE="20">
<PARAM NAME=backr VALUE="0">
<PARAM NAME=backg VALUE="0">
<PARAM NAME=backb VALUE="0">
<PARAM NAME=forer VALUE="255">
<PARAM NAME=foreg VALUE="0">
<PARAM NAME=foreb VALUE="0">
<PARAM NAME=borderr VALUE="255">
<PARAM NAME=borderg VALUE="0">
<PARAM NAME=borderb VALUE="0">
<PARAM NAME=borderthickness VALUE="10">
<PARAM NAME="siz" VALUE="$form{'siz'}">
APPLET

$ct = 0;
for($i=0; $i<$form{'siz'}; $i++) {
print <<PARAM;
<PARAM NAME="x$ct" VALUE="$x[$i]">
PARAM
$ct++;
}

$ct=0;
for($i=0; $i<$form{'siz'}; $i++) {
print <<PARAM;
<PARAM NAME="y$ct" VALUE="$y[$i]">
PARAM
$ct++;
}

print <<ENDTAG;
</APPLET>
</CENTER>
</BODY>
</HTML>
ENDTAG


