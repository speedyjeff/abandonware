import java.io.*;
import java.net.*;
import java.awt.*;

/**
 * SingleChat -- A chat program between a server and one client.
 *
 * To run as a server, do not supply any command line arguments.
 * SingleChat will start listening on the default port, waiting
 * for a connection:
 *   java SingleChat
 *
 * To run as a client, name the server as the first command line 
 * argument:
 *   java SingleChat bluehorse.com
 * or
 *   java SingleChat local          // to run locally
 */

public class SingleChat extends Panel {
    Socket    sock;          
    TextArea  receivedText;

    private GridBagConstraints c;
    private GridBagLayout      gridBag;
    private Frame              frame;
    private Label              label;
    private int                port = 5001;    // The default port.
    private TextField          sendText;
    private DataOutputStream   remoteOut;


    public static void main(String args[]) {
       ExitFrame f = new ExitFrame("Waiting for connection...");

       String s = null;
       if (args.length > 0)
          s = args[0];

       SingleChat chat = new SingleChat(f);
       f.add("Center", chat);
       f.resize(350, 200);
       f.show();

        // Make the connection happen.
        if (s == null)
           chat.server();
        else
           chat.client(s);        

    }
   
    public SingleChat(Frame f) {     
        frame = f;

        // Build the user interface.
        Insets insets = new Insets(10, 20, 5, 10); // bot, lf, rt, top
        gridBag = new GridBagLayout();
        setLayout(gridBag);

        c = new GridBagConstraints();

        c.insets = insets;
        c.gridy = 0;
        c.gridx = 0;

        label = new Label("Text to send:");
        gridBag.setConstraints(label, c);
        add(label);

        c.gridx = 1;

        sendText = new TextField(20);
        gridBag.setConstraints(sendText, c);
        add(sendText);

        c.gridy = 1;
        c.gridx = 0;

        label = new Label("Text received:");
        gridBag.setConstraints(label, c);
        add(label);

        c.gridx = 1;

        receivedText = new TextArea(3, 20); 
        gridBag.setConstraints(receivedText, c);
        add(receivedText);
    
    }

    // As a server, we create a server socket bound to the specified
    // port, wait for a connection, and then spawn a thread to 
    // read data coming in over the network via the socket.

    private void server() {
        ServerSocket serverSock = null;
        try {
            InetAddress serverAddr = InetAddress.getByName(null);

            displayMsg("Waiting for connection on " +
                      serverAddr.getHostName() +
                      " on port " + port);

            // We'll only accept one connection for this server.
            serverSock = new ServerSocket(port, 1);
            sock = serverSock.accept();

            displayMsg("Accepted connection from " +
                      sock.getInetAddress().getHostName());

            remoteOut = new DataOutputStream(sock.getOutputStream());
            new SingleChatReceive(this).start();

        } catch (IOException e) {
            displayMsg(e.getMessage() +
               ": Failed to connect to client.");

        } finally {
            // At this point, since we only establish one connection
            // per run, we don't need the ServerSocket anymore.
            if (serverSock != null) {
               try {
                  serverSock.close();
               } catch (IOException x) {
               }
            }
        }
    }

    // As a client, we create a socket bound to the specified port,
    // connect to the specified host, and then spawn a thread to 
    // read data coming coming in over the network via the socket.

    private void client(String serverName) {
        try {
            if (serverName.equals("local"))
               serverName = null;

            InetAddress serverAddr = InetAddress.getByName(serverName);
            sock = new Socket(serverAddr.getHostName(), port, true);           
            remoteOut = new DataOutputStream(sock.getOutputStream());

            displayMsg("Connected to server " +
                      serverAddr.getHostName() +
                      " on port " + sock.getPort());

            new SingleChatReceive(this).start();

        } catch (IOException e) {
            displayMsg(e.getMessage() +
               ": Failed to connect to server.");
        }
    }

    // Send data out to the socket we're communicating with when
    // the user hits enter in the text field.
    public boolean action(Event e, Object what) {

        if (e.target == sendText) {
 
           try {

               // Send it.      
              remoteOut.writeUTF(sendText.getText());

               // Clear it.
               sendText.setText("");
           
           } catch (IOException x) {
               displayMsg(x.getMessage() +
                  ": Connection to peer lost.");
           }

        }

        return super.action(e, what);
    }

    void displayMsg(String s) {
       frame.setTitle(s);
    }

    protected void finalize() throws Throwable {
        try {
           if (remoteOut != null)
              remoteOut.close();
           if (sock != null)
              sock.close();
        } catch (IOException x) {
        }
        super.finalize();
    }

}

/** So that we can exit when the user closes the frame. */
class ExitFrame extends Frame {
   ExitFrame(String s) {
      super(s);
   }

   public boolean handleEvent(Event e) {
       if (e.id == Event.WINDOW_DESTROY) {
            hide();
            dispose();
            System.exit(0);
       }
       return super.handleEvent(e);
   }
}

/*
 * SingleChatReceive takes data sent on a socket and displays it in
 * a text area. This receives it from the network.
 */
class SingleChatReceive extends Thread {
    private SingleChat chat;
    private DataInputStream remoteIn;
    private boolean listening = true;

    public SingleChatReceive(SingleChat chat) {
        this.chat = chat;
    }

    public synchronized void run() {
        String s;
        try {
            remoteIn = new DataInputStream(chat.sock.getInputStream());

            while (listening) {
                s = remoteIn.readUTF();   
                chat.receivedText.setText(s);    
            }

        } catch (IOException e) {
            chat.displayMsg(e.getMessage() +
               ": Connection to peer lost.");

        } finally {
           try {
              if (remoteIn != null) 
                 remoteIn.close();
           } catch (IOException x) {
           }
        }
    }
}
