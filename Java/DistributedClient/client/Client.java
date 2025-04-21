// ////////////////////////////////////////////////////////////////////////
// //                                                                    //
// //  Aurthor     :  ...                                                 //
// //                                                                    //
// //  Email       :  ...                                                //
// //                                                                    //
// //  Web address :  ...                                                //
// //                                                                    //
// //  Date        :  June 2000 - March 2001                             //
// //                                                                    //
// //  Updated     :  (05-16-2001) Resolved an java.lang.LinkageError    //
// //                 (03-23-2001) Disconnect from the server when the   //
// //                    client is processing.                           //
// //                 (02-23-2001) Added a class loader.  This eliminates// 
// //                    the need to have a thread class called engine.  //
// //                    It also will allow the switching of classes sent//
// //                    by the server.                                  //
// //                 (02-10-2001) Updated the API to inclue support for://
// //                    - Collecting host information (OS,..)           //
// //                    - Storing data file name                        //
// //                    - Process can contain multiple classes          //
// //                 (12-16-2000) Improved the user interface.          //
// //                                                                    //
// ////////////////////////////////////////////////////////////////////////

import java.io.*;
import java.net.*;
import java.awt.*;
import java.lang.*;
import java.util.Date;
import java.util.*;
import java.awt.event.*;
import java.lang.System.*;
import java.lang.reflect.*;

public class Client extends Panel {
	public static Socket ipSocket,dataSocket,processSocket,statusSocket;
	public DataOutputStream outIp,outData,outProcess,outStatus;

	private static UserInterface canvas;

  	public static String INI_FILE      = "client.ini";
  	public static String DATA_IN_FILE  = "data/current.data";
  	public static String DATA_OUT_FILE = "data/processed.data";
	private static String LOG_FILE     = "log.txt";
	private static int CLIENT_WIDTH    = 400;
	private static int CLIENT_HEIGHT   = 265;

	public static String classNames[];
	public Thread processThread = null;
	private ClassLoader ld = new engineClassLoader();

	private static String serverIp           = null;
  	private static String CURRENT_STATUS     = null;
	private static String CURRENT_PROCESS    = null;
	private static long NUM_BLOCKS_PROCESSED = 0;
	private static int PERCENT_COMPLETED     = 0;
	private static String DATAFILE_NAME      = null;	// Filename used by server
	private static long secondsAtStart;
	private static double previousSeconds    = -1;
	private Frame frame;
	private static int ipPort      = 3000;
	private static int dataPort    = 3001;
	private static int processPort = 3002;
	private static int statusPort  = 3003;
  	private static ClientIpRec cir      = null;  //Ip receive thread
  	private static ClientDataRecSnd cdr = null;  //Data receive/send thread
	private static ClientProcessRec cpr = null;  //Process receive thread
	private static ClientStatus csr     = null;  //Status send thread
	private InetAddress serverAddr = null;

	// //////////////// INTERFACE HIDING /////////////////////////////////
	public void saveToFile() {
		FileOutputStream out;
		PrintWriter p;

		try {
			out = new FileOutputStream( INI_FILE );
			// Connect print stream to the output stream
			p = new PrintWriter( out );
			p.println( serverIp );
			p.println( CURRENT_STATUS );
			p.println( CURRENT_PROCESS );
			p.println( String.valueOf(NUM_BLOCKS_PROCESSED) );
			p.println( DATAFILE_NAME );

			// Save the class names to the ini file
			if (classNames != null) {
				String temp = classNames[0];
				for (int i=1; i<classNames.length; i++) {
					temp = temp + "," + classNames[i];
				}
				p.println(temp);
			} else {
				p.println("null");
			}
			p.close();
		} catch (Exception e) {
		}
		// Update the User Interface
		paintInterface();
	}

	synchronized static public void logEvent(String s) {
		FileOutputStream out;
		PrintWriter p;
		Date d = new Date();

		// Check if file is too large
		//  then take care of it
		File f = new File(LOG_FILE);
		if ((int)f.length() > 50000) {
			f.delete();
			// This is a recursive call.  It will create the log file
			//  containing this message.
			logEvent(" -- Log file exceeded 50 kb --  Deleted");
		}

		try {
			out = new FileOutputStream( LOG_FILE ,true);
			// Connect print stream to the output stream
			p = new PrintWriter( out );
			p.println( d.toString() + ": " + s );
			p.close();
		} catch (Exception e) {
		}
	}

	synchronized static public boolean parseClassNames(String params) {
		// This input is a string of class names seperated by ,'s
		int locA = 0;	// Alwalys at the begining of the string
		int locB = 0;	// Pointing at next coma
		int ct  = 1;
		boolean retVal = true;

		if (params != null && !params.equals("null")) {
			// Count the comas (+1) this will represent the number of class names
			while ((locB = params.indexOf(",",locA)) != -1) {
				locA = locB+1;		// advance 1 character
				ct++;
			}
	
			// Create the String array
			classNames = new String[ct];
		
			locA = 0;
			locB = 0;
			for (int i=0; i<ct; i++) {
				locB = params.indexOf(",",locA);

				if (locB != -1) {
					classNames[i] = params.substring(locA,locB);
					locA = locB+1;
				} else {
					// This is the last class name to load
					classNames[i] = params.substring(locA);
				}
			}
		} else {
			logEvent("parseClassNames(String) had a null parameter");
			retVal = false;
		}

		return retVal;
	}

	synchronized private boolean loadClasses() {
		boolean retVal = true;

		if (classNames != null) {
			// Interate through list of classes and load them into memory
			Class c = null;

			for (int i=0; i<classNames.length; i++) {
				// Load the class into memory
				try {
					c = ld.loadClass( classNames[i] );

					if (c == null) {
						// If the class was not loaded it will return null. This will cause 
						//  a problem the next time they restart they will connect with the 
						//  Server from scratch
						updateStatus("READY");
					}
				} catch (ClassNotFoundException e) {
					logEvent("loadClasses() ClassNotFoundException ("+classNames[i]+") : " +e.getMessage());
					
				}
			}
		} else {
			logEvent("loadClasses() class names contains currupt data.");
			retVal = false;
		}

		return retVal;
	}

	synchronized public void percentCompleted(int per) {
		// INPUT: integer 0 <= per <= 100
		if (per < 0) { per = 0; }
		if (per > 100) { per = 100; }

		PERCENT_COMPLETED = per;

		// Update the User Interface
		paintInterface();
	}

	synchronized public int getPercentCompleted() {
		return PERCENT_COMPLETED;
	}

	// After Completion clean up the connections
	public void cleanUpOutputStreams() {
		// Clean up all the unneceassary OutputStreams
		try {
			if (outIp != null) { outIp.close(); }
			if (outData != null) { outData.close(); }
			if (outProcess != null) { outProcess.close(); }
			if (outStatus != null) { outStatus.close(); }
		} catch (IOException e) {
		}
		
	}

	public void cleanUpSockets() {
		//clean up unnecessary Sockets
		try {
			if (ipSocket != null) { ipSocket.close(); }
			if (dataSocket != null) { dataSocket.close(); }
			if (processSocket != null) { processSocket.close(); }
			if (statusSocket != null) { statusSocket.close(); }
		} catch (IOException e) {
		}
	}

	// Update Variables
	public void updateClassNames() {
		saveToFile();		
	}

	public void updateStatus(String status) {
		CURRENT_STATUS = status;
		saveToFile();
	}
	
	public void updateSrvIp(String ip) {
		serverIp = ip;
		saveToFile();
		// Kill the sockets so that they are forced
		//  to reconnect to the new server
		cleanUpSockets();
	}

	public void updateProcess(String process) {
		CURRENT_PROCESS = process;
		saveToFile();
	}

	public void updateBlocksCompleted(long numBlocks) {
		NUM_BLOCKS_PROCESSED = numBlocks;
		saveToFile();
	}

	public void updateDataFileName(String str) {
		DATAFILE_NAME = str;
		saveToFile();
	}

	public void incrementBlocksCompleted() {
		NUM_BLOCKS_PROCESSED++;
		saveToFile();
	}

	// Get Variables	
	public String getStatus() {
		return CURRENT_STATUS;
	}
	
	public String getIp() {
		return serverIp;
	}

	public String getProcess() {
		return CURRENT_PROCESS;
	}

	public long getBlocksCompleted() {
		return NUM_BLOCKS_PROCESSED;
	}

	public String getDataFileName() {
		return DATAFILE_NAME;
	}

	public void sendStatus() {
		try {
			outStatus.writeUTF( getStatus() );
		} catch (IOException x) {
		}
	}

	public void startProcess(Client clnt) {
		updateStatus("PROCESSING");
		
		Class c = null;
		int classNameIndex = 0;

		// Load the process classes
		if (loadClasses()) {

			// Try the first class sent from the server.
			//  If that is not the one then try another.
			while (classNameIndex < classNames.length) {
				try { try { try { try { try {
					c = Class.forName(classNames[classNameIndex]);
	
					// Get the default constructor to this class
					Constructor con[] = c.getConstructors();
		
					// Create a list of the parameters to be passed to the constructor
					Object o[] = new Object[3];
	
					o[0] = DATA_IN_FILE;
					o[1] = DATA_OUT_FILE;
					o[2] = clnt;

					// Create new instance
					processThread = (Thread)con[0].newInstance(o);

					// Set thread to low priority and start
					processThread.setPriority(processThread.MIN_PRIORITY);
					processThread.start();

					// The proper class has been started.
					classNameIndex = classNames.length;

				} catch (IllegalArgumentException e)  { logEvent("startProcess() IllegalArgumentException : " + e.getMessage());          }
				} catch (ClassNotFoundException e)    { logEvent("startProcess() ClassNotFoundException : " + e.getMessage());            }
				} catch (IllegalAccessException e)    { logEvent("startProcess() IllegalAccessException : " + e.getMessage());            }
				} catch (InvocationTargetException e) { logEvent("startProcess() reflect.InvocationTargetException : " + e.getMessage()); }
				} catch (InstantiationException e)    { logEvent("startProcess() InstantiationException : " + e.getMessage());            }
			
				// At this point it is either the proper class (and classNameIndex == classNames.length)
				//  or it is not proper class and it should try another one.
				classNameIndex++;
			}

			// Terminate the connection to the server
			cleanUpOutputStreams();
			cleanUpSockets();

			// Set time stamp
			secondsAtStart = new Date().getTime();
		
			// Wait for process to finish
			try {
				processThread.join();
			} catch (InterruptedException e) {
			}
			
			if (getPercentCompleted() == 100) {
				// Clean up files?
				File f;
				for (int i=0; i<classNames.length; i++) {
					f = new File(classNames[i] +".class");
					f.delete();
				}

				// Upload File to Server Now
				updateStatus("TRANSMITTING");
				if (!sendFile(DATA_OUT_FILE,getDataFileName())) {
					logEvent(DATA_OUT_FILE + " (" + getDataFileName() + ") was not sent");
				}
				incrementBlocksCompleted();
				percentCompleted(0);

	
				logEvent(DATA_OUT_FILE + " completed");
			} 
			// else either the process was interupted or
			//  the entire program has been stopped

		} else {
			logEvent("An error occured while attempting to load classes into memory.");
		}
	}

