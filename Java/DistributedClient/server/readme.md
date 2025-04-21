Server v.2.2

Last modified 03/23/2001

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
* (03-23-2001) Cleaned up the code in preparation for opening
	the source.
* (02-24-2001) Added an applet process to the db and the directory 
	structure to serve as an example.
* (02-23-2001) Applet process's are different than the normal client
	process.  Also, the process is not sent to the client it is
	packaged (aka JAR)
* (02-23-2001) Added support for applet clients.
* (02-23-2001) Moved most of the connection log to stdout.
* (02-23-2001) Allowed more parameters to be configurable. 
	(ie. NUM_CONNECTIONS,APPEND_TIMESTAMP...)
* (02/16-2001) Implemented a new API between client and server.
* (02/02/2001) Updated version of Generate Primes (process).
* at least JDK 1.1.8 is necessary to run Server
	* If earlier versions of JDK do not work email me
* (12/9/2000) There can be up to 50 clients connected at any time.
	* This maximum was set because the server in its current state
	is not scalable.  But, this can be easily raised, but performance
	would be noticably slower with a large number of connections.
* (12/13/2000) This is not entirely true anymore.  As long as you use
	a database.
* (12/13/2000) Database connectivity has been added.
* (12/16/2000) This is the LAST release to support flat files.
* (12/17/2000) The database connection is necessary now.  The last version
	to use flat files is Server v.1b.


Installation:
* download the binary class files
	* use install shield to install
	 or 
	* Unzip and install a directory of your choice (C:\server)
		* Open a command window and navigate to this directory
		run these commands
		'mkdir hosts
		mkdir process
		mkdir data
		cd data
		mkdir input
		mkdir output'
* download source files
	* and compile
	'javac Server.java'
* install a database which has a JDBC driver
	* I recommend MySql.  It is a free relational database and is
	supported on most platforms.  Any database can be used.
	* It can be downloaded here: 
	"http://www.mysql.com/downloads/index.html"
	* MySql configuration instructions can be found in the 'readme'
	file that comes with the MySql distribution.
	* You will also need a JDBC driver for java.


Setup:
* NIC (network interface card)
* After installing and configuring the database.  Execute the contents 
	of the script
	'db info/create db.sql'
* Then populate the database based on the template in 
	'db info/fill db.sql'
* 'data/input'   has the input
* 'data/output'  has the output
* 'process'      contains the process (class) files
* 'hosts'        stores the hosts information


Running: (any of these should work)
* double click on 'start.bat',
* open a command window and type './start.bat',
* type 'wjview Server.class',
* type 'jview Server.class',
* type 'jre -cp . Server',
* or type 'java -cp . Server'


Interface:
* (02-23-2001) Moved most of the client connection information to stdout.
* To view the status of one of the clients who are currently connected
	to the server double click on the 'hostname' in the list on
	the left.


How to:
* How to add additional processes. (12-13-2000) UPDATED (02/16/2001) (02-23-2001)
	- 1. Create a _PROCESS_ class and place class file(s) in the
	     proces directory.
		a. Create an internal name for this process.  
			(ie. gen_primes).
		b. Add this name to the SCHEDULE table.
		c. Add class name and path to the PROCESS_FILES table. (one row
			per class file).
		d. Add process description to PROCESS_DESC table. (only one entry)
	- 2. Add the input files to the input directory
		a. For each input file add ONE row to the INPUT_DATA table, 
		along with the appropriate internal name.


Known Issues:
* If all the connections were not killed the last time it was shut down, then 
	the server may return an error such as "Address in use."  If this 
	occurs, you will have to restart your server.
* (resolved 02/16/2001) - When the server comes to the end of the input data file it will start 
	sending null filename.
* When the server is shut down, a IllegalArgumentException may occur.  This is ok:
	What is happening is that the threads are trying to write to an object 
	(part of the main thread) that is already destroyed.


This release:
* 03-23-2001: Fixed a typo in the 'db info/load_process_files.txt' file.
* 02-32-2001: Added support for applet clients.
* 02-23-2001: Added the ability to collect info from the clients.
* 02-23-2001: Moved most of the connection info to stdout.
* 02-16-2001: The new API between client and server will allow multiple class 
	to be send to the client. And allow applet clients.
* 12-17-2000: All data flat file interaction has been removed.
* 12-16-2000: An interface to view current client connections has been added.
* 12-13-2000: Database connectivity has been incorprated into the server.
* 12-09-2000: Due to a problem with 'stopProcess()' in the Client.  The Server 
	now always sends the data file before the process file.  And will send 
	the process file after sending that data file each time.
* 12-08-2000: First release.  API is not set in stone yet.  But, Server is
	fully functional.


Report bugs:
* If something does not work, do not hesitate to email me at (...)
	* Always include the following 4 things in bug reports:
		1. Your OS name/version (Win95/98/NT/2K/..)		
		2. Your Java vendor (Sun/Microsoft/..)
		3. Your Java version (1.1.8, 1.2, 1.2.2,..)
			* You can obtain this by running 'java -version' on some
			systems
		4. Database Name and version
		5. A detailed description of your problem


Systems tested on:
* Windows NT 4.0 (sp5)
* MySql 3.23 -- Gamma Release
* JDBC Windows Driver (Mark Matthews' MySQL JDBC Driver Version 0.9e)
  http://www.worldserver.com/~mmatthew/mysql/
* I developed the server in java so that it could be cross platform without
recompiling so if you have a JVM you should be able to use the server.


Future:
* For Windows users the Server will reside in the system tray.
* An improved User Interface
* Remove all deprecated java calls (updated 02-23-2001 : only frame 
	deprecated calls remain)
* Make a TCL/TK gui.
* Mechinism to save log file


