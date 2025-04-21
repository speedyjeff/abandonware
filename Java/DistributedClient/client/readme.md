Client v.2.3

Last modified 05/16/2001

---------------------------------------------------------
-  Aurthor     :  ...                                   -
-  Email       :  ...                                   -
-  Web address :  ...                                   -
-  Date        :  June 2000 - March 2001                -
-                                                       -
-  I have opened the source to this client so that      -
-  anybody who wants to learn more about distributed    -
-  computing will have a great place to start.  I hope  -
-  that you enjoy.                                      -
---------------------------------------------------------


News:
* (05-16-2001) Resolved a java.lang.LinkageError error.
* (03-23-2001) Cleaned up the code in preparation for opening
	the source.
* (03-23-2001) The client no longer retains its connection to the server
	while it is processing.
* (02-23-2001) By using java's class loader the server may schedule as 
	many processes as it wants, the client may now switch between
	process classes.
* (02-16-2001) The API between the client and server has been
	revised.
* (12-16-2000) The new user interface is in this release.
* at least JDK 1.1.8 is necessary to run Client
	* If earlier versions of JDK do not work email me
* Server must be running on a machine with a static IP address
	* Without the server running the Client will not be able
	  to connect.  And thus just no do anything.
* There is no public server running.  This is intended for private use.


Installation:
* download the binary class files
	* use install shield to install
	 or 
	* Unzip and install a directory of your choice (C:\client)
		* Open a command window and navigate to this directory
		create a  'data' folder in this directory with
		'mkdir data'
* download source files
	* and compile
	'javac Client.java engineClassLoader.java'


Setup:
* NIC (network interface card)
* ini file entries 'client.ini' (updated 02-10-2001)
	server ip			(String)
	client status			(Message: see 'Client api.txt')
	process description		(String < 30 chars)
	number of units processed	(int)
	data file name (used by server) (String)
	class names (dynamic)		(String,String,....)
* (12-16-2000) The 'userinterface.ini' file will allow you to modify
	the look and feel of the user interface


Running: (any of these should work)
* double click on 'start.bat',
* open a command window and type './start.bat',
* type 'wjview Client.class',
* type 'jview Client.class',
* type 'jre -cp . Client',
* or type 'java -classpath . Client'


Known Issues:
* (03-23-2001) If the clients connects to the server with a new ip address
	and is attempting to send a file (TRANSMITTING) then then client
	may stop executing without an error.  If this occurs please just
	restart the client.
* (02-23-2001) "startProcess() IllegalArgumentException : wrong number of 
	arguments" may appear in your log file.  This is not a real error.
	All this means is that the client is searching for the main class 
	file to instantiate.
* (02-20-2001) JRE was had problems displaying the gui under windows.
* (02-16-2001) (resolved 02-23-2001) - By using the classLoader() class 
		all classes are able to be dynamicaly.  The only problem 
		is that if a class has the same name as a previous class 
		the class which is defined first will be used.
	Becuase of the persistence of the process class the process 
	is not being swiched when the server sends a new process.
	Therefore, only 1 process can be distributed at this time.
	
* (02-16-2001) The swing version running under X in linux has a FONT error.
* (12-16-2000) (resolved 02-16-2001) - By stalling the client for 10 
		seconds this synchronition problem is eliminated.
	There seems to be a synchronition problem with the server.  When 
	the client downloads a new file, it does not have enough time to 
	save it to disk before the process class is saved and started.
* If the process class file is either invalid or corrupted on transfer, 
	the client will just sit ideal until the Client is restarted.
* The log file may grow too large.  There is no checking at this time.


This release:
* 05-16-2001: Resolved a java.lang.LinkageError error.
* 03-23-2001: Removed the persistence of the connection to the server.  Now
	the client terminates its connections when it is processing.
* 02-23-2001: Class loader replaces the need to use Thread.engine().  You 
	may now call the Thread anything you want.
* 02-20-2001: All "deprecated" java calls have been removed except for 
	the window components.
* 02-20-2001: The API has been changed to allow disconnecting and 
	reconnecting to the server.
* 02-20-2001: The log file is deleted if its size exceeds 50kb.
* 02-16-2001: The API between the client and server has been updated.  
	Allowing the process class to use more than 1 class file.
* 12-16-2000: The user interface has been updated.
* 12-09-2000: (resolved 12-16-2001) - Function 'stopProcess()' did not 
	stop the process, thus the interaction between the server and 
	client had to be changed.  
	CHANGE: Server now sends the process second and with every data 
	file that it transmits.
* 12-08-2000: First release.  API is not set in stone yet.  But, Client is
	fully functional.


Report bugs:
* If something does not work, do not hesitate to email me at (...)
	* Always include the following 4 things in bug reports:
		1) Your OS name/version (Win95/98/NT/2K/linux dist/..)		
		2) Your Java vendor (Sun/Microsoft/..)
		3) Your Java version (1.1.8, 1.2, 1.2.2,..)
			* You can obtain this by running 'java -version' on some
			systems
		4) A detailed description of your problem


Systems tested on:
* Windows 98
* Windows 98 se
* Windows NT 4.0 (sp5)
* Red Hat 6.2 (JDK1.2.2)
* I developed the client in java so that it could be cross platform without
recompiling so if you have a JVM you should be able to use the client.


Future:
* For Windows users the client will reside in the system tray.
* Remove all deprecated java calls
* Research error in Linux about the fonts