	public void stopProcess() {
		processThread.interrupt();
		processThread.stop();
		// reset the percent completed counter
		percentCompleted(0);
	}
	
	public synchronized boolean sendFile(String filenam,String srvFileName){
		File f = new File(filenam);
		byte b[] = compressFile(filenam,(int)f.length());
		boolean ret = true;
				
		//Send completed file
		try {

			// ////////////////////////////////////////////// //
			// // API VERSION 2                            // //
			// // Changes to this code require the API     // //
			// // version to be incremented                // //
			// ////////////////////////////////////////////// //
			// First send server data file name 
			outData.writeUTF( srvFileName );
			outData.flush();
			// First send length
			outData.writeUTF(String.valueOf((int)f.length()));
			outData.flush();
			// Send the entire file byte by byte
			outData.write(b,0,(int)f.length());
			// ////////////////////////////////////////////// //

			logEvent("Data sent to server ...");
		} catch (IOException e) {
			logEvent("send file: " + e.getMessage());
			ret = false;
		}
		return ret;
	}

	// Compress File Procedure
	synchronized byte[] compressFile(String fileName,int len) {
		FileInputStream fstream;
		DataInputStream d;
		byte b[] = null;
               		
		// Compress the file into a string
		try {
			fstream = new FileInputStream( fileName );
			d = new DataInputStream( fstream );

			b = new byte[len];

			d.read(b,0,len);

			d.close();
		} catch (Exception e) {
			logEvent("compressFile input error: " + e.getMessage());
		}
        
		return b;
	}

	// //////////// USER INTERFACE ////////////////////////////////////////
	private static void displayStatus(String str) {
		canvas.updateStatus( str );
	}

	private void paintInterface() {
		// cut up date
		long currentTime = new Date().getTime();
		currentTime -= secondsAtStart;
		currentTime /= 1000;		// Convert from milliseconds
		double hours = Math.floor(currentTime/3600);
		double mins  = Math.floor((currentTime-(hours*3600))/60);
		double secs  = Math.floor(currentTime-(hours*3600+mins*60));

		if (secs != previousSeconds) {

			canvas.updateInterface(CURRENT_PROCESS,CURRENT_STATUS,serverIp,
				String.valueOf(NUM_BLOCKS_PROCESSED),
				PERCENT_COMPLETED,
				String.valueOf(hours) + " hrs " + String.valueOf(mins) + " mins " + String.valueOf(secs) + " secs");
			previousSeconds = secs;
		}
	}

	// /////////////// COMPONENT BUILDING ///////////////////////////////
	public Client(Frame f) {
		frame = f;

		setBackground(Color.black);

		canvas = new UserInterface(CLIENT_WIDTH,CLIENT_HEIGHT);
	
		add( canvas );
	}
    
	// //////////////////////// MAIN FUNCTION ////////////////////////
	public static void main(String args[]) {
		ExitFrame f = new ExitFrame("Client...");

		Client clnt = new Client(f);
		f.clnt = clnt;
		f.add("Center", clnt);
		//f.resize(CLIENT_WIDTH, CLIENT_HEIGHT);	// width, height
		f.setSize(CLIENT_WIDTH, CLIENT_HEIGHT);	// width, height
		f.setIconImage(Toolkit.getDefaultToolkit().getImage("icon.bmp"));
		f.setResizable(false);
		f.show();


		// READ settings FROM FILE 
		try {
			FileInputStream fstream = new FileInputStream( INI_FILE );
			//DataInputStream in = new DataInputStream(fstream);
			BufferedReader in = new BufferedReader(new InputStreamReader(fstream));

			// Only two setings
			clnt.serverIp = in.readLine();
			clnt.CURRENT_STATUS = in.readLine();
			CURRENT_PROCESS = in.readLine();
			try {
				NUM_BLOCKS_PROCESSED = Long.valueOf(in.readLine()).longValue();
			} catch (NumberFormatException x) {
				NUM_BLOCKS_PROCESSED = 0;
			}
			DATAFILE_NAME = in.readLine();
			// Read in the line of class names
			String temp = in.readLine();
			
			if (!parseClassNames(temp)) {
				// If the client was processing it will no longer be able to ... 
				//  thus if status was PROCESSING it will have to be READY now
				if (CURRENT_STATUS.equals("PROCESSING")) {
					logEvent("Process class file list is corupt.  Setting client status to READY");
					CURRENT_STATUS = "READY";
				}
				classNames = null;
			}
			in.close();
		} catch (Exception e) {
			logEvent("ini file input error");
			clnt.serverIp = "local";
			clnt.CURRENT_STATUS = "READY";
			CURRENT_PROCESS = "none";
			NUM_BLOCKS_PROCESSED = 0;
			Date d = new Date();
			DATAFILE_NAME = d.toString()+".bad";
			DATAFILE_NAME = DATAFILE_NAME.replace(':','-');
			classNames = null;
			clnt.saveToFile();
		} 

		if (serverIp.equals("local") || serverIp.equals("null")) {
			serverIp = null;
		}        

		// Create Threads
		cir = new ClientIpRec(clnt);		//Ip thread
		cdr = new ClientDataRecSnd(clnt);	//Data send/rec thread
		cpr = new ClientProcessRec(clnt);	//Process rec thread
		csr = new ClientStatus(clnt);		//Status send/rec thread

		// Set all the priorities to LOWEST
		cir.setPriority(cir.MIN_PRIORITY);
		cdr.setPriority(cdr.MIN_PRIORITY);
		cpr.setPriority(cpr.MIN_PRIORITY);
		csr.setPriority(csr.MIN_PRIORITY);

		// Connect to the server
		while (true) {
			try {
				if (!cir.isAlive() && !cdr.isAlive() && !cpr.isAlive() && !csr.isAlive()) {
					displayStatus("Connecting...");
					clnt.connect();
				}
			} catch (Exception e) {
			}
			// Stall for 20000 milliseconds == 20 seconds
			try {
				Thread dumby = new Thread();
				dumby.setPriority(dumby.MIN_PRIORITY);
				dumby.start();
				dumby.sleep(20000);
			} catch (InterruptedException e) {
			}

			// wait for all the threads to complete
			try {
				cir.join();
				cdr.join();
				cpr.join();
				csr.join();
			} catch (InterruptedException e) {
				
			}

		}
	}

