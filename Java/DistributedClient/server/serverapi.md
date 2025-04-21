-- ------------------------------------------------------------------------- --
--                                                                           --
--  Author      :  ...                                                       --
--                                                                           --
--  Email       :  ...                                                       --
--                                                                           --
--  Web address :  ...                                                       --
--                                                                           --
--  Date        :  June 2000 - December 2000                                 --
--                                                                           --
--  Update      : (02-10-2001) Added functionality to:                       --
--                  Status - HOST_INFO                                       --
--                           CHECKIN-xxxx  (this is used by the applet based --
--                                          clients)                         --
--                  Data   - File name is send and received from the client. --
--                           Allows better tracking of files.                --
--                  Process- Allowed multiple process classes to be sent.    --
--                                                                           --
-- ------------------------------------------------------------------------- --

This is a persistent connection distributed computing model.  All message
passing is done on the STATS PORT (3003) the API is described below.

-------------------------------------------------------------------------------
Server-client:
-------------------------------------------------------------------------------
port 3000 (aka IP PORT) *******************************************************
This port is used to update the server's IP address with the clients.
Thus, if you wanted to switch all users from one Server to another you would
send out the new IP address.
INPUT:
        none        
OUTPUT:
        String     (ip address)



port 3001 (aka DATA TRANSFER PORT) ********************************************
Used for receiving and transmitting data files. 
(02-10-2001) The file name is also send and retreived from the server/client.
(12-09-2000) The data file is always sent first.
INPUT:
	String     (file name location, used by server) (02-10-2001)
        String     (integer size of the file about to be sent)
        byte[]     (byte array of the data file)
OUTPUT:
	String     (file name location, used by server) (02-10-2001)
	String     (integer size of the file about to be sent)
	byte[]     (byte array of the data file)



port 3002 (aka PROCESS PORT) **************************************************
Exclusive for sending process class files. 
(02-20-2001) For the APPLET (checkin_xxx) only send the process description.
(02-10-2001) Added support for multiple process class files.
(12-09-2000) Once the process is downloaded it is started.
NORMAL USE ------------------------------>
INPUT:
        none
OUTPUT:
   [ONCE PER TRANSACTION]
	String     (String description of the process < 30 chars)
	String     (integer number of classes the server is going to send) (02-10-2001)
   [REPEAT AS SPECIFIED BY THE ABOVE NUMBER]
        String     (file name, use this name to save the file) (02-10-2001)
        String     (integer size of the file about to be sent)
        byte[]     (byte array of the data file)
APPLET USE ------------------------------>
INPUT:
        none
OUTPUT:
        String     (String description of the process < 30 chars)



port 3003 (aka STATUS PORT) ***************************************************
If the Server wants to know your current status of any of the clients it will 
send a "String" of information to this port.  The response will be on the 
data port (3003) with one of the following messages.
(02-10-2001) Added HOST_INFO, which will allow collection of info from the 
hosts.  Also, added functionality to allow applet clients to connect to 
the server.
Message passing API:
                             Client
        Message              Message Description        Server Response
        ------------------   ------------------------   ---------------------
        ERROR_IP_DL          IP address has been        Resend server IP 
                             corrupted                  address 
                                                        -->IP port (3000)
        ERROR_DATA_DL        Data file has been         Resend current data
                             corrupted or does not      file to Client
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
        HOST_INFO            Quering client for        Save the contents to a file
                             infomation about the      
                             hosts OS, RAM, CPU...
                             Send INTEGER (size) 
                             BYTE[] (array of info)
        CHECKIN_xxxx         Applet client checkin.     Never sends a process
                             The x's represent an       class, only special data
                             applet process id.         files.

INPUT:
	String      (Message | Integer for HOST_INFO, size of byte[] stream)
   [IN CASE OF HOST_INFO (additional data)]
        byte[]      (byte array containing the infomation)
OUTPUT:
	String      (garbage)

