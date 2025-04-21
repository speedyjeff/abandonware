// ////////////////////////////////////////////////////////////////////////
// //                                                                    //
// //  Aurthor     :  ...                                                //
// //                                                                    //
// //  Email       :  ...                                                //
// //                                                                    //
// //  Web address :  ...                                                //
// //                                                                    //
// //  Date        :  June 2000 - February 2001                          //
// //                                                                    //
// //  Updated     : (02-10-2001) Modified the API to include:           //
// //                   - HOST_INFO                                      //
// //                   - Send "data file name" to client.  This will    //
// //                      eliviate the file naming problem if the client//
// //                      disconnects and then reconnects.              //
// //                   - New database schema.  Added a schedule table.  //
// //                   - Multiple class files can be sent to the client //
// //                   - Added more error checking.                     //
// //                (12-16-2000) 1. Add database connectivity, and      //
// //                             2. Added an interface so that you can  //
// //                                monitor the clients.                //
// //                                                                    //
// //                (12-17-2000) 1. Removed all flat file interaction.  //
// //                                Database connection is necessary.   //
// //                                                                    //
// ////////////////////////////////////////////////////////////////////////

import java.io.*;
import java.net.*;
import java.awt.*;
import java.sql.*;
import java.util.*;
import java.util.Date;
import java.lang.Math;
import java.util.Vector;
import java.util.Enumeration;

public class Server extends Panel {
//	// NEED TO DELETE ALL BUT ONE OF THESE VECTORS
//	//  THEY CONTAIN REDUNDANT INFORMATION!!!!!!!!

	public Vector clientsIpPort      = new Vector();
	public Vector clientsStatusPort  = new Vector();
	public Vector clientsDataPort    = new Vector();
	public Vector clientsProcessPort = new Vector();    
    
	private static int numUsers    = 50;
	private int ipPort      = 3000;
	private int dataPort    = 3001;
	private int processPort = 3002;
	private int statusPort  = 3003;
	public DataOutputStream outIp,outData,outProcess,outStatus;
	public static ServerSocket srvIpSocket,srvDataSocket,srvProcessSocket,srvStatusSocket;
	private Frame frame;
	private GridBagConstraints c;
	private GridBagLayout      gridBag;
	private Label              label;
	private static String SERVER_INI = "server.ini";
	private static String JDBC_DRIVER;
	private static String CONNECTION_STRING;

	public static String DATA_IN_DIR  = "data/input/";
	public static String DATA_OUT_DIR = "data/output/";
	public static String PROCESS_DIR  = "process/";
	public static String HOST_DIR     = "hosts/";

	public static boolean APPEND_HOSTNAME    = false;
	public static boolean APPEND_TIME_STAMP  = false;

	public TextArea ipText;
	public TextArea statusText;
	public TextArea processText;
	public TextArea dataText;
	private List clientList;		// current client list
	private List clntInfoDisplay;
  	
	// Client Info Class
	public class info {
		public String hostName;
		public DataOutputStream out;
		private String processID = null;
		private String dataID = null;
		private String isApplet = "false";
		
		// Get Private members
		public String getProcess() {
			return processID;
		}
		public String getData() {
			return dataID;
		}
		public String isApplet() {
			return isApplet;
		}

		// Update private members
		public void newProcess(String proc) {
			processID = proc;
		}
		public void newData(String data) {
			dataID = data;
		}
		public void setAppletFlag(String state) {
			// state == ( "false" | "true")
			isApplet = state;
		}

		// dot   : dataoutputstream
		// htNam : hostname
		public info(DataOutputStream dot, String htNam) {
			this.out = dot;
			this.hostName = htNam;
		}
	}

	private void addClientToList(String hostName) {
		clientList.add(hostName);
	}

	private void removeClientFromList(String hostName) {
		clientList.remove(hostName);
	}
    
	// User Interface ///////////////////////////////////////////////////
	public Server(Frame f) {
		frame = f;

		Insets insets = new Insets(10, 20, 5, 10); // bot, lf, rt, top
		gridBag = new GridBagLayout();
		setLayout(gridBag);

		c = new GridBagConstraints();

		c.insets = insets;
		c.gridy = 0;
		c.gridx = 0;

		// IP Commponent
		label = new Label("IP:");
		gridBag.setConstraints(label, c);
		add(label);
		// send
		c.gridx = 1;
		ipText = new TextArea(6,50);
		gridBag.setConstraints(ipText, c);
		add(ipText);
		c.gridx = 0;    
                       
		// Status Commponent
		c.gridy = 1;
		label = new Label("Status:");
		gridBag.setConstraints(label, c);
		add(label);
		// receive
		c.gridx = 1;
		statusText = new TextArea(6,50);
		gridBag.setConstraints(statusText, c);
		add(statusText);
		c.gridx = 0;

		// Data Commponent
		c.gridy = 2;
		label = new Label("Data:");
		gridBag.setConstraints(label, c);
		add(label);
		// receive
		c.gridx = 1;    
		dataText = new TextArea(6,50);
		gridBag.setConstraints(dataText, c);
		add(dataText);
		c.gridx = 0;     
        
		// Process Commponent
		c.gridy = 3;
		label = new Label("Process:");
		gridBag.setConstraints(label, c);
		add(label);
		// receive
		c.gridx = 1;    
		processText = new TextArea(6,50);
		gridBag.setConstraints(processText, c);
		add(processText);

		// Component to keep track of current clients
		// Label
		c.gridy = 0;
		c.gridx = 2;
		label = new Label("Current ClientConnections.");
		gridBag.setConstraints(label,c);
		add(label);

		// List of clients
		c.gridy = 1;
		clientList = new List(6);
		gridBag.setConstraints(clientList,c);	
		add(clientList);

		// Display Info here...
		c.gridy = 2;
		clntInfoDisplay = new List(6);
		gridBag.setConstraints(clntInfoDisplay, c);
		add(clntInfoDisplay);
		
	}

