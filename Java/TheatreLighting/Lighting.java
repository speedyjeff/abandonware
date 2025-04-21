import java.awt.*;
import java.awt.event.*;
import java.applet.*;

public class Lighting extends Applet { 
    
    int count=1;
    static public char kind;
    static public char direction;
    static public char angle;
    static public int cellNum;
    static public int lightX = 330;
    static public int lightY = 360;
    static public char side;
    static public char cycdir;
    static public String gelColor;
    Image OSI;
    Graphics OSG;
	public int x;
	public int y;
	public char clicked = 'n';
	public String gc = " ";;
	public String dri = " ";;
	public String an = " ";
	public String cn = " ";
	public String sd = " ";
	private int Xxcord;
	private int Xycord;

    public void start() {
        count=1;
		printStage();
   		drawLights();
		battonCall();
	}

    public void init() {
    	count = 1;    
		OSI = createImage(430,500);
        OSG = OSI.getGraphics();
		addNotify();
		System.out.println("This was developed by ...");
		System.out.println(" you can reach me at ...");
		System.out.println(" you can visit my website http://...");
		System.out.println("\nThere will NOT be any unlawful use of this Applet");
    }

	public void printStage() {

        //Back ground color
        OSG.setColor(Color.lightGray);
        OSG.fillRect(0,0,430,500);
        //The stage
        OSG.setColor(Color.black);
        OSG.fillRect(30,10,360,310);
        //The Battons
        OSG.setColor(Color.gray);
        OSG.fillRect(5,360,410,5); //FOH
        OSG.fillRect(5,250,410,5); //1st electric
        OSG.fillRect(5,165,410,5); //2nd electric
        OSG.fillRect(5,80,410,5);  //3rd electric
        //The stage directions
        OSG.setColor(Color.white);
        OSG.drawString("'UP' stage",180,25);
        OSG.drawString("'DOWN' stage",175,315);
        OSG.drawString("stage 'RIGHT'",32,160);
        OSG.drawString("stage 'LEFT'",315,160);

    	count = 3;

		repaint();
	}

	public void battonCall() {	
		OSG.setColor(Color.white);	
		OSG.drawString("batton",0,65);
		OSG.drawString("batton",0,150);
		OSG.drawString("batton",0,235);
		OSG.drawString("batton",0,345);

		OSG.setColor(Color.green);
		
		// Upstage batton # 3
		int exes[] = {25,15,5,25};
		int yhws[] = {70,75,70,70};
		OSG.fillPolygon(exes,yhws,4);

		// Center batton # 2
	    int exes2[] = {25,15,5,25};
		int yhws2[] = {155,160,155,155};
		OSG.fillPolygon(exes2,yhws2,4);

		// Downstage batton # 1
		int exes3[] = {25,15,5,25};
		int yhws3[] = {240,245,240,240};
		OSG.fillPolygon(exes3,yhws3,4);

		// FOH batton # 1
		int exes4[] = {25,15,5,25};
		int yhws4[] = {350,355,350,350};
		OSG.fillPolygon(exes4,yhws4,4);
		
		OSG.setColor(Color.white);
	}

	public void drawLeko() {   

		if (Xycord != 367) {
			OSG.setColor(Color.black);
		} else {
			OSG.setColor(Color.lightGray);
		}
		OSG.drawString("X",Xxcord,Xycord);
		gelColor = gc;
		direction = dri.charAt(0);
		if (direction == 'k')
           Lights.leko(lightX,lightY,'k',gelColor,OSG);
        if (direction == 'f') {
			angle = an.charAt(0);
            Lights.leko(lightX,lightY,angle,gelColor,OSG);
		}
        repaint(); 
	    kind = 'q';
        gelColor = "NONE";
	}

	public void drawFernel() {
		if (Xycord != 367) {
			OSG.setColor(Color.black);
		} else {
			OSG.setColor(Color.lightGray);
		}
		OSG.drawString("X",Xxcord,Xycord);
		gelColor = gc;
		direction = dri.charAt(0);    
		if (direction == 's') {
			side = sd.charAt(0);	
            Lights.fernel(lightX,lightY,side,gelColor,OSG);
		}
        else Lights.fernel(lightX,lightY,direction,gelColor,OSG);
        repaint();
        kind = 'q';
        gelColor = "NONE";
	}

