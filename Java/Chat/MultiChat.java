import java.io.*;
import java.net.*;
import java.awt.*;

/**
 * MultiChat -- A chat program between any number of clients.
 *
 * To run as a client, supply two parameters:
 *   1. The name of the person to identify this user
 *   2. the name the server:
 *   java MultiChat Spielberg bluehorse.com
 * or
 *   java MultiChat Spielberg local       // to run locally
 */

public class MultiChat extends Panel {
    TextArea  receivedText;
    Socket    sock;           // The communication socket.

    private GridBagConstraints c;
    private GridBagLayout      gridBag;
    private Frame              frame;
    private Label              label;
    private int                port = 5001;  // The default port.
    private TextField          sendText;
    private String             hostname;
    private String             username;
    private DataOutputStream   remoteOut;

    public static void main(String args[]) {
       if (args.length != 2) {
          System.out.println("format is: java MultiChat <username> <hostname>");
          return;
       }
       
       ExitFrame f = new ExitFrame(args[0]);

       MultiChat chat = new MultiChat(f, args[0], args[1]);
       f.add("Center", chat);
       f.resize(350, 200);
       f.show();

       // Make the connection happen.
       chat.client();        

    }
   
    public MultiChat(Frame f, String user, String host) {     
        frame = f;
        username = user;
        hostname = host;

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

    // As a client, we create a socket bound to the specified port,
    // connect to the specified host, and then spawn a thread to 
    // read data coming coming in over the network via the socket.

    private void client() {
        try {
            if (hostname.equals("local"))
               hostname = null;

            InetAddress serverAddr = InetAddress.getByName(hostname);
            sock = new Socket(serverAddr.getHostName(), port, true);           
            remoteOut = new DataOutputStream(sock.getOutputStream());

            System.out.println("Connected to server " +
                      serverAddr.getHostName() +
                      " on port " + sock.getPort());

            new MultiChatReceive(this).start();

        } catch (IOException e) {
            System.out.println(e.getMessage() +
               ": Failed to connect to server.");
        }
    }

    // Send data out to the socket we're communicating with when
    // the user hits enter in the text field.

    public boolean action(Event e, Object what) {

        if (e.target == sendText) {
 
           try {
               // Send it.
               remoteOut.writeUTF(username + ": " + sendText.getText());
 
               // Clear it.
               sendText.setText("");
           
           } catch (IOException x) {
               System.out.println(x.getMessage() +
                  ": Connection to peer lost.");
           }
        }

        return super.action(e, what);
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

/*
 * ExitFrame allows us to exit when the user closes the frame.
 */
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
 * MultiChatReceive takes data sent on a socket and displays it in
 * a text area. This receives it from the network.
 */
class MultiChatReceive extends Thread {
    private MultiChat chat;

    MultiChatReceive(MultiChat chat) {
        this.chat = chat;
    }

    public synchronized void run() {
        String s;
        DataInputStream remoteIn = null;
        try {
            remoteIn = new DataInputStream(chat.sock.getInputStream());

            while (true) {
                s = remoteIn.readUTF();
                chat.receivedText.setText(s);    
            }

        } catch (IOException e) {
            System.out.println(e.getMessage() +
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