	// catch Server UI actions
	public boolean action(Event e, Object what) {
		String hostName = null;

		if (e.target == clientList) {
			hostName = clientList.getSelectedItem();
			clntInfoDisplay.removeAll();
			clntInfoDisplay.add("Hostname__: " + hostName);
			clntInfoDisplay.add("Process_ID: " + getInfo(hostName,"process"));
			clntInfoDisplay.add("Data____ID: " + getInfo(hostName,"data"));
			clntInfoDisplay.add("Is_Applet_: " + getInfo(hostName,"isApplet"));
		}

		return super.action(e, what);
	}

	public static void closeServerConnections() {
		System.out.println("Killing Server Sockets...");
		// Close the Server Sockets
		if (srvIpSocket != null) {
			try {
				srvIpSocket.close();
			} catch (IOException x){
			}
		}
		if (srvDataSocket != null) {
			try {
				srvDataSocket.close();
			} catch (IOException x) {
			}
		}
		if (srvProcessSocket != null) {
			try {
				srvProcessSocket.close();
			} catch (IOException x) {
			}
		}
		if (srvStatusSocket != null) {
			try {
				srvStatusSocket.close();
			} catch (IOException x) {
			}
		}
	}

	private static void storeVariable(String varName,String value) {
		// trim both sides of the value and varName
		// if value = "" then it is null
		varName = varName.trim();
		value = value.trim();
		if (varName.equals("JDBC_DRIVER")) {
			JDBC_DRIVER = value;
		} else if (varName.equals("CONNECTION_STRING")) {
			CONNECTION_STRING = value;
		} else if (varName.equals("NUM_CONNECTIONS")) {
			try {
				numUsers = Integer.valueOf(value).intValue();
			} catch (NumberFormatException e) {
				numUsers = 50;
			}
		} else if (varName.equals("APPEND_HOSTNAME")) {
			APPEND_HOSTNAME   = value.equals("true")?true:false;
		} else if (varName.equals("APPEND_TIMESTAMP")) {
			APPEND_TIME_STAMP = value.equals("true")?true:false;
		}
	}

	// Main function //////////////////////////////////////////////////
	public static void main(String args[]) {
		String temp = null;
		FileInputStream fstream;
		BufferedReader d;
		ExitFrame f = new ExitFrame("Server...");

		Server srv = new Server(f);
		f.srv = srv;
		f.add("Center", srv);
		f.setIconImage(Toolkit.getDefaultToolkit().getImage("icon.bmp"));
		f.setSize(650, 480);	//width , height
		f.show();

		System.out.println("Distributed Server has started..");
		
		// Read in ini file
		try {
			fstream = new FileInputStream( SERVER_INI );
			d = new BufferedReader(new InputStreamReader(fstream));

			while ((temp=d.readLine()) != null) {
				if (!temp.startsWith("#") && temp.indexOf("=") > 0) {
					// 'variable name = value'
					// split string up and pass to 
					//  storeVariable
					storeVariable(temp.substring(0,temp.indexOf("=")),temp.substring(temp.indexOf("=")+1,temp.length()));
				}
			}
			d.close();
		} catch (Exception e) {
			System.out.println("ini input error:"+e.getMessage());
		}
        
		// Register the db driver if not null
		if (JDBC_DRIVER != null) {
			Properties P = System.getProperties(); 
			P.put("jdbc.drivers", JDBC_DRIVER); 
			System.setProperties(P);
		}
		
		// Test db connection;  Determine if the server will use the db or flat files
		try {
			Connection Conn = DriverManager.getConnection( CONNECTION_STRING );  
			Conn.close();
		} catch (Exception e) {
			System.out.println("Connection failed to database: " + e.getMessage());
			System.out.println("POSSIBLE REASONS: 1) The JDBC driver \"" + JDBC_DRIVER + "\" is incorrect.");
			System.out.println("                  2) The connection string \"" + CONNECTION_STRING + "\" is incorrect.");
			System.out.println("                  3) Make sure that you granted the above user rights to the database.");
			System.out.println("\nServer can not operate without a database connection.");
			System.out.println("-- exit");
			System.exit(0);
		}
	
		// Make the connections happen.
		srv.connect();        
	}
	