	// //////////////////// CONNECT TO SERVER /////////////////////////////
	public void connect() {
		cleanUpOutputStreams();
		cleanUpSockets();
		try {
			// Obtain server ip information
			serverAddr = InetAddress.getByName(serverIp);

			// Establish Sockets and Data Streams
			ipSocket = new Socket(serverAddr.getHostName(), ipPort);
			outIp = new DataOutputStream(ipSocket.getOutputStream());

			dataSocket = new Socket(serverAddr.getHostName(), dataPort);
			outData = new DataOutputStream(dataSocket.getOutputStream());

			statusSocket = new Socket(serverAddr.getHostName(), statusPort);
			outStatus = new DataOutputStream(statusSocket.getOutputStream());

			processSocket = new Socket(serverAddr.getHostName(), processPort);
			outProcess = new DataOutputStream(processSocket.getOutputStream());
  
			// Create Threads
			cir = new ClientIpRec(this);
			cdr = new ClientDataRecSnd(this);
			cpr = new ClientProcessRec(this);
			csr = new ClientStatus(this);

			// Prepare to resume threads
			cir.listening = cdr.listening = cpr.listening = csr.listening = true;
			cir.start();cdr.start();cpr.start();csr.start();

			
			// Resume Normal Operation 
			if (getStatus().equals("TRANSMITTING")) {
				if (sendFile(DATA_OUT_FILE,getDataFileName())) {
					updateStatus("RECIEVING");
				}
			}

			// Send Status to Server
			try {
				outStatus.writeUTF( getStatus() );
			} catch (IOException x) {
			}

			// Start Process if "processing"
			if (getStatus().equals("PROCESSING")) {
				logEvent("Processing ... started");
				startProcess(this);
			}

		} catch (IOException e) {
 			cir.listening = cdr.listening = cpr.listening = csr.listening = false;
		}
	}
}	// END OF CLASS CLIENT



// Frame Class /////////////////////////////////////
class ExitFrame extends Frame {
	public Client clnt;

	ExitFrame(String s) {
		super(s);
	}

	public boolean handleEvent(Event e)  {
		if (e.id == Event.WINDOW_DESTROY) {
			clnt.logEvent("Cleaning up before closing...");
			clnt.cleanUpOutputStreams();
			clnt.cleanUpSockets();
			//hide();
			setVisible(false);
			dispose();
			System.exit(0);
		}
		return super.handleEvent(e);
	}
}	// end of ExitFrame

// Specific Client Classes

// STATUS CLASS ///////// COMPLETE //////////////////////////////////////////
class ClientStatus extends Thread {
	private Client clnt;
	private DataInputStream inStream;
	public boolean listening = false;

	public ClientStatus(Client clnt) {
		this.clnt = clnt;
	}

	public synchronized void run() {
		clnt.logEvent("STATUS checkin.");
		listening = true;
		String s = null;

		try {
			inStream = new DataInputStream(clnt.statusSocket.getInputStream());

			while (listening) {

				// ////////////////////////////////////////// //
				// // API VERSION 2                        // //
				// // Changes to this code require the API // //
				// // version to be incremented            // //
				// ////////////////////////////////////////// //
				// Read from server ("HOST_INFO" | GARBAGE)
				s = inStream.readUTF();
				// ////////////////////////////////////////// //

				clnt.logEvent("STATUS - Status requested"); 

				// ////////////////////////////////////////// //
				// // API VERSION 2                        // //
				// // Changes to this code require the API // //
				// // version to be incremented            // //
				// ////////////////////////////////////////// //
				if (s.equals("HOST_INFO")) {
					// Collect info about the host
					// and send as string back to server
					try {
						Properties p = java.lang.System.getProperties();
						String temp = 	"java.version       = " + p.getProperty("java.version")+"\n"+
								"java.vendor        = " + p.getProperty("java.vendor")+"\n"+
								"java.home          = " + p.getProperty("java.home")+"\n"+
								"java.class.version = " + p.getProperty("java.class.version")+"\n"+
								"os.name            = " + p.getProperty("os.name")+"\n"+
								"os.arch            = " + p.getProperty("os.arch")+"\n"+
								"os.version         = " + p.getProperty("os.version")+"\n"+
								"user.name          = " + p.getProperty("user.name")+"\n"+
								"user.home          = " + p.getProperty("user.home")+"\n"+
								"user.dir           = " + p.getProperty("user.dir");
						// First send length
						clnt.outStatus.writeUTF( String.valueOf((int)temp.length()) );
						clnt.outStatus.flush();
						// Send the entire file byte by byte
						clnt.outStatus.write(temp.getBytes(),0,(int)temp.length());
					} catch (IOException x) {
					}
				} else {
					// Send status to server
					try {
						clnt.outStatus.writeUTF( clnt.getStatus() );
					} catch (IOException x) {
					}
				}
				// ////////////////////////////////////////// //

			}
		} catch (IOException e) {
			clnt.logEvent("STATUS - " + e.getMessage() );
		} finally {
			listening = false;
			try {
				if (inStream != null) { inStream.close(); }
			} catch (IOException x) {
			}
		}
	}	
}

