-- ------------------------------------------------------------------------- --
--                                                                           --
--  Author      :  ...                                                       --
--                                                                           --
--  Email       :  ...                                                       --
--                                                                           --
--  Web address :  ...                                                       --
--                                                                           --
--  Date        :  June 2000 - February 2001                                 --
--                                                                           --
--  Update      :  (02-23-2001) engine.class no longer needs to be compiled  --
--                     with the client and it no longer needs to be called   --
--                     engine.
--                 (02-10-2001) Increment to API VERSION 2:                  --
--                  Status - HOST_INFO                                       --
--                         - CHECKIN_xxxxx (this is used by the applet based --
--                                          clients)                         --
--                  Data   - Receive "data file name" and                    --
--                           Send "data file name"                           --
--                  Process- Allowed multiple process classes to be sent.    --
--                                                                           --
-- ------------------------------------------------------------------------- --

This is a persistent connection distributed computing model.  All message
passing is done on the STATS PORT (3003) the API is described below.

At start-up the Client must send its status to server and startup where it 
left off the time before.

-------------------------------------------------------------------------------
Client.java:
-------------------------------------------------------------------------------
These is the necessary framework for the client class.
public Client {
	public volatile engine processThread;

	synchronized public void percentCompleted(int per) {
	}

	public static void main(String args[]) {
		processThread = new engine(IN_FILE_NAME,OUTPUT_FILE_NAME,this);
	}
}

-------------------------------------------------------------------------------
engine.java:
-------------------------------------------------------------------------------
02-23-2001 - This class no longer needs to be called engine.  In fact the client
	does not have to have any knowledge of this class except of its 
	constructor (shown below).
This is the framework for the engine(process) class. 
class engine extends Thread {
        public _xxxx_ (String fileIn, String fileOut, Client clnt) {

		// Once the process is complete
		clnt.percentCompleted(100);
        }
}

-------------------------------------------------------------------------------
Server-client:
-------------------------------------------------------------------------------
port 3000 (aka IP PORT) *******************************************************
This port listens for an update to the server's IP address.
INPUT:
        String     (ip address)
OUTPUT:
        none



port 3001 (aka DATA TRANSFER PORT) ********************************************
Used for receiving and transmitting data files. 
(02-10-2001) Filename is now send and received from the server.
(12-09-2000) The data file is always sent first.
INPUT:
	String     (file name, used by server) (02-10-2001)
        String     (integer size of the file about to be sent)
        byte[]     (byte array of the data file)
OUTPUT:
	String     (file name, used by server) (02-10-2001)
	String     (integer size of the file about to be sent)
	byte[]     (byte array of the data file)



port 3002 (aka PROCESS PORT) **************************************************
Exclusive for process class file downloads.  
(02-20-2001) For the APPLET (checkin_xxx) only send the process description.
(02-10-2001) Added support for multiple process class files.
(12-09-2000) Once the process is downloaded it is started.
NORMAL USE ------------------------------>
INPUT:
   [ONCE PER TRANSACTION]
	String     (String description of the process < 30 chars)
	String     (integer number of classes the server is going to send) (02-10-2001)
   [REPEAT AS SPECIFIED BY THE ABOVE NUMBER]
        String     (file name, use this name to save the file) (02-10-2001)
        String     (integer size of the file about to be sent)
        byte[]     (byte array of the data file)
OUTPUT:
        none
APPLET USE ------------------------------>
INPUT:
	String     (String description of the process < 30 chars)
OUTPUT:
        none



port 3003 (aka STATUS PORT) ***************************************************
If the Server wants to know your current status it will send a "String" 
of information to this port.  Respond to data port (3003) with one of the 
following messages.
(02-10-2001) Added HOST_INFO.  Used to collect OS, RAM,.. from client.
Also, added functionality to allow applet clients to connect to the server.
Message passing API:
        Message              Message Description        Server Response
        ------------------   ------------------------   ---------------------
        ERROR_IP_DL          IP address has been        Resend server IP 
                             corrupted                  address 
                                                        -->IP port (3000)
        ERROR_DATA_DL        Data file has been         Resend current data
                             curropted or does not      file to Client
                             exist                      -->Data port (3001)
        ERROR_PROCESS_DL     Process class file has     Resend current process
                             been corrupted or does     class file
                             not exist                  -->Process port (3002)
        RECEIVING            Ready to receive a new     If already sending file
                             data file.  Or are in      continue, or start send
                             the process of receiving   data file
                             a data file.               -->Data port (3001)
        READY                Clean start, first time.   First send a data file
                             Need data file and a       -->Data port (3001)
                             process.                   Then send a new process
                                                        -->Process port (3002)
        TRANSMITTING         Client is uploading        Nothing
                             completed data file
        PROCESSING_COMPLETE  Client has completed       Nothing
                             processing and is 
                             preparing to send file 
                             back to server. 
        PROCESSING           Client is processing       Nothing
                             the data.
        HOST_INFO            Quering client for         Nothing
                             infomation about the 
                             hosts OS, RAM, CPU...
                             Send INTEGER (size) 
                             BYTE[] (array of info)
        CHECKIN_xxxx         Applet client checkin.     Never sends a process
                             The x's represent an       class, only special data
                             applet process id.         files.

INPUT:
	String      (HOST_INFO | garbage)
OUTPUT:
	String      (Message | Integer for HOST_INFO, size of byte[] stream)
   [IN CASE OF HOST_INFO (additional data)]
        byte[]      (byte array containing the infomation)