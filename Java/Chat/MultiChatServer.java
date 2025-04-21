import java.io.*;
import java.net.*;
import java.util.Vector;
import java.util.Enumeration;

/**
 * MultiChatServer -- A chat program between any number of clients.
 *
 * The server acts as the central clearing house of all messages.
 * To run as a server, do not supply any command line arguments.
 * MultiChat will start listening on the default port, waiting
 * for a connection:
 *
 *   java MultiChatServer
 */

public class MultiChatServer {
    private int       port = 5001;    // The default port.
    private boolean   listening = true;
    private Vector    clients = new Vector();

    public static void main(String args[]) {
       System.out.println("Hit control-c to exit the server.");
       new MultiChatServer().server();
    }
   
    // As a server, we create a server socket bound to the specified
    // port, wait for a connection, and then spawn a thread to 
    // read data coming in over the network via the socket.
    
    private void server() {
        ServerSocket serverSock = null; 

        try {
            InetAddress serverAddr = InetAddress.getByName(null);
            
            System.out.println("Waiting for first connection on " +
                      serverAddr.getHostName() +
                      " on port " + port);

            // Accept up to 50 connection at a time. 
            // (This limit is just for the sake of performance.)
            serverSock = new ServerSocket(port, 50);

        } catch (IOException e) {
            System.out.println(e.getMessage() +
               ": Failed to create server socket.");
            return;
        }

        while (listening) {

           try {
               Socket socket = serverSock.accept();
               System.out.println("Accepted connection from " +
                   socket.getInetAddress().getHostName());
               DataOutputStream remoteOut =
                   new DataOutputStream(socket.getOutputStream());
               clients.addElement(remoteOut);
               new ServerHelper(socket, remoteOut, this).start();
 
           } catch (IOException e) {
               System.out.println(e.getMessage() +
                  ": Failed to connect to client.");
           } 
        }

        if (serverSock != null) {
           try {
               serverSock.close();
           } catch (IOException x) {
           }
        }
    }

    synchronized Vector getClients() {
       return clients;
    }

    synchronized void removeFromClients(DataOutputStream remoteOut) {
       clients.removeElement(remoteOut);
    }
       
}

/*
 * ServerHelper handles one client. The server creates one new
 * ServerHelper thread for each client that connects to it.
 */
class ServerHelper extends Thread {
    private Socket sock;
    private DataOutputStream remoteOut;
    private MultiChatServer server;
    private boolean listening = true;
    private DataInputStream remoteIn;

    ServerHelper(Socket sock, DataOutputStream remoteOut,
       MultiChatServer server) throws IOException
    {
        this.sock = sock;
        this.remoteOut = remoteOut;
        this.server = server;
        remoteIn = new DataInputStream(sock.getInputStream());
    }

    public synchronized void run() {
        String s;

        try {
            while (listening) {
                s = remoteIn.readUTF();
                broadcast(s);
            }

        } catch (IOException e) {
            System.out.println(e.getMessage() +
               ": Connection to peer lost.");

        } finally {
            try {
               cleanUp();
            } catch (IOException x) {
            }
        }
    }

    // Send the message to all the sockets connected to the server.
    private void broadcast(String s) {
       Vector clients = server.getClients();
       DataOutputStream dataOut = null;

       for (Enumeration e = clients.elements(); e.hasMoreElements(); ) {
          dataOut = (DataOutputStream)(e.nextElement());

          if (!dataOut.equals(remoteOut)) {

             try {

                dataOut.writeUTF(s);

             } catch (IOException x) {
                System.out.println(x.getMessage() +
                   ": Failed to broadcast to client.");
                server.removeFromClients(dataOut);
             }             
          }
       }
    }

    private void cleanUp() throws IOException {
       if (remoteOut != null) {
          server.removeFromClients(remoteOut);
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

    protected void finalize() throws Throwable {
       try {
          cleanUp();
       } catch (IOException x) {
       }

       super.finalize();
    }

}