// IP CLASS ////////////// COMPLETE ///////////////////////////////////////////
class ClientIpRec extends Thread {
	private Client clnt;
	private DataInputStream inStream;
	public boolean listening = false;
	FileOutputStream out;
	PrintStream p;

	public ClientIpRec(Client clnt) {
		this.clnt = clnt;
	}

	public synchronized void run() {
		clnt.logEvent("IP checkin.");
		listening = true;
		String s = null;
		try {
			inStream = new DataInputStream(clnt.ipSocket.getInputStream());
			while (listening) {

				// ////////////////////////////////////////// //
				// // API VERSION 2                        // //
				// // Changes to this code require the API // //
				// // version to be incremented            // //
				// ////////////////////////////////////////// //
				// Read status from server
				s = inStream.readUTF();
				// ////////////////////////////////////////// //

				clnt.logEvent("IP - new ip address, " + s);
				clnt.updateSrvIp(s);
			}
		} catch (IOException e) {
				clnt.logEvent("IP - " + e.getMessage());
		} finally {
			listening = false;
			try {
				if (inStream != null) { inStream.close(); }
			} catch (IOException x) {
			}
		}
	}
}

// DATA CLASS //////////// COMPLETE ///////////////////////////////////////////
class ClientDataRecSnd extends Thread {
	private Client clnt;
	private DataInputStream inStream;
	public boolean listening = false;
	FileOutputStream out;
	DataOutputStream p;

   	public ClientDataRecSnd(Client clnt) {
		this.clnt = clnt;
	}

	public synchronized void run() {
		clnt.logEvent("DATA checkin.");
		listening = true;
		String s = null;
		String fileName = null;
		byte b[] = null;
		int length = 0;

		try {
			inStream = new DataInputStream(clnt.dataSocket.getInputStream());

			while (listening) {
				// Download file from server
				// Read byte array length from client
                                s = null;
                                fileName = null;

				// ////////////////////////////////////////// //
				// // API VERSION 2                        // //
				// // Changes to this code require the API // //
				// // version to be incremented            // //
				// ////////////////////////////////////////// //
                                fileName = inStream.readUTF();	// fileName 
				// ////////////////////////////////////////// //

                                if (fileName != null) {
                                        try {
						// ////////////////////////////////////////// //
						// // API VERSION 2                        // //
						// // Changes to this code require the API // //
						// // version to be incremented            // //
						// ////////////////////////////////////////// //
                                		s = inStream.readUTF();	// Length of file 
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
                                                                inStream.readFully(b,0,length);
								// ////////////////////////////////////////////// //

                                                        } catch(IOException e) {
                                                        }
                                                }
                                        } catch (NumberFormatException x) {
                                                length = 0;
                                        }
                                }

				// In an effort to eliviate the synchronization problem between this
				//   thread and the process thread
				this.setPriority(Thread.NORM_PRIORITY);

				// SAVE DATA FILE
				clnt.updateStatus("RECEIVING");
				// Write to file
				try {
					out = new FileOutputStream( clnt.DATA_IN_FILE );
					p = new DataOutputStream( out );
					p.write(b,0,length);
					p.close();
					clnt.logEvent("Data saved to file...");
				} catch (Exception e) {
					clnt.updateStatus("ERROR_DATA_DL");
					clnt.logEvent("Error writing to data file: " + e.getMessage());
				}

				this.setPriority(Thread.MIN_PRIORITY);

				// Store the fileName (to be used when sent to
				//  server)
				clnt.updateDataFileName(fileName);
			} // end of while

		} catch (IOException e) {
			clnt.logEvent("DATA - " + e.getMessage());
		} finally {
			listening = false;
			try {
				if (inStream != null) { inStream.close(); }
			} catch (IOException x) {
			}
		}
	} //end of run
}	// end of Data Class

// PROCESS CLASS //////// COMPLETE ////////////////////////////////////////////
class ClientProcessRec extends Thread {
	private Client clnt;
	private DataInputStream inStream;
	private DataOutputStream p;
	public boolean listening = false;
	private FileOutputStream out;

	public ClientProcessRec(Client clnt) {
		this.clnt = clnt;
	}