	// Wait for Connections from Clients //////////////////////////////
	public void connect() {
		boolean listening = true;
		// Server Sockets (that will listen for clients)
		try {
			InetAddress serverAddr = InetAddress.getByName(null);

			srvIpSocket = new ServerSocket(ipPort,numUsers);
			srvDataSocket = new ServerSocket(dataPort,numUsers);
			srvStatusSocket = new ServerSocket(statusPort,numUsers);
			srvProcessSocket = new ServerSocket(processPort,numUsers);
		} catch (IOException e) {
			statusText.append(e.getMessage() + "\n");
			// If this fails then The rest will throw a NullPointerException
			//  Thus listening is FALSE
			//  Die.. Do not collect $200 hehehe
			System.out.println("A fatal error occured \"" + e.getMessage() + "\".  Program has been termininated.");
			System.out.println("REASON:  The server has unresolved connections.");
			System.out.println("This can be checked by typing \'netstat -ap tcp\' at the command line, look for connections on ports 3000 - 3004.");
			listening = false;
		} 

		if (listening) {
			System.out.println("... Ready for client connections.\n");
		}
    	
		// Connect the client to the server	
		while (listening) {
			// Establish Process Socket and Process OutStream
			try {
				Socket processSocket = srvProcessSocket.accept();
				processText.append("Accepted connection from " + processSocket.getInetAddress().getHostName() + "\n");
				outProcess = new DataOutputStream(processSocket.getOutputStream());      
				addToClients(clientsProcessPort,outProcess,processSocket.getInetAddress().getHostName());
			} catch (IOException e) {
 				processText.append(e.getMessage() + "\n");
			} 
			// Establish Status Socket and Status OutStream
			try {                    
				Socket statusSocket = srvStatusSocket.accept();
				statusText.append("Accepted connection from " + statusSocket.getInetAddress().getHostName() + "\n");
				outStatus = new DataOutputStream(statusSocket.getOutputStream());
				addToClients(clientsStatusPort,outStatus,statusSocket.getInetAddress().getHostName());                    
                    
				new serverStatusRec(this, statusSocket).start();
			} catch (IOException e) {
				statusText.append(e.getMessage() + "\n");
			} 
			// Establish Data Socket and Data OutStream
			try {
				Socket dataSocket = srvDataSocket.accept();
				dataText.append("Accepted connection from " + dataSocket.getInetAddress().getHostName() + "\n");
				outData = new DataOutputStream(dataSocket.getOutputStream());
				addToClients(clientsDataPort,outData,dataSocket.getInetAddress().getHostName());                    
                    
				new serverDataRec(this,dataSocket, outData).start();
			} catch (IOException e) {
				dataText.append(e.getMessage() + "\n");
			} 
			// Establish Ip Socket and Ip OutStream
			try {                  
				Socket ipSocket = srvIpSocket.accept();
				ipText.append("Accepted connection from " + ipSocket.getInetAddress().getHostName() + "\n");
				outIp = new DataOutputStream(ipSocket.getOutputStream());
				addToClients(clientsIpPort,outIp,ipSocket.getInetAddress().getHostName());                    
			} catch (IOException e) {
				ipText.append(e.getMessage() + "\n");
			} 
		}  // End of while
        
	}
   
	// Send Info to all Clients ///////////////////////////////////////////
	private void broadCast(Vector clients, String s,TextArea txtar) {
		info temp;

		for (Enumeration e = clients.elements(); e.hasMoreElements();) {
			temp = (info)(e.nextElement());      
			try {
				temp.out.writeUTF(s);
 			} catch (IOException x) {
				txtar.append(x.getMessage() + "\n");
				removeFromClients(clients,temp.out);
			}             
		}
	}
    
	// Send Text to a specific Client ///////////////////////////////////
	synchronized boolean send(Vector clients,String hostName,String infoPacket){
		info temp;
		boolean sent = false;
        
		if (infoPacket != null) {
			for (Enumeration e = clients.elements(); e.hasMoreElements();) {
				temp = (info)(e.nextElement());      
				if (temp.hostName.equals(hostName)) {
					try {
						temp.out.writeUTF(infoPacket);
						sent = true;
					} catch (IOException x) {
					}
 				}
			}
		} else {
			System.out.println("String cannot be sent to ("+hostName+") because it was null.");
		}

		return sent;
	}


	// Send Data to a specific Client ///////////////////////////////////
	synchronized boolean sendData(Vector clients,String hostName,byte[] b,int len, String fileName) {
		info temp;
		boolean sent = false;
        
		if (b != null) {
			for (Enumeration e = clients.elements(); e.hasMoreElements();) {
				temp = (info)(e.nextElement());      
				if (temp.hostName.equals(hostName)) {
					try {

						// ////////////////////////////////// //
						// // API VERSION 2                // //
						// // Changes to this code require // //
						// // the API version to be        // //
						// // incremented                  // //
						// ////////////////////////////////// //
						// Send the filename
        			                temp.out.writeUTF( fileName );
                			        temp.out.flush();
		        	                // send length
        		        	        temp.out.writeUTF(String.valueOf(len));
                		        	temp.out.flush();
	                        		// Send the entire file byte by byte
			                        temp.out.write(b,0,len);
						// ////////////////////////////////// //

						sent = true;
					} catch (IOException x) {
					}
 				}
			}
		} else {
			System.out.println("File ("+fileName+") not sent to ("+hostName+") because it was null.");
		}

		return sent;
	}

	// Retrieve Data from a specific Client //////////////////////////////
	// POOR DESIGN:  Only the data Vector contains all the up to date 
	//               information about the clients current PROCESS and
	//               current DATA file.	
	synchronized String getInfo(String hostName,String id) {
		info temp;
		Enumeration e;
		String ret = null;
        
		for (e = clientsDataPort.elements(); e.hasMoreElements();) {
			temp = (info)(e.nextElement());      
			if (temp.hostName.equals(hostName)) {
				if (id.equals("data")) {
					ret = temp.getData();
				} else if (id.equals("process")) {
					ret = temp.getProcess();
				} else { // == "isApplet"
					ret = temp.isApplet();
				}
				break;	
 			}
		}
		return ret;
	}

	// Save Data to a specific Client ////////////////////////////////
	// POOR DESIGN:  Only the data Vector contains all the up to date 
	//               information about the clients current PROCESS and
	//               current DATA file.	
	synchronized void putInfo(String hostName,String id,String currentID) {
		info temp;
		Enumeration e;
        
		for (e = clientsDataPort.elements(); e.hasMoreElements();) {
			temp = (info)(e.nextElement());      
			if (temp.hostName.equals(hostName)) {
				if (id.equals("data")) {
					temp.newData(currentID);
				} else if (id.equals("process")) {
					temp.newProcess(currentID);
				} else { // == "isApplet"
					temp.setAppletFlag(currentID);
				}
				break;	
 			}
		}
	}
    

	// Remove from Client List /////////////////////////////////////////
	synchronized void removeFromClients(Vector clients, DataOutputStream remoteOut) {
		info temp;
        
		for (Enumeration e = clients.elements(); e.hasMoreElements();) {
			temp = (info)(e.nextElement());      
			if (temp.out == remoteOut) {
				removeClientFromList(temp.hostName);
				clients.removeElement(temp);
			}
		}
	}
    
	// Add Client to Client list ////////////////////////////////////
	synchronized void addToClients(Vector clients, DataOutputStream remoteOut, String hostNam) {
		clients.addElement( new info(remoteOut,hostNam) );
		// For the time being only put one.
		if (clients == clientsDataPort)
			addClientToList(hostNam);
	}

	// ////////////////////////////////////////////////////////////////////
	// // These functions will do the DB access.  This is the only       //
	// //  place where you will access the db.                           //
	// ////////////////////////////////////////////////////////////////////

	// HOST TABLE /////////////////////////////////////////////////////////
	synchronized public boolean newHost(String hostName) {
		Connection Conn = null;
		Statement Stmt;
		ResultSet r;
		boolean newHost = true;

		try {
			Conn = DriverManager.getConnection( CONNECTION_STRING );  
			Stmt = Conn.createStatement();
			// Check host table for record with this hostName
			r = Stmt.executeQuery("select * from host where HOST_NAME='"+hostName+"' LIMIT 1");

			String temp = r.getString("HOST_NAME");

			if (temp == null) {
				// The query did not return a host
				System.out.println("\n("+hostName+") has connected for the first time.\n");
				newHost = true;
			} else {
				// The host is in the host table
				newHost = false;

			}
			r.close();	
			Stmt.close();
			Conn.close();
		} catch (Exception E) { 
			System.out.println("Connection failed : " + E.getMessage()); 
		}

		return newHost;
	}

	synchronized public void updateConnectionDate(String hostName) {
		Connection Conn = null;
		Statement Stmt;

		try {
			Conn = DriverManager.getConnection( CONNECTION_STRING );  
			Stmt = Conn.createStatement();
			// Update the last connection field to reflect today
			Date d = new Date(); 
			Stmt.executeQuery("update host SET LAST_CONNECT='"+d.toString()+"' where HOST_NAME='"+hostName+"' LIMIT 1");
			Stmt.close();
			Conn.close();
		} catch (Exception E) { 
			System.out.println("Connection failed : " + E.getMessage()); 
		}
	}

	synchronized public void addHost(String hostName, String isApplet) {
		Connection Conn = null;
		Statement Stmt;

		try {
			Conn = DriverManager.getConnection( CONNECTION_STRING );  
			Stmt = Conn.createStatement();
			// Check host table for record with this hostName
			Date d = new Date(); 
			Stmt.executeQuery("insert into host values ('"+hostName+"','"+d.toString()+"',"+(isApplet.equals("true")?1:0)+")");
			Stmt.close();
			Conn.close();
		} catch (Exception E) { 
			System.out.println("Connection failed : " + E.getMessage()); 
		}
	}

	
	// DATA ///////////
	synchronized public void checkInFile(String hostName,String fileNameLoc) {
		Connection Conn = null;
		Statement Stmt;

		try {
			Conn = DriverManager.getConnection( CONNECTION_STRING );  
			Stmt = Conn.createStatement();
			// update the datafile entry with the hostname of the 
			//  client who checked in the file
			Date d = new Date();
			Stmt.executeQuery("update input_data SET CHECKED_IN_BY='"+hostName+"',DATE_MODIFIED='"+d.toString()+"'  where FILE_NAME_LOC='" + fileNameLoc+"' LIMIT 1");
			Stmt.close();
			Conn.close();
		} catch (Exception E) { 
			System.out.println("Connection failed : " + E.getMessage()); 
		}
	}

	synchronized private String getDataFileLoc(String processId,String hostName) {
		Connection Conn = null;
		ResultSet r = null;
		Statement Stmt;
		int count = 0;
		int SUCCESSFUL_EXIT = 10;
		String fileNameLoc  = null;

		// Get the next data file name 
		try {
			Conn = DriverManager.getConnection( CONNECTION_STRING );  
			Stmt = Conn.createStatement();
			while (count <= 1) {	// protection against infinte loops
				// Get data file based on Process ID 
				r = Stmt.executeQuery("select FILE_NAME_LOC from input_data where REFERENCED=0 AND PROCESS_ID='"+processId+"' LIMIT 1");

				// Next data file
				fileNameLoc = r.getString("FILE_NAME_LOC");

				if (fileNameLoc != null) {
					// Update db reference
					Date d = new Date();
					Stmt.executeQuery("update input_data SET REFERENCED=REFERENCED+1,CHECKED_OUT_BY='"+hostName+"',DATE_MODIFIED='"+d.toString()+"' where PROCESS_ID='" + processId +"' AND FILE_NAME_LOC='"+fileNameLoc+"' LIMIT 1");
					count = SUCCESSFUL_EXIT;
				} else {
					// This means that either the the table
					// is empty or it needs to be reset
					System.out.println("Query (getDataFileLoc) returned no results... Reseting the data_input table based on PROCESS_ID="+processId+" ...");
					Stmt.executeQuery("update input_data SET REFERENCED=0 where PROCESS_ID='"+processId+"'");
					Stmt.close();
					Stmt = Conn.createStatement();
					count++;
				}
			}

			r.close();
			Stmt.close();
			Conn.close();
		} catch (Exception E) { 
			System.out.println("Connection failed : " + E.getMessage()); 
		}

		if (count != SUCCESSFUL_EXIT) {
			System.out.println("(getDataFileLoc()) an error occured. Returning NULL...");
		}

		return fileNameLoc;
	}

