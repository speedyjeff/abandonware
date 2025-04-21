#!/usr/bin/perl

print "Content-type: text/html\n\n";

read(STDIN,$in,$ENV{'CONTENT_LENGTH'});

(@in) = split('&',$in);

foreach $var (@in) {
	($nam,$val) = split('=',$var);
	$val =~ s/\+/ /g;
	$val =~ s/%([\da-z]{1,2})/pack(C,hex($1))/eig;
	$form{$nam} = $val;
}

$form{'biolevel'} = 1;

open(FILEVAR,">>userlist.txt") || die "can't open userlist.txt";
print FILEVAR "$form{'nam'}\n";
close(FILEVAR);

open(FILEVAR,">user/$form{'nam'}.txt") || die "can't open user/$form{'nam'}";
print FILEVAR "nam=$form{'nam'}:pas=$form{'pas'}:biolevel=$form{'biolevel'}:pc=$form{'pc'}:hc=$form{'hc'}:vc=$form{'vc'}:width=$form{'width'}:height=$form{'height'}:hdiff=$form{'hdiff'}:vdiff=$form{'vdiff'}:heightdiff=$form{'heightdiff'}:widthdiff=$form{'widthdiff'}:count=$form{'count'}\n";
print FILEVAR "xst=$form{'xst'}\n";
print FILEVAR "yst=$form{'yst'}\n";
close(FILEVAR);

open(MAIL,"| mail ...") || die "can't open mail";
print MAIL "Name: $form{'nam'} \n";
print MAIL "Password: $form{'pas'}\n";
print MAIL "Date: ".`date`."\n";
print MAIL "Do you wish to upgrade there level of security? Y or N\n\n";
foreach $var (keys %ENV) {
	print MAIL "$ENV{$var}\n";
}
print MAIL "\nSincerely\n\n...";
close(MAIL);

print <<END;
<HTML>
<HEAD>
<TITLE>You are now a member</TITLE>
</HEAD>
<BODY BGCOLOR=black LINK=red aLINK=black vLINK=white>
<CENTER>
<IMG SRC="http://.../enjoy.jpg">
<BR><BR>
<TABLE BORDER=2>
<TR><TD><FONT COLOR=white SIZE=+1>Name:</FONT></TD><TD><FONT COLOR=yellow>$form{'nam'}</FONT></TD></TR>
<TR><TD><FONT COLOR=white SIZE=+1>Password:</FONT></TD><TD><FONT COLOR=yellow>******</FONT></TD></TR>
</TABLE>
<BR>
<FONT SIZE=+1 FACE="Arial Black">
<FONT COLOR=white>
You are now a member!  You now have immediate access to my PRIVATE and PROTECTED page...  Don't be to disapointed when you find out what is
on the other side.<BR><BR>
<FORM ACTION="http://.../SigPro.html">
<INPUT TYPE=submit VALUE="Try out your NEW password">
</FORM><BR><BR>
Don't forget to visit:<BR>
An interactive advanture... <A HREF=http://.../DotFram.html>Dot Art</A><BR>
Dowload my <A HREF=http://.../FramSoft.html> Exciting Software</A><BR>
Rate my <A HREF=http://.../iratejs.html> Web-Site</A><BR>
<A HREF=http://.../iresume.html>View </A> my <A HREF=http://.../iresume/.html> Resume</A><BR>
<BR>
<BLINK>Tell all your friends about this unbelievable FREE offer.</BLINK><BR>
<BR>
<FONT COLOR=red>
If you would like to have this security installed on your web-site send me an E-Mail at either:<BR>
--- <A HREF="mailto:..."><FONT COLOR=yellow>...</FONT>...</A> ---<BR>
- OR -<BR>
--- <A HREF="mailto:..."><FONT COLOR=yellow>j...</FONT>...</A> ---
</FONT></FONT></FONT>
</CENTER>
<BR><BR>
<HR>
<FONT COLOR=white>
... 1998
</FONT>
</BODY>
</HTML>
END