	public synchronized void run() {
		clnt.logEvent("PROCESS checkin.");
		listening = true;
		String s = null;
		String fileName = null;
		int numFiles = 0;
		byte[] b = null;
		int length=0;

		try {
			inStream = new DataInputStream(clnt.processSocket.getInputStream());

			while (listening) {
				s = null;

				// ////////////////////////////////////////// //
				// // API VERSION 2                        // //
				// // Changes to this code require the API // //
				// // version to be incremented            // //
				// ////////////////////////////////////////// //
				// Read process Description 
				s = inStream.readUTF();
				// ////////////////////////////////////////// //
				
				// STOP PROCESSING THREAD IF STARTED
				if (clnt.processThread != null && clnt.processThread.isAlive()) {	
					clnt.stopProcess();
					clnt.logEvent("Processing ... stopped");
				}

				// Save the process Description
				clnt.updateProcess(s);

				clnt.logEvent("PROCESS - new process '" + s + "' received");
			
				// Download the new process from the server 
				// Read byte array length from client
                                s = null;
                                fileName = null;

				// ////////////////////////////////////////// //
				// // API VERSION 2                        // //
				// // Changes to this code require the API // //
				// // version to be incremented            // //
				// ////////////////////////////////////////// //
                                s = inStream.readUTF();		// Number of files being send from server
				// ////////////////////////////////////////// //

				try {
					numFiles = Integer.parseInt(s);

					// Create the array to hold the current process Class Names
					clnt.classNames = new String[numFiles];
				} catch (NumberFormatException x) {
					clnt.logEvent("The number of file is none numeric.");
					numFiles = 0;
				}

				// Repeat this set of calls for each file
				for(int i=0; i<numFiles; i++) {
					// ////////////////////////////////////////// //
					// // API VERSION 2                        // //
					// // Changes to this code require the API // //
					// // version to be incremented            // //
					// ////////////////////////////////////////// //
	                                fileName = inStream.readUTF();	// filename
					s = inStream.readUTF(); 	// size of file
					// ////////////////////////////////////////// //
					try {
						length = Integer.parseInt(s);

						// Save class name (only the class name part)
						clnt.classNames[i] = fileName.substring(0,fileName.indexOf("."));

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
                                                                inStream.readFully(b,0,length);
								// ////////////////////////////////////////////// //

							} catch(IOException e) {
							}
							// Save this file to 
							//  disk

							// Write to file
							try {
								out = new FileOutputStream( fileName );
								p = new DataOutputStream( out );
								p.write(b,0,length);
								p.close();
								clnt.logEvent("Process (" + fileName + ") saved to file...");
							} catch (Exception e) {
								clnt.logEvent("Error writing (" + fileName + "): " + e.getMessage());
							}

                                                } else {
							clnt.logEvent("Error receiving (" + fileName + ") zero byte[]");
						}
                                        } catch (NumberFormatException x) {
						clnt.logEvent("(" + fileName + ") has non numeric file size.");
						clnt.classNames[i] = null;
                                                length = 0;
                                        }
                                }

				// Stall for 10000 milliseconds == 10 seconds
				// This will resolve the sychronization 
				//  problem between the data
				//  thread and the process thread
				try {
					Thread dumby = new Thread();
					dumby.setPriority(dumby.MIN_PRIORITY);
					dumby.start();
					dumby.sleep(10000);
				} catch (InterruptedException e) {
				}

				// Save the classNames to the persistent ini file
				clnt.updateClassNames();
                   
				//Check if data file exists
				File f = new File( clnt.DATA_IN_FILE );
				if (f.exists()) {
					clnt.logEvent("Processing ... started (again)");
					clnt.startProcess(clnt);
				} else {
					// Data file does not exist
					clnt.updateStatus("RECIEVING");
					// Send status to server
					try {
						clnt.outData.writeUTF( clnt.getStatus() );
					} catch (IOException x) {
					}
				}
			} // end of while
		} catch (IOException e) {
			clnt.logEvent("PROCESS - " + e.getMessage());
		} finally {
			listening = false;
			try {
				if (inStream != null) { inStream.close(); }
			} catch (IOException x) {
			}
		}
	} // end of run

}	// End of process


// // This class extend a canvas, this will allow for a more interesting user interface //
class UserInterface extends Canvas {
	private Image image;		// The back ground image
	private int wd, hi;		// The images size
	private String UI_INI = "userinterface.ini";
	private boolean firstTime=true;
	// Status strings
	private String processName = " -- process description -- ";
	private String status = " -- client Status -- ";
	private String ipaddress = " -- server ip -- ";
	private String blocksComp = "00000";
	private int    percentComp = 0;
	private String timeStamp = "";
	// Internal dimensions
	private int O_BORDER = 15;		// Outer border
	private int I_BORDER = 8;		// Inner border
	private int D_HEIGHT = 30;		// Data height
	private int WIDTH  = 175;		// Data and Header width
	private int H_HEIGHT = 20;		// Header height
	private int PER_WIDTH = 40;		// Percentage Completed WIDTH
	// Off screen image and graphics
	Image OSI;
	Graphics OSG;
	// User modifiable parameters
	private String backgroundImage;
	private Color headerMatColor;		// The color under the header fields
	private Color dataMatColor;		// The color under the data fields
	private Color headerTextColor;		// The color of the headers
	private Color dataTextColor;		// The color of the data
	private Color dataRimColor;		// The color around the data fields
	private Color percentBarColor;		// The color of the percentage bar
	private String headerFont;
	private int    headerFontSize=12;
	private String dataFont;
	private int    dataFontSize=10;