	// PROCESS ////////// 
	synchronized private boolean sendAllProcessClasses(String hostName, String processId) {
		String processFileName = null;
		String processName = null;
		String processNameLoc = null;
		Connection Conn = null;
		ResultSet r;
		Statement Stmt;
		boolean retVal = true;
		String numFiles = null;
		byte[] b = null;

		try {
			Conn = DriverManager.getConnection( CONNECTION_STRING );  
			Stmt = Conn.createStatement();

			// Must first send Number of files
			r = Stmt.executeQuery("select count(*) from process_files where PROCESS_ID='"+processId+"'");

			numFiles = r.getString(1);

			if (numFiles != null) {
				if (!numFiles.equals("0")) {
					// ////////////////////////////////// //
					// // API VERSION 2                // //
					// // Changes to this code require // //
					// // the API version to be        // //
					// // incremented                  // //
					// ////////////////////////////////// //
					send(clientsProcessPort,hostName,numFiles);
					// ////////////////////////////////// //
					System.out.println("Sending ("+numFiles+") class files to "+hostName+".");
				} else {
					System.out.println("The count for process_file returned a 0 result.\n");
					retVal = false;
				}
			} else {
				System.out.println("The count for process_file returns no results.\n");
				retVal = false;
			}

			if (retVal) {
				// ////////////////////////////////////////////// //
				// // API VERSION 2                            // //
				// // Changes to this code require the API     // //
				// // version to be incremented                // //
				// ////////////////////////////////////////////// //
				// Now send each file
				r = Stmt.executeQuery("select PROCESS_CLASS,PROCESS_CLASS_LOC from process_files where PROCESS_ID='" + processId + "'");

				while (r.next()) {
					processName = r.getString("PROCESS_CLASS");
					processNameLoc = r.getString("PROCESS_CLASS_LOC");

					System.out.println("PROCESS_CLASS = "+processName);

					processFileName = PROCESS_DIR+processNameLoc;

					// Send the process in byte array form
					File f = new File( processFileName );
	
					b = compressFile( processFileName );
	
					sendData(clientsProcessPort,hostName,b,(int)f.length(),processName);

				}
				r.close();
				// ////////////////////////////////////////////// //
			}

			Stmt.close();
			Conn.close();
		} catch (Exception e) { 
			System.out.println("Connection failed : " + e.getMessage()); 
			retVal = false;
		}

		return(retVal);
	}

	synchronized private String getProcessDescription(String processId) {
		String processDesc = null;
		Connection Conn = null;
		ResultSet r;
		Statement Stmt;

		// Get the process description
		try {
			Conn = DriverManager.getConnection( CONNECTION_STRING );  
			Stmt = Conn.createStatement();
			r = Stmt.executeQuery("select PROCESS_DESC from process_desc where PROCESS_ID='" + processId + "' LIMIT 1");
			processDesc = r.getString("PROCESS_DESC");
			r.close();
			Stmt.close();
			Conn.close();
		} catch (Exception e) { 
			System.out.println("Connection failed : " + e.getMessage()); 
		}

		if (processDesc == null) {
			System.out.println("(getProcessDescription()) an error occured.  Returning null.");
		}

		return( processDesc );
	}

	// SCHEDULE //////
	synchronized private String getNextProcessInQueue() {
		String processId = null;
		Connection Conn = null;
		ResultSet r = null;
		Statement Stmt;
		int count = 0;
		int SUCCESSFUL_EXIT = 10;

		try {
			Conn = DriverManager.getConnection( CONNECTION_STRING );  
			Stmt = Conn.createStatement();

			while (count <= 1) {	// protection against infinte loops
				// Get next Process ID from "schedule"
				r = Stmt.executeQuery("select PROCESS_ID from schedule where REFERENCED=0 LIMIT 1");

				// Process ready for distributing
				processId = r.getString("PROCESS_ID");

				if (processId != null) {
					// Update db reference
					Stmt.executeQuery("update schedule SET REFERENCED=REFERENCED+1 where PROCESS_ID='" + processId +"' LIMIT 1");
					count = SUCCESSFUL_EXIT;
				} else {
					// This means that either the the table
					// is empty or it needs to be reset
					System.out.println("Query (getNextProcessInQueue()) returned no results... Reseting the schedule table...");
					Stmt.executeQuery("update schedule SET REFERENCED=0 where REFERENCED>0");
					Stmt.close();
					Stmt = Conn.createStatement();
					count++;
				}
			}

			r.close();
			Stmt.close();
			Conn.close();
		} catch (Exception E) { 
			System.out.println("Connection failed : " + E.getMessage()); 
		}

		if (count != SUCCESSFUL_EXIT) {
			System.out.println("(getNextProcessInQueue()) an error occured. [table may be empty]  Returning NULL...");
		}

		return processId;
	}

	// ////////////////////////////////////////////////////////////////////
	// ////////////////////////////////////////////////////////////////////

	// Retrieve the necessary data file and send it////////////////////////
	// THIS SHOULD BE CALLED BEFORE PROCESS ///////////////////////////////
	synchronized public boolean sendDataFile(String hostName,boolean nextFile){
		String fileName    = null;
		String fileNameLoc = null;
		String processId   = null;
		byte[] b           = null;
		boolean retVal     = true;

		// Applets receive there input files differently
		if (getInfo(hostName,"isApplet").equals("true")) {
			// Retrieve file for this applet
			fileNameLoc = getDataFileLoc(getInfo(hostName,"process"),hostName);
				
			if (fileNameLoc == null) {
				System.out.println("input_data did not return a 'flie_name_loc' for applet ("+hostName+")\n");
				retVal = false;
			} else {
				// Update the client vector
				putInfo(hostName,"data",fileNameLoc);
			}
		} else if (nextFile || getInfo(hostName,"data") == null) {
			// Get next process out of schedule
			processId = getNextProcessInQueue();

			if (processId != null) {
				putInfo(hostName,"process",processId);

				// Retrieve a new file
				fileNameLoc = getDataFileLoc(processId,hostName);
				
				if (fileNameLoc == null) {
					System.out.println("input_data did not return a 'flie_name_loc'\n");
					retVal = false;
				} else {
					// Update the client vector
					putInfo(hostName,"data",fileNameLoc);
				}
			} else {
				System.out.println("schedule did not return a 'process_id'\n");
				retVal = false;
			}
		} else { 
			// Send current file
			fileNameLoc = getInfo(hostName,"data");
		}

		if (retVal) {
			// Display the data input file name
			System.out.println("Filname = " + fileNameLoc);

			fileName = DATA_IN_DIR + fileNameLoc;
			
			File f = new File(fileName);
			b = compressFile(fileName);

			// ////////////////////////////////////////////// //
			// // API VERSION 2                            // //
			// // Changes to this code require the API     // //
			// // version to be incremented                // //
			// ////////////////////////////////////////////// //
			sendData(clientsDataPort,hostName,b,(int)f.length(),fileNameLoc);
			// ////////////////////////////////////////////// //
		} else {
			System.out.println("No data has been sent to (" + hostName + ")\n");
		}

		return retVal;
	}
 