	public void drawScoop() {
		if (Xycord != 367) {
			OSG.setColor(Color.black);
		} else {
			OSG.setColor(Color.lightGray);
		}
		OSG.drawString("X",Xxcord,Xycord);
    	gelColor = gc;    
		Lights.scoop(lightX,lightY,gelColor,OSG);
        repaint();
        kind = 'q';
        gelColor = "NONE";
    }

	public void drawCyc() {
		if (Xycord != 367) {
			OSG.setColor(Color.black);
		} else {
			OSG.setColor(Color.lightGray);
		}
		OSG.drawString("X",Xxcord,Xycord);
		gelColor = gc;
		cycdir = dri.charAt(0);
		cellNum = Integer.parseInt(cn);
        Lights.cyc(lightX,lightY,cellNum,cycdir,gelColor,OSG);
        repaint();
        kind = 'q';
        gelColor = "NONE";
    }

	public void drawLights() {
		
		gelColor = "DIRECTIONAL";

        Lights.leko(330,360,'r',gelColor,OSG);
        Lights.leko(200,360,'k',gelColor,OSG);
        Lights.leko(70,360,'l',gelColor,OSG);
        Lights.scoop(250,165,gelColor,OSG);
        Lights.fernel(150,250,'k',gelColor,OSG);
        Lights.fernel(200,250,'d',gelColor,OSG);
        Lights.fernel(250,250,'b',gelColor,OSG);
        Lights.fernel(350,250,'r',gelColor,OSG);
        Lights.fernel(50,250,'l',gelColor,OSG);
        Lights.cyc(50,80,1,'u',gelColor,OSG);
        Lights.cyc(100,80,2,'d',gelColor,OSG);
        Lights.cyc(180,80,3,'u',gelColor,OSG);
        Lights.cyc(280,80,4,'d',gelColor,OSG);

		repaint();
	}  // of drawLight()

    public void paint(Graphics g) {
		g.drawImage(OSI,0,0,this);
    }
    
    public void update(Graphics g) {
        paint(g);
    }

	public boolean handleEvent(Event e) {
		x = e.x;
		y = e.y;
       
      if (e.id == Event.MOUSE_DOWN) {    
		if ((y > 75)&&(y < 85)&&(count%2!=0)) {
			if (Xycord != 367) {
				OSG.setColor(Color.black);
			} else {
				OSG.setColor(Color.lightGray);
			}
			OSG.drawString("X",Xxcord,Xycord);
			OSG.setColor(Color.white);
			Xxcord = x;
			Xycord = 87;
			OSG.drawString("X",Xxcord,Xycord);	
			clicked = 'y';    
			lightX = x;
            lightY = 80;
        }
        if ((y > 160)&&(y < 170)&&(count%2!=0)) {
			if (Xycord != 367) {
				OSG.setColor(Color.black);
			} else {
				OSG.setColor(Color.lightGray);
			}
			OSG.drawString("X",Xxcord,Xycord);
			OSG.setColor(Color.white);
			Xxcord = x;
			Xycord = 172;
			OSG.drawString("X",Xxcord,Xycord);	
        	clicked = 'y';    
            lightX = x;
            lightY = 165;
        }
        if ((y > 245)&&(y < 255)&&(count%2!=0)) {
			if (Xycord != 367) {
				OSG.setColor(Color.black);
			} else {
				OSG.setColor(Color.lightGray);
			}
			OSG.drawString("X",Xxcord,Xycord);
			OSG.setColor(Color.white);
			Xxcord = x;
			Xycord = 257;
			OSG.drawString("X",Xxcord,Xycord);	
        	clicked = 'y';    
            lightX = x;
            lightY = 250;
        }
        if ((y > 355)&&(y < 365)&&(count%2!=0)) {
			if (Xycord != 367) {
				OSG.setColor(Color.black);
			} else {
				OSG.setColor(Color.lightGray);
			}
			OSG.drawString("X",Xxcord,Xycord);
			OSG.setColor(Color.white);
			Xxcord = x;
			Xycord = 367;
			OSG.drawString("X",Xxcord,Xycord);	
        	clicked = 'y';    
            lightX = x;
            lightY = 360;
        }
       } 
	   repaint();
		count++;
 		return(true);   
	}
    
       
    public void stop() {
        count=1;
    }
    
}