	public UserInterface(int wd, int hi) {
		String temp = null;
		FileInputStream fstream;
		BufferedReader d;

		// Read in ini file
		try {

			fstream = new FileInputStream( UI_INI );
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
			// Put all variables as default
			backgroundImage="background.bmp";
			headerMatColor = Color.black;
			dataMatColor =  Color.black;
			headerTextColor = Color.white;
			dataTextColor = Color.white;
			dataRimColor = Color.red;
			percentBarColor = Color.red;
			headerFont="Serif";
			headerFontSize=12;
			dataFont="Serif";
			dataFontSize=10;
		}

		this.image = Toolkit.getDefaultToolkit().getImage( (backgroundImage==null?"background.bmp":backgroundImage) );
		this.wd = wd;
		this.hi = hi;
	}
	
	private void storeVariable(String varName,String value) {
		// trim both sides of the value and varName
		// if value = "" then it is null
		varName = varName.trim();
		value = value.trim();
		if (varName.equals("backgroundImage")) {
			backgroundImage = value;
		} else if (varName.equals("headerMatColor")) {
			headerMatColor = getRGBColor(value);
		} else if (varName.equals("dataMatColor")) {
			dataMatColor = getRGBColor(value);
		} else if (varName.equals("headerTextColor")) {
			headerTextColor = getRGBColor(value);
		} else if (varName.equals("dataTextColor")) {
			dataTextColor = getRGBColor(value);
		} else if (varName.equals("dataRimColor")) {
			dataRimColor = getRGBColor(value);
		} else if (varName.equals("percentBarColor")) {
			percentBarColor = getRGBColor(value);
		} else if (varName.equals("headerFont")) {
			headerFont = value;
		} else if (varName.equals("headerFontSize")) {
			try {
				headerFontSize = Integer.valueOf(value).intValue();
			} catch (NumberFormatException x) {
				headerFontSize = 12;
			}
		} else if (varName.equals("dataFont")) {
			dataFont = value;
		} else if (varName.equals("dataFontSize")) {
			try {
				dataFontSize = Integer.valueOf(value).intValue();
			} catch (NumberFormatException x) {
				dataFontSize = 10;
			}
		}
	}

	public Dimension getPreferredSize() {
		return new Dimension(wd, hi);
	}

	public Dimension getMinimumSize() {
		return new Dimension(wd, hi);
	}

	public void updateStatus(String stat) {
		// Special function to update only the status
		this.status = stat;

		repaint();
	}

	public void updateInterface(String prc,String stat,String ip,String blkComp,int perComp,String time) {
		// input: Process Name, Client status, Server Ip, Blocks Completed, Percent completed, time
		this.processName = prc;
		this.status = stat;
		this.ipaddress = ip;
		this.blocksComp = blkComp;
		this.percentComp = perComp;
		this.timeStamp = time;

		repaint();
	}

	private Color getRGBColor(String rgb) {
		int r=0,g=0,b=0;
		int indR=0,indG=0,indB=0;
		Color c;

		if (rgb != null) {
			rgb = rgb.toLowerCase();

			indR = rgb.indexOf("r");
			indG = rgb.indexOf("g");
			indB = rgb.indexOf("b");

			try {
				r = Integer.valueOf( rgb.substring(indR+1,indG) ).intValue();
				g = Integer.valueOf( rgb.substring(indG+1,indB) ).intValue();
				b = Integer.valueOf( rgb.substring(indB+1) ).intValue();
			} catch (NumberFormatException x) {
				r = 0;
				b = 0;
				g = 255;
			}

			c = new Color(r,g,b);
		} else {	// rgb == null
			c = Color.black;
		}

		return c;
	}

	public void update(Graphics g) {
		// Commit changes
		paint(g);	
	}
 