	// Select the proper process class and send to client /////////////////
	synchronized public boolean sendProcess(String hostName) {
		String processDesc = null;
		String processId = null;
		boolean retVal = true;

		
		// Get process classes
		processId = getInfo(hostName,"process");

		if (processId == null) {
			System.out.println("Process ID is null for ("+hostName+")");
			retVal = false;
		}
					
		if (retVal) {
			processDesc = getProcessDescription(processId);

			// ////////////////////////////////////////// //
			// // API VERSION 2                        // //
			// // Changes to this code require the API // //
			// // version to be incremented            // //
			// ////////////////////////////////////////// //
			// Send Process Name (30 character value)
			boolean t = send(clientsProcessPort,hostName,processDesc);
			// ////////////////////////////////////////// //

			// If applet skip sending any of the class files
			if (getInfo(hostName,"isApplet").equals("false")) {
				retVal = sendAllProcessClasses(hostName,processId);
			}
		}

		if (!retVal) {
			System.out.println("Sending process classes failed.  No classes were sent.");
		}

		return retVal;
	} 

	// Send File Procedure ////////////////////////////////////////////////
	synchronized private byte[] compressFile(String fileName) {
		FileInputStream fstream;
		DataInputStream d;
		byte b[] = null;
               		
		File f = new File(fileName);

		// Compress the file into a byte array
		try {
			fstream = new FileInputStream( fileName );
			d = new DataInputStream( fstream );

			b = new byte[(int)f.length()];
	
			d.read(b,0,(int)f.length());
	
			d.close();
		} catch (Exception e) {
			System.out.println("(compressFile()) File input error: " + e.getMessage());
		}
        
		return b;
	}


} // end of Server

// Frame Class ///////////////////////////////////////////////////////////
class ExitFrame extends Frame {
	public Server srv;
	
	ExitFrame(String s) {
		super(s);
	}

	// This class is no longer generic as I hoped.  
	//  It is now specific for Server.  Oh well.
	public boolean handleEvent(Event e) {
		if (e.id == Event.WINDOW_DESTROY) {
			srv.closeServerConnections(); 
			setVisible(false);
			dispose();
			System.exit(0);
		}
		return super.handleEvent(e);
	}
}

// // Handles the Status connection from clients ////////////////////////////
class serverStatusRec extends Thread {
	private Server srv;
	private Socket sock;
	private DataOutputStream remoteOut;
	private DataInputStream remoteIn;
	private String hostName;
	public boolean listening = true;

	public serverStatusRec(Server srv, Socket sock) throws IOException {
		this.srv = srv;
		this.sock = sock;
		remoteIn = new DataInputStream(sock.getInputStream());
		this.hostName = sock.getInetAddress().getHostName();
	}

