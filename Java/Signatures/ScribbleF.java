import java.awt.*;
import java.awt.event.*;
//import java.applet.Applet;
import java.io.*;

public class ScribbleF extends Frame {

	private int x;
	private int y;
	public String xst = "";
	public String yst = "";
	public String nst = "";
	public int count = 0;

	public boolean handleEvent(Event e) {
		if (e.id == Event.MOUSE_DOWN) {
			x = e.x;
			y = e.y;
			count += 2;	
			xst += "-1,";
			yst += "-1,";
			xst += x+",";
			yst += y+",";
		} else if (e.id == Event.MOUSE_DRAG) {
			Graphics g = getGraphics();	
			int newx = e.x;
			int newy = e.y;
			g.drawLine(x,y,newx,newy);
			x=newx;
			y=newy;
			count++;	
			xst += x+",";
			yst += y+",";
		} else if (e.id == Event.ACTION_EVENT) {
			dead();
			System.exit(0);
		}
		return false;
	}

	public static void main(String[] args) {

		ScribbleF s = new ScribbleF();
		s.setSize(400,400);
		Panel p = new Panel();
		Button b = new Button("Close");
		p.add(b);
		s.add("North",p);
		s.setVisible(true);
	}

	public void dead() {
		nst = "siz="+count+"&x="+xst+"&y="+yst;
		try {
			FileOutputStream outfile = new FileOutputStream("outfile.txt");
			DataOutputStream dos = new DataOutputStream(outfile);

			dos.writeBytes(nst);
			dos.close();
			outfile.close();
		} catch (IOException e) {
			System.out.println("Didnt work "+e.getMessage());
		}
	}

}
