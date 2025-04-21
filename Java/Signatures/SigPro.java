import java.awt.*;
import java.awt.event.*;
import java.applet.Applet;

public class SigPro extends Applet {

	private int x;
	private int y;
	private int oldx, oldy;
	private int counter = 0;
	private boolean visual = false;
	private int borderr,borderg,borderb;
	private int forer,foreg,foreb;
	private Color cl,foreColor;
	private String fade;
	private int borderThickness, fadeBy;
	private String xst = "";
	private String yst = "";
	private int count = 0;
	private int pickUp = 0;
	private int horChange = 0;
	private int vertChange = 0;
	private int left = 590, right = 0;
	private int top = 0, bottom = 150;

	public int pickUpf() {
		return pickUp;
	}

	public int countf() {
		return count;
	}

	public int horChangef() {
		return horChange;
	}

	public int vertChangef() {
		return vertChange;
	}

	public String xstf() {
		return xst;
	}

	public String ystf() {
		return yst;
	}
	
	public void reset() {
		counter = 0;
		pickUp = 0;
		horChange = 0;
		vertChange = 0;
		left = 590;
		right = 0;
		top = 0;
		bottom = 150;
	}

	public void start() {
		reset();
	}

	public void init() {
		String vis;
		try {	
			vis = getParameter("visual");
			fade = getParameter("fade");
			borderThickness = Integer.parseInt(getParameter("borderthickness"));
			fadeBy = Integer.parseInt(getParameter("fadeby"));
			int backr = Integer.parseInt(getParameter("backr"));
			int backg = Integer.parseInt(getParameter("backg"));
			int backb = Integer.parseInt(getParameter("backb"));
			Color backColor = new Color(backr,backg,backb);	
			setBackground(backColor);
			forer = Integer.parseInt(getParameter("forer"));
			foreg = Integer.parseInt(getParameter("foreg"));
			foreb = Integer.parseInt(getParameter("foreb"));
			borderr = Integer.parseInt(getParameter("borderr"));
			borderg = Integer.parseInt(getParameter("borderg"));
			borderb = Integer.parseInt(getParameter("borderb"));
		} catch (NumberFormatException e) {
			borderr = 0;
			borderg = 255;
			borderb = 0;
			forer = 0;
			foreg = 0;
			foreb = 0;
			vis = "false";
			fade = "none";
			fadeBy = 20;
			borderThickness = 5;
		}  // of try catch
		if (vis == null) 
			vis = "false";
		if (fade == null) 
			fade = "none";
		if (vis.equals("true")) {
			visual = true;
		}

		foreColor = new Color(forer,foreg,foreb);	
		// ************************** TIME FOR SOME CREDIT ********************
		System.out.println("\nInternet Signature Securtiy is brought to you by:\n\t...\n\tyou can reach me at either ->\n\t\t...\n\t\t\tor\n\t\t...\n\tor visit my website at:\n\t\t...\npatent pending.\n");
	}
	
	public void paint(Graphics g) {
		int k,r,b,gr;
		r = borderr;
		gr = borderg;
		b = borderb;
		cl = new Color(borderr,borderg,borderb);
		g.setColor(foreColor); 
		g.drawRect(25,25,540,100);
		for(int j=0; j<=borderThickness; j++) {	
			g.setColor(cl);
			g.drawRect(j,j,590-(j*2),150-(j*2));
			if (fade != "none") {
				try {	
					if (fade.equals("down")) {
						r -= fadeBy;
						gr -= fadeBy;
						b -= fadeBy;
					} else {
						r += fadeBy;
						gr += fadeBy;
						b += fadeBy;
					}
					if (r < 0) { r = 0; }
					if (gr < 0) { gr = 0; }
					if (b < 0) { b = 0; }
					cl = new Color(r,gr,b);
				} catch (IllegalArgumentException e) {
					System.out.println("totaly Illegal: r"+r+" g"+gr+" b"+b);
				}
			}
		}
	}

	public int getSigWidth() {
		return(right - left);
	}
	
	public int getSigHeight() {
		return(top - bottom);
	}

	public boolean handleEvent(Event e) {
		Graphics g = getGraphics();	
		if (e.id == Event.MOUSE_DOWN) {
			x = e.x;
			y = e.y;
			oldx = x;
			oldy = y;
			xst += "-1,";
			yst += "-1,";
			xst += x+",";
			yst += y+",";
			count += 2;
			if (visual) {
				g.setColor(Color.red);
				g.fillOval(x-2,y-2,4,4);
			}		
			pickUp++; 
		} else if (e.id == Event.MOUSE_DRAG) {
	if ((counter % 2) == 0) {
			int newx = e.x;
			int newy = e.y;
			g.setColor(foreColor);			
			g.drawLine(x,y,newx,newy);
			if ((oldx != x) && (oldy != y)) {
				directionChange(newx,newy,g);
			}
			if (oldx != x) 	
				oldx = x;
			if (oldy != y)
				oldy = y;
			x=newx;
			y=newy;
			if (y > top) {
				top = y;
			}
			if (y < bottom) {
				bottom = y;
			}
			if (x < left) {
				left = x;
			}
			if (x > right) {
				right = x;
			}
			xst += x+",";
			yst += y+",";
			count++;
	}
	counter++;
		}
		return false;
	}

	public void directionChange(int newx, int newy, Graphics g) {
		if ((oldx < x) && (x > newx) || (oldx > x) && (x < newx)) {
			if (visual) {			
				g.setColor(Color.blue);
				g.drawOval(x-3,y-3,6,6);
			}
			horChange++;
		} 	
		if ((oldy < y) && (y > newy) || (oldy > y) && (y < newy)) {
			if (visual) {
				g.setColor(Color.green);
				g.drawOval(x-2,y-2,4,4);
			}
			vertChange++;
		} 	
	}
		

	public void stop() {
/*		System.out.println("x = "+xst);
		System.out.println("y = "+yst);
		System.out.println("ct= "+count);
		System.out.println("pick up "+pickUp+" times");
		System.out.println("width = "+(right - left));
		System.out.println("height = "+(top - bottom));
		System.out.println("hor changes = "+horChange);
		System.out.println("vert changes = "+vertChange);
		System.out.println("********************************");*/
	}
}