	public synchronized void run() {
		FileOutputStream out;
		DataOutputStream p;
		int length = 0;
		byte b[]   = null;
		String s;
		String process = null;

		// The client is now connected to the server.  Check to see if 
		//  this is a new client or returning client.
		if (srv.newHost(hostName)) {
			// New Client:Retreive HOST_INFO
			// ////////////////////////////////////////// //
			// // API VERSION 2                        // //
			// // Changes to this code require the API // //
			// // version to be incremented            // //
			// ////////////////////////////////////////// //
			srv.send(srv.clientsStatusPort,hostName, "HOST_INFO" );
			// ////////////////////////////////////////// //
		} else {
			// Returning Client:Update last connection date
			srv.updateConnectionDate(hostName);
		}
			
			
		try {
			while (listening) {

				// ////////////////////////////////////////// //
				// // API VERSION 2                        // //
				// // Changes to this code require the API // //
				// // version to be incremented            // //
				// ////////////////////////////////////////// //
				s = remoteIn.readUTF();
				srv.statusText.append(sock.getInetAddress().getHostName() + ": " + s + "\n");
                
				if (s.equals("ERROR_IP_DL")) {
					// Resend Ip address
					System.out.println(" -------------- ERROR_IP_DL ------- ("+hostName+") ------------- ");
					srv.send(srv.clientsIpPort,sock.getInetAddress().getHostName(), srv.srvIpSocket.getInetAddress().getHostName() );
					srv.ipText.append(sock.getInetAddress().getHostName() + ": Ip updated\n");
					System.out.println(" --------------------------------------------------------------- \n");
				} else if (s.equals("ERROR_DATA_DL")) {
					System.out.println(" -------------- ERROR_DATA_DL ----- ("+hostName+") ------------- ");
					process = srv.getInfo(hostName,"process");
					if (process != null) {
						// Retrieve The Old File and resend
						if (srv.sendDataFile(hostName,false)) {
							srv.dataText.append(sock.getInetAddress().getHostName() + ": Old data file resent\n");
						} else {
							srv.dataText.append(sock.getInetAddress().getHostName() + ": An error occured while sending the old data file.\n");
						}
					} else {
						// This client must have just 
						// checked in with this error.
						// Thus must reissue both.

						// Send data file
						if (srv.sendDataFile(hostName,true)) {
							srv.dataText.append(hostName+" "+ srv.getInfo(hostName,"data") +" sent\n");
							// Send a process .... 
							if (srv.sendProcess(sock.getInetAddress().getHostName())) {
								srv.processText.append(sock.getInetAddress().getHostName() + ": " + srv.getInfo(hostName,"process") + " sent.\n");
							} else {
								srv.processText.append(sock.getInetAddress().getHostName() + ": An error occured while sending the process class ("+ srv.getInfo(hostName,"process") +")\n");
							}
						} else {
							srv.dataText.append(sock.getInetAddress().getHostName() + ": An error occured while sending the data file ("+ srv.getInfo(hostName,"data") +")\n");
						}
					}
					System.out.println(" --------------------------------------------------------------- \n");
				} else if (s.equals("ERROR_PROCESS_DL")) {
					System.out.println(" -------------- ERROR_PROCESS_DL -- ("+hostName+") ------------- ");
					// Retrieve The Old Process and resend
					if (srv.sendProcess(sock.getInetAddress().getHostName())) {
						srv.processText.append(sock.getInetAddress().getHostName() + ": " + srv.getInfo(hostName,"process") + " sent.\n");
					} else {
						srv.processText.append(sock.getInetAddress().getHostName() + ": An error occured while sending the process class ("+ srv.getInfo(hostName,"process") +")\n");
					}
					System.out.println(" --------------------------------------------------------------- \n");
				} else if (s.equals("RECEIVING")) {
					System.out.println(" -------------- RECEIVING --------- ("+hostName+") ------------- ");
					// Retrieve A New File and send
					if (srv.sendDataFile(hostName,true)) {
						srv.dataText.append(hostName+" "+ srv.getInfo(hostName,"data") +" sent\n");
						// Send process
						if (srv.sendProcess(sock.getInetAddress().getHostName())) {
							srv.processText.append(sock.getInetAddress().getHostName() + ": " + srv.getInfo(hostName,"process") + " sent.\n");
						} else {
							srv.processText.append(sock.getInetAddress().getHostName() + ": An error occured while sending o sent process class ("+ srv.getInfo(hostName,"process") +")\n");
						}
					} else {
						srv.dataText.append(sock.getInetAddress().getHostName() + ": An error occured while sending the data file ("+ srv.getInfo(hostName,"data") +")\n");
					}
					System.out.println(" --------------------------------------------------------------- \n");
				} else if (s.equals("READY")) {
					System.out.println(" -------------- READY ------------- ("+hostName+") ------------- ");
					// Send data file
					if (srv.sendDataFile(hostName,true)) {
						srv.dataText.append(hostName+" "+ srv.getInfo(hostName,"data") +" sent\n");
						// Send a process .... 
						if (srv.sendProcess(sock.getInetAddress().getHostName())) {
							srv.processText.append(sock.getInetAddress().getHostName() + ": " + srv.getInfo(hostName,"process") + " sent.\n");
						} else {
							srv.processText.append(sock.getInetAddress().getHostName() + ": An error occured while sending o sent process class ("+ srv.getInfo(hostName,"process") +")\n");
						}
					} else {
						srv.dataText.append(sock.getInetAddress().getHostName() + ": An error occured while sending the data file ("+ srv.getInfo(hostName,"data") +")\n");
					}
					System.out.println(" --------------------------------------------------------------- \n");
				} else if (s.equals("TRANSMITTING") || s.equals("PROCESSING_COMPLETE") || s.equals("PROCESSING") || s.equals("PROCESSING_COMPLETE")) {
					// Nothing is necessary RIGHT NOW
				} else if (s.startsWith("CHECKIN_")) {
					System.out.println(" -------------- "+s+" ------- ("+hostName+") ------------- ");
					// This is an applet. 
					srv.putInfo(hostName,"isApplet","true");

					// Store the process ID
					String temp = "CHECKIN_";	
					srv.putInfo(hostName,"process",s.substring(temp.length()));

					// Send data file
					if (srv.sendDataFile(hostName,true)) {
						srv.dataText.append(hostName+" [applet] "+ srv.getInfo(hostName,"data") +" sent\n");
					} else {
						srv.dataText.append(sock.getInetAddress().getHostName() + ": An error occured while sending the data file ("+ srv.getInfo(hostName,"data") +")\n");
					}
					// Send a process Description.... 
					if (srv.sendProcess(sock.getInetAddress().getHostName())) {
						srv.processText.append(sock.getInetAddress().getHostName() + ": " + srv.getInfo(hostName,"process") + " sent.\n");
					} else {
						srv.processText.append(sock.getInetAddress().getHostName() + ": An error occured while sending o sent process class ("+ srv.getInfo(hostName,"process") +")\n");
					}
					System.out.println(" --------------------------------------------------------------- \n");
				} else {
					try {
						length = Integer.parseInt(s);

						System.out.println(" -------------- HOST_INFO --------- ("+hostName+") ------------- ");
						// This is the contents of HOST_INFO
						// Add record to db 
						srv.addHost(hostName,srv.getInfo(hostName,"isApplet"));

						// Initilize the byte array
						b = new byte[length];

						// Read in array of bytes
						if (b != null) {
							try {
								// ////////////////////////////////////////////// //
								// // API VERSION 2                            // //
								// // Changes to this code require the API     // //
								// // version to be incremented                // //
								// ////////////////////////////////////////////// //
								remoteIn.readFully(b,0,length);
								// ////////////////////////////////////////////// //
								try {
									// Save HOST_INFO to file.
									out = new FileOutputStream( srv.HOST_DIR + hostName );
									p = new DataOutputStream( out );
									p.write(b,0,length);
									p.close();	
									System.out.println("File ("+srv.HOST_DIR + hostName+") with host information.");
								} catch (Exception e) {
									System.out.println("Error writing to file: "+e.getMessage());
								}
							} catch(IOException e) {
							}
						}
						System.out.println(" --------------------------------------------------------------- \n");
					} catch (NumberFormatException x) {
						length = 0;
					}
				} 
				// ////////////////////////////////////////// //

			}

		} catch (IOException e) {
			srv.statusText.append(hostName + " has disconnected: " + e.getMessage() + "\n");
			srv.ipText.append(hostName + " has disconnected: " + e.getMessage() + "\n");
			srv.processText.append(hostName + " has disconnected: " + e.getMessage() + "\n");
		} finally {
			try {
				cleanUp();
			} catch (IOException x) {
			}
		}
	}

