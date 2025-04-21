#!/usr/bin/perl

print "Content-type: text/html\n\n";

# input from POST form
read(STDIN,$in,$ENV{'CONTENT_LENGTH'});

(@in) = split('&',$in);

foreach $var (@in) {
	($nam,$val) = split('=',$var);
	$val =~ s/\+/ /g;
	$val =~ s/%([\da-z]{1,2})/pack(C,hex($1))/eig;
	$form{$nam} = $val;
}

$permission = "false";
$denied = "false";
$str = "You are Denied access because:\n";

#first check to see if they are on vaild user list
open(FILEVAR,"userlist.txt") || die "can't open userlist.txt";
while ($line = <FILEVAR>) {
	chop($line);
	if ($form{'nam'} eq $line) {
		$permission = "true";
	}
}
close(FILEVAR);

# name test if they are on user list
if ($permission eq "true") {
	open(FILEVAR,"user/$form{'nam'}.txt") || die "true";
		while($line = <FILEVAR>) {
			(@in) = split(':',$line);
			foreach $var (@in) {
				($nam,$val) = split('=',$var);
				$input{$nam} = $val;
			}
		}
	close(FILEVAR);
	# password test
	if ($input{'pas'} eq $form{'pas'}) {
		# make Signature difference variables
		$HORDIFF = $input{'hdiff'};
		$VERTDIFF = $input{'vdiff'};
		$HEIGHTDIFF = $input{'heightdiff'};
		$WIDTHDIFF = $input{'widthdiff'};
		# signature test
		if ($input{'pc'} eq $form{'pc'}) {
			$hcd = $input{'hc'} - $form{'hc'};
			if ($hcd < 0) { $hcd *= -1; }
			$vcd = $input{'vc'} - $form{'vc'};
			if ($vcd < 0) { $vcd *= -1; }
			if (($hcd <= $HORDIFF) && ($vcd <= $VERTDIFF)) {
				$hd = $input{'height'} - $form{'height'};
				if ($hd < 0) { $hd *= -1; }
				$wd = $input{'width'} - $form{'width'};
				if ($wd < 0) { $wd *= -1; }
				if (($hd <= $HEIGHTDIFF) && ($wd <= $WIDTHDIFF)) {
					#if you made it this far then you are now in
					$form{'biolevel'} = $input{'biolevel'};
					$denied = "false";
					# make log input here 
					if ($form{'biolevel'} != 4) {	
						open(FILEVAR,">>visitors.txt") || die "can't open";
							print FILEVAR "$form{'nam'} :: $form{'pas'} @ ".`date`." <FORM METHOD=post ACTION=\"http://.../decodesig.pl\"><INPUT TYPE=submit VALUE=\"See $form{'nam'}'s signature\"><INPUT TYPE=hidden NAME=siz VALUE=\"$form{'count'}\"><INPUT TYPE=hidden NAME=xst VALUE=\"$form{'xst'}\"><INPUT TYPE=hidden NAME=yst VALUE=\"$form{'yst'}\"></FORM><BR>\n";
						close(FILEVAR);
					}
				} else {
					$str .= "Signature DOES NOT match\n";
					$denied = "true";
				}
			} else {
				$str .= "Signature DOES NOT match\n";
				$denied = "true";
			}
		} else {
			$str .= "Signature DOES NOT match\n";
			$denied = "true";
		}
	} else {
		$str .= "password was IN-VALID\n";
		$denied = "true";
	}
} else {
	$str .= "Not on user list\n";
	$denied = "true";
	#make false password and signature file
	#should be empty but if people are that dumb than HELL they'll be in there

	open(FILEVAR,">>invaliduser.txt") || die "can't open";
		print FILEVAR "$form{'nam'} :: $form{'pas'} @ ".`date`." <FORM METHOD=post ACTION=\"http://.../decodesig.pl\"><INPUT TYPE=submit VALUE=\"See $form{'nam'}'s signature\"><INPUT TYPE=hidden NAME=siz VALUE=\"$form{'count'}\"><INPUT TYPE=hidden NAME=xst VALUE=\"$form{'xst'}\"><INPUT TYPE=hidden NAME=yst VALUE=\"$form{'yst'}\"></FORM><BR>";
	close(FILEVAR);
}

