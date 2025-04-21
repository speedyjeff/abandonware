#!/usr/bin/perl

print "Content-type: text/html\n\n";

read(STDIN,$in,$ENV{'CONTENT_LENGTH'});

@in=split('&',$in);

foreach (@in) {
	($nam,$val)=split('=',$_);
	$val =~ s/\+/ /g;
	$in{$nam} = $val;
}

if ($in{'p'} eq "see you on the other side") {
print <<END;
<HTML>
<HEAD>
<BODY BGCOLOR=white>
<CENTER>
END
	if ($in{'n'} == 1) {
		$file="visitors.txt";
	} else {
		$file = "invaliduser.txt";
	}

print <<END;
<TABLE BORDER=0>
<TR><TD WIDTH=600>
END

	open(TEXT,"$file") || die "can't open $file";
	while (<TEXT>) { print }
	close(TEXT);

print <<END;
</TD></TR>
</TABLE>
</CENTER>
</BODY>
</HTML>
END
	exit(0);
}

#check to see if they have been here before
#if not implant a cookie
$http_cookie = $ENV{'HTTP_COOKIE'};

if ($http_cookie) {
	@allcookies = split(/;/,$http_cookie);
	
	$found=0;

	foreach $each_cookie (@allcookies) {
		if ($each_cookie =~ /config=/i) {
		   $http_cookie.=$each_cookie;
		   $found=1;
		   }
		}
}
$tdate=`date`;
if ($found != 1) {
	print "Set-cookie: config=count:1 time:$tdate; expires=Monday, 31-Dec-99 12:00:00 GMT\n\n";
    }       
 else {
    ($dummy1,$config) = split(/=/,$http_cookie);
    @array = split(/ /,$config);
    foreach $var_value (@array){
		($var,$value) = split(/:/,$var_value);
		$cookies{$var} = $value;
	}
	$cookies{'count'}++;
	print "Set-cookie: config=count:$cookies{'count'} time:$tdate; expires=Monday, 31-Dec-99 12:00:00 GMT\n\n";
}

print <<HTMLOUT;
<HTML>
<HEAD>
<TITLE>This nolonger works</TITLE>
</HEAD>
<BODY BGCOLOR="red">
<FONT COLOR="white">
HTMLOUT
if (found == 1) {
print <<HTMLOUT;
<H3>So you have tried this before $cookies{'count'} times to be exact.  The last time was at $cookies{'time'}.</H3><BR><BR>
HTMLOUT
}
print <<HTMLOUT;
<P>I was told that there was a problem with people doing this so I decided to do somenthing about it and well I finally got around to it.  There is no longer any way to access this page without useing you correct ID and PASSWORD. <B> Thanks have a nice day.</B><I> ...</I></P>
</FONT>
</BODY>
</HTML>
HTMLOUT