 	// Redraw image
	public void paint(Graphics g) {
		int yCord = 0;
		int xCord;

		// Only on the initial pass do you want to repaint the background
		if (firstTime) {
			OSI = this.createImage(wd,hi);
			OSG = OSI.getGraphics();

			firstTime = false;
		}

		yCord = 0;
		// Background
		OSG.setClip(0,0,wd,hi);
		super.paint(OSG);
		OSG.clearRect(0,0,wd,hi);
		OSG.drawImage(image, 0, 0, this);

		OSG.setFont( new Font((headerFont==null?"Serif":headerFont),Font.BOLD,headerFontSize) );

		// Labels /////////////////////////////////////////////////////////////////
		xCord = O_BORDER;
		// Client Status
		OSG.setColor(headerMatColor);
		yCord = xCord;
		OSG.fillRect(xCord,yCord,WIDTH,H_HEIGHT);	// under Client Status LABEL
		// Write Label
		OSG.setColor(headerTextColor);
		OSG.drawString("Client Status",xCord+5,yCord+14);

		// Process Description
		OSG.setColor(headerMatColor);
		yCord += D_HEIGHT+O_BORDER + H_HEIGHT+I_BORDER;
		OSG.fillRect(xCord,yCord,WIDTH,H_HEIGHT);	// under Process Desc. LABEL
		// Write Label
		OSG.setColor(headerTextColor);
		OSG.drawString("Process Description",xCord+5,yCord+14);

		// Percent Completed
		OSG.setColor(headerMatColor);
		yCord += D_HEIGHT+O_BORDER + H_HEIGHT+I_BORDER;
		OSG.fillRect(xCord,yCord,WIDTH,H_HEIGHT);	// under Percent Comp. LABEL
		// Write Label
		OSG.setColor(headerTextColor);
		OSG.drawString("Percent Completed",xCord+5,yCord+14);

		xCord = (O_BORDER*2)+WIDTH;
		// Server IP
		OSG.setColor(headerMatColor);
		yCord = O_BORDER;
		OSG.fillRect(xCord,yCord,WIDTH,H_HEIGHT);	// under Server IP LABEL
		// Write Label
		OSG.setColor(headerTextColor);
		OSG.drawString("Server Ip address",xCord+5,yCord+14);

		// Process Time
		OSG.setColor(headerMatColor);
		yCord += D_HEIGHT+O_BORDER + H_HEIGHT+I_BORDER;
		OSG.fillRect(xCord,yCord,WIDTH,H_HEIGHT);	// under Process Time LABEL
		// Write Label
		OSG.setColor(headerTextColor);
		OSG.drawString("Time Spent processing",xCord+5,yCord+14);

		// Blocks Completed		
		OSG.setColor(headerMatColor);
		yCord += D_HEIGHT+O_BORDER + H_HEIGHT+I_BORDER;
		OSG.fillRect(xCord,yCord,WIDTH,H_HEIGHT);	// under Blocks Completed LABEL
		// Write Label
		OSG.setColor(headerTextColor);
		OSG.drawString("Files Completed",xCord+5,yCord+14); 

		// Draw in the redrawable BackGrounds and data
		OSG.setFont( new Font((dataFont==null?"Serif":dataFont),Font.PLAIN,dataFontSize) );

		// Data ///////////////////////////////////////////////////////////////////
		xCord = O_BORDER;
		// Client Status
		OSG.setColor(dataMatColor);
		yCord = xCord+H_HEIGHT+I_BORDER;
		OSG.fillRect(xCord,yCord,WIDTH,D_HEIGHT);	// under Client Status
		OSG.setColor(dataRimColor);
		OSG.drawRoundRect(xCord,yCord,WIDTH,D_HEIGHT,5,5);
		// Write Data
		OSG.setColor(dataTextColor);
		OSG.drawString(status,xCord+5,yCord+20);

		// Process Description
		OSG.setColor(dataMatColor);
		yCord += D_HEIGHT+O_BORDER + H_HEIGHT+I_BORDER;
		OSG.fillRect(xCord,yCord,WIDTH,D_HEIGHT);	// under Process Desc.
		OSG.setColor(dataRimColor);
		OSG.drawRoundRect(xCord,yCord,WIDTH,D_HEIGHT,5,5);
		// Write Data
		OSG.setColor(dataTextColor);
		OSG.drawString(processName,xCord+5,yCord+20);

		// Percent Completed
		OSG.setColor(dataMatColor);
		yCord += D_HEIGHT+O_BORDER + H_HEIGHT+I_BORDER;
		OSG.fillRect(xCord,yCord,PER_WIDTH,D_HEIGHT);					// under Percent Comp. NUMBER
		OSG.setColor(dataRimColor);
		OSG.drawRoundRect(xCord,yCord,PER_WIDTH,D_HEIGHT,5,5);
		// Write Data (Numerical)
		OSG.setColor(dataTextColor);
		OSG.drawString(String.valueOf(percentComp)+"%",xCord+5,yCord+20);
		OSG.setColor(dataMatColor);
		OSG.fillRect(xCord+PER_WIDTH+O_BORDER,yCord,WIDTH-(PER_WIDTH+O_BORDER),D_HEIGHT);	// under Percent Comp. BAR
		// Write Data (Bar)
		OSG.setColor(percentBarColor);
		OSG.draw3DRect(xCord+PER_WIDTH+O_BORDER+5,yCord+5,WIDTH-(PER_WIDTH+O_BORDER)-10,D_HEIGHT-10,false);
		OSG.fillRect(xCord+PER_WIDTH+O_BORDER+5,yCord+5,(int)Math.floor(((double)percentComp/(double)100.0)*(double)(WIDTH-(PER_WIDTH+O_BORDER)-10)),D_HEIGHT-10);

		xCord = (O_BORDER*2)+WIDTH;
		// Server IP
		OSG.setColor(dataMatColor);
		yCord = O_BORDER+H_HEIGHT+I_BORDER;
		OSG.fillRect(xCord,yCord,WIDTH,D_HEIGHT);	// under Server IP
		OSG.setColor(dataRimColor);
		OSG.drawRoundRect(xCord,yCord,WIDTH,D_HEIGHT,5,5);
		// Write Data
		OSG.setColor(dataTextColor);
		OSG.drawString(ipaddress,xCord+5,yCord+20);

		// Process Time
		OSG.setColor(dataMatColor);
		yCord += D_HEIGHT+O_BORDER + H_HEIGHT+I_BORDER;
		OSG.fillRect(xCord,yCord,WIDTH,D_HEIGHT);	// under Process Time
		OSG.setColor(dataRimColor);
		OSG.drawRoundRect(xCord,yCord,WIDTH,D_HEIGHT,5,5);
		// Write Data
		OSG.setColor(dataTextColor);
		OSG.drawString(timeStamp,xCord+5,yCord+20);

		// Blocks Completed		
		OSG.setColor(dataMatColor);
		yCord += D_HEIGHT+O_BORDER + H_HEIGHT+I_BORDER;
		OSG.fillRect(xCord,yCord,WIDTH,D_HEIGHT);	// under Blocks Completed
		OSG.setColor(dataRimColor);
		OSG.drawRoundRect(xCord,yCord,WIDTH,D_HEIGHT,5,5);
		// Write Data
		OSG.setColor(dataTextColor);
		OSG.drawString(blocksComp,xCord+5,yCord+20); 

		g.drawImage(this.OSI,0,0,this);
	}
}