if ($denied eq "false") {

print <<END;
<HTML>
<HEAD>
<TITLE>Hello $form{'name'}</TITLE>
</HEAD>
<BODY BGCOLOR="black" BACKGROUND="http://.../blackwav.gif">
<FONT COLOR="RED" SIZE=+3>
<CENTER>
<IMG SRC="http://.../private.jpg">
</FONT>
<FONT COLOR="white">
<BR><BR><BR>
END

# top level clearance
if ($form{'biolevel'} == 4) {
print <<END;
<FORM METHOD=POST ACTION="/.../viewfile.pl">
<INPUT TYPE=submit VALUE="View log file">
<INPUT TYPE=hidden NAME="n" VALUE="1">
<INPUT TYPE=hidden NAME="p" VALUE="see you on the other side">
</FORM>
END
}

#second level of security
if (($form{'biolevel'} == 3) || ($form{'biolevel'} == 4)) {
print <<END;
<FORM METHOD=POST ACTION="/.../viewfile.pl">
<INPUT TYPE=hidden NAME="p" VALUE="see you on the other side">
<INPUT TYPE=hidden NAME="n" VALUE="2">
<INPUT TYPE=submit VALUE="See false passwords & signatures">
</FORM>
END
}

# third level of security
if (($form{'biolevel'} == 2) || ($form{'biolevel'} == 3) || ($form{'biolevel'} == 4)) {
print <<END;
<FORM ACTION="http://.../private.html">
<INPUT TYPE=submit NAME="submit" VALUE="See how people responded to the questionare">
</FORM> 
END
}

#gerneral viewing for all except the hackers
if (($form{'biolevel'} == 1) || ($form{'biolevel'} == 2) || ($form{'biolevel'} == 3) || ($form{'biolevel'} == 4)) {
print <<END;
<FORM METHOD=post ACTION=".../nfile.pl">
<INPUT TYPE=hidden NAME="p" VALUE="see you on the other side">
<INPUT TYPE=submit VALUE="See comments">
</FORM>
<BR>
END
}

########### START ############################################################

@stuff = ("nibbles","gorilla","killfish","tictac1","tictac2","...lib","buttonlib","graphics","nibblesd","bannermaker","superbreakout","pong","tictactoe1","clock","banner");

@parts = ("count","fst_mod","lst_mod");

########### Joice the Array  ########################

dbmopen(%counters,counters,0666);

foreach $var1 (@stuff) {
	if (!(defined($counters{$var1,'count'}))) {
		$form{$var1,'count'} = 0;
	} else {
		$form{$var1,'count'} = $counters{$var1,'count'};
	}
	if (!(defined($counters{$var1,'fst_mod'}))) {
		$form{$var1,'fst_mod'} = " -- ";
	} else {
		$form{$var1,'fst_mod'} = $counters{$var1,'fst_mod'};
	}
	if (!(defined($counters{$var1,'lst_mod'}))) {
		$form{$var1,'lst_mod'} = " -- ";
	} else {
		$form{$var1,'lst_mod'} = $counters{$var1,'lst_mod'};
	}
}

dbmclose(counters);
############### Stop joiceing ####################

print <<END;
</CENTER>
<CENTER>
<TABLE BORDER=1>
<TR><TH></TH><TH><FONT COLOR=white>Hits</FONT></TH><TH><FONT COLOR=white>First time</FONT></TH><TH><FONT COLOR=white>Last time</FONT></TH></TR>
END

foreach $var1 (@stuff) {
	print "<TR><TD><CENTER><FONT COLOR=red>$var1</CENTER></TD>";
	foreach $var2 (@parts) {
		print "<TD><CENTER><FONT COLOR=white>$form{$var1,$var2}</CENTER></TD>";
	}
	print "</TR>";
}

print <<END;
</TABLE>
</CENTER>
END

######################## STOP #######################################
print <<END;
<BR><BR>
<FONT COLOR="red">
<CENTER>
:[<A HREF="http://.../index.html"> home page</A> ]:[ <A HREF="http://.../istagecr.html"> Stage Craft Portfolio</A> ]:[ <A HREF="http://.../iresume.html"> Resume </A> ]:[ <A HREF="http://.../inwstuff.html"> Who is ... </A> ]:[  
<A HREF="http://.../FramSoft.html"> ...'s Software </A> ]:</CENTER>
</FONT>
<BR>
<HR>
<FONT COLOR=white>
... &nbsp;&nbsp; <A HREF="mailto:...">....</A> or <A HREF="mailto:...">...</A>
</FONT>
</BODY>
</HTML>
END
exit(0);
}

print <<END;
<HTML>
<HEAD>
<TITLE>NO WAY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</TITLE>
</HEAD>
<BODY BGCOLOR=black>
<CENTER>
<IMG SRC="http://.../access.jpg">
<BR>
<FONT SIZE=+3 FACE="Arial Black">
<FONT COLOR=yellow>
$str<BR>
<BR>
</FONT>
<FONT COLOR=white>
Please Try Again<BR>
And if you are not a USER sign up now and get instant access
</FONT>
</FONT>
</CENTER>
</BODY>
</HTML>
END
