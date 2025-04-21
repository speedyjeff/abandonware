import java.awt.*;
import java.applet.*;

public class SigDecoder extends Applet {

	private int exes[];
	private int whys[];
	private int len;
	private Image OSI;
	private Graphics OSG;
	private int thrown = 0;
	private int borderr,borderg,borderb;
	private int forer,foreg,foreb;
	private Color cl,foreColor;
	private String fade;
	private int borderThickness, fadeBy;

	public void init() {
		OSI = createImage(590,150);
		OSG = OSI.getGraphics();
		int backr = 0, backg = 0, backb = 0;

		try {	
			fade = getParameter("fade");
			borderThickness = Integer.parseInt(getParameter("borderthickness"));
			fadeBy = Integer.parseInt(getParameter("fadeby"));
			backr = Integer.parseInt(getParameter("backr"));
			backg = Integer.parseInt(getParameter("backg"));
			backb = Integer.parseInt(getParameter("backb"));
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
			fade = "none";
			fadeBy = 20;
			borderThickness = 5;
		}  // of try catch
		if (fade == null) 
			fade = "none";

		foreColor = new Color(forer,foreg,foreb);	
		Color backColor = new Color(backr,backg,backb);	
		setBackground(backColor);


		try {	
			String sLen = getParameter("siz");
			len = Integer.parseInt(sLen);
	
			exes = new int[len+1];
			whys = new int[len+1];
	
			String name;
			int temp;
			String sVal;

			for(int i=0; i<(len); i++) {
			
				name = "x"+i;
				sVal = getParameter(name);
				exes[i] = Integer.parseInt(sVal);
			}

			for(int i=0; i<(len); i++) {
	
				name = "y"+i;
				sVal = getParameter(name);
				whys[i] = Integer.parseInt(sVal);
			}

		} catch (NumberFormatException e) {
			System.out.println("Your Browser Can not handle Parameters!");
			OSG.setColor(Color.blue);
			OSG.fillRect(0,0,300,50);
			OSG.setColor(Color.white);
			OSG.drawRect(5,5,160,35);
			OSG.drawString("Your Browser is not capable",10,20);
			OSG.drawString("  of handling Parameters",10,35);
			thrown = 1;
		}
	}

	public void start() {
	}


	public void paint(Graphics g) {
		int k,r,b,gr;
		r = borderr;
		gr = borderg;
		b = borderb;
		cl = new Color(borderr,borderg,borderb);
		if (thrown != 0) { 	
			g.drawImage(OSI,100,100,this);
		} else {
			// make border
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
						if (r > 255) { r = 255; }
						if (gr > 255) { gr = 255; }
						if (b > 255) { b = 255; }
						cl = new Color(r,gr,b);
					} catch (IllegalArgumentException e) {
						System.out.println("totaly Illegal: r"+r+" g"+gr+" b"+b);
					}
				}
			}
			// re-create signature
			g.setColor(foreColor);
			for(int j=0; j<len; j++)
				if ((exes[j+1] != -1) && (j != (len-1)) && (exes[j] != -1))
					g.drawLine(exes[j],whys[j],exes[j+1],whys[j+1]);
		}
	}
}