	private void cleanUp() throws IOException {
		if (remoteOut != null) {
			srv.removeFromClients(srv.clientsIpPort,remoteOut);
			srv.removeFromClients(srv.clientsProcessPort,remoteOut);
			srv.removeFromClients(srv.clientsStatusPort,remoteOut);
			remoteOut.close();
			remoteOut = null;
		}
		if (remoteIn != null) {
			remoteIn.close();
			remoteIn = null;
		}
		if (sock != null) {
			sock.close();
			sock = null;
		}
	}
}

// // Data Receive Class //////////////////////////////////////////////////////
class serverDataRec extends Thread {
	private Server srv;
	private DataOutputStream remoteOut;
	private DataInputStream remoteIn;
	private Socket sock;
	private String hostName;
	private String fileName;
	public boolean listening = true;
	FileOutputStream out;
	DataOutputStream p;
	byte b[] = null;

	public serverDataRec(Server srv,Socket sock,DataOutputStream remoteOut){
		this.srv = srv;
		this.remoteOut = remoteOut;
		this.sock = sock;
		this.hostName = sock.getInetAddress().getHostName();
	}

	public synchronized void run() {
		String s        = null;
		String fileName = null;
		String outputFileName = null;
		int length      = 0;

		try {
			remoteIn = new DataInputStream(sock.getInputStream());

			while (listening) {
				// Download File and write to file
				// Read byte array length from client
				s = null;
				fileName = null;

				// ////////////////////////////////////////// //
				// // API VERSION 2                        // //
				// // Changes to this code require the API // //
				// // version to be incremented            // //
				// ////////////////////////////////////////// //
				fileName = remoteIn.readUTF();	// file name
				// ////////////////////////////////////////// //

				System.out.println(" -------------- TRANSMITTING/RECEIVING - ("+hostName+") ------------- ");

				if (fileName != null) {
					try {
						// ////////////////////////////////////////// //
						// // API VERSION 2                        // //
						// // Changes to this code require the API // //
						// // version to be incremented            // //
						// ////////////////////////////////////////// //
						s = remoteIn.readUTF();	// size 
						// ////////////////////////////////////////// //

						length = Integer.parseInt(s);

						// Initilize the byte array
						b = new byte[length];

						// Read in array of bytes
						if (b != null) {
							try {

								// ////////////////////////////////////////////// //
								// // API VERSION 2                            // //
								// // Changes to this code require the API     // //
								// // version to be incremented                // //
								// ////////////////////////////////////////////// //
								remoteIn.readFully(b,0,length);
								// ////////////////////////////////////////////// //

							} catch(IOException e) {
							}
						}
					} catch (NumberFormatException x) {
						length = 0;
					}
				}

				// File retreived and stored in b

				try {
					// Checkin the input file

					srv.checkInFile(hostName,fileName);
					// Start to build the output file name
					outputFileName = srv.DATA_OUT_DIR + fileName;

					if (srv.APPEND_HOSTNAME) {
						outputFileName = outputFileName+"."+hostName;
					}

					if (srv.APPEND_TIME_STAMP) {
						long currentTime = new Date().getTime();
						outputFileName = outputFileName+"."+String.valueOf(currentTime);
					}
						

					out = new FileOutputStream( outputFileName );
					p = new DataOutputStream( out );
					p.write(b,0,length);
					p.close();					
					srv.dataText.append(sock.getInetAddress().getHostName() + ": File received\n"); 
				} catch (Exception e) {
					// This may happen at start up.  It is
					//  OK but NOT GOOD!
					System.out.println("Error writing to file: "+e.getMessage());
				}
       
				// Issue another file to Client
				// Retrieve A New File and send

				// ////////////////////////////////////////// //
				// // API VERSION 2                        // //
				// // Changes to this code require the API // //
				// // version to be incremented            // //
				// ////////////////////////////////////////// //
				if (srv.sendDataFile(hostName,true)) {
					fileName = srv.getInfo(hostName,"data");
					srv.dataText.append(hostName+" "+fileName+" sent\n");   
					// if this is not an applet connection 
					// Send a process 
					if (srv.sendProcess(sock.getInetAddress().getHostName())) {
						srv.processText.append(sock.getInetAddress().getHostName() + ": " + srv.getInfo(hostName,"process") + " sent.\n");
					} else {
						srv.processText.append(sock.getInetAddress().getHostName() + ": An error occured while sending o sent process class ("+ srv.getInfo(hostName,"process") +")\n");
					}
				} else {
					srv.dataText.append(sock.getInetAddress().getHostName() + ": An error occured while sending the data file ("+ srv.getInfo(hostName,"data") +")\n");
				}
				// ////////////////////////////////////////////// //
				System.out.println(" -------------------------------------------------------------------- \n");

			} // end of while
		} catch (IOException e) {
			srv.dataText.append(hostName + " has disconnected: " + e.getMessage() + "\n");         
		} finally {
			try {
				cleanUp();
			} catch (IOException x) {
			}
		}
	} //end of run

	private void cleanUp() throws IOException {
		if (remoteOut != null) {
			srv.removeFromClients(srv.clientsDataPort,remoteOut);
			remoteOut.close();
			remoteOut = null;
		}
		if (remoteIn != null) {
			remoteIn.close();
			remoteIn = null;
		}
		if (sock != null) {
			sock.close();
			sock = null;
		}
	}
}
