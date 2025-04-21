import java.awt.*;
import java.applet.*;

public class Lights extends Lighting {
    
    public static void leko(int x,int y,char kind,String gelColor,Graphics g) {
        // 'r' means 45 degrees S. right
        // 'k' means key light
        // 'l' means 45 degrees S. left
        if (kind == 'k') {
            int exes[] = {x,x-6,x-6,x+6,x+6,x};
            int whys[] = {y,y-6,y-35,y-35,y-6,y};
            int pts = exes.length;
            LightThrow.KlekoThrow(x,y,gelColor,g);
            g.setColor(Color.white);
            g.fillPolygon(exes,whys,pts);
        }
        if (kind == 'r') {
            int exes[] = {x,x-8,x-28,x-20,x,x};
            int whys[] = {y,y,y-20,y-28,y-8,y};
            int pts = exes.length;
            LightThrow.RLlekoThrow(x,y,'r',gelColor,g);
            g.setColor(Color.white);
            g.fillPolygon(exes,whys,pts);
        }
        if (kind == 'l') {
            int exes[] = {x,x,x+20,x+28,x+8,x};
            int whys[] = {y,y-8,y-28,y-20,y,y};
            int pts = exes.length;
            LightThrow.RLlekoThrow(x,y,'l',gelColor,g);
            g.setColor(Color.white);
            g.fillPolygon(exes,whys,pts);
        }
    }   // end of leko

    public static void fernel(int x,int y,char kind,String gelColor,Graphics g) {
        // 'l' means sidelight pointing S. left
        // 'r' means sidelight pointing S. right
        // 'b' means backlight
        // 'd' means downlight
        // 'k' means key light
        if (kind == 'k') {
            int exes[] = {x,x-10,x-10,x+10,x+10,x};
            int whys[] = {y,y-5,y-18,y-18,y-5,y};
            int pts = exes.length;
            LightThrow.KBfernelThrow(x,y,'k',gelColor,g);
            g.setColor(Color.white);
            g.fillPolygon(exes,whys,pts);
        }
        if (kind == 'd') {
            int exes[] = {x-10,x+10,x+10,x-10,x-10};
            int whys[] = {y-10,y-10,y+10,y+10,y-10};
            int pts = exes.length;
            LightThrow.DfernelThrow(x,y,gelColor,g);
            g.setColor(Color.white);
            g.fillPolygon(exes,whys,pts);
        }
        if (kind == 'b') {
            int exes[] = {x,x-10,x-10,x+10,x+10,x};
            int whys[] = {y+5,y+10,y+23,y+23,y+10,y+5};
            int pts = exes.length;
            LightThrow.KBfernelThrow(x,y,'b',gelColor,g);
            g.setColor(Color.white);
            g.fillPolygon(exes,whys,pts);
        }
        if (kind == 'l') {
            int exes[] = {x,x+5,x+18,x+18,x+5,x};
            int whys[] = {y+2,y+11,y+11,y-9,y-9,y+2};
            int pts = exes.length;
            LightThrow.RLfernelThrow(x,y,'l',gelColor,g);
            g.setColor(Color.white);
            g.fillPolygon(exes,whys,pts);
        }
        if (kind == 'r') {
            int exes[] = {x,x-5,x-18,x-18,x-5,x};
            int whys[] = {y+2,y+11,y+11,y-9,y-9,y+2};
            int pts = exes.length;
            LightThrow.RLfernelThrow(x,y,'r',gelColor,g);
            g.setColor(Color.white);
            g.fillPolygon(exes,whys,pts);
        }

    }

    public static void scoop(int x,int y,String gelColor,Graphics g) {
        LightThrow.scoopThrow(x,y,gelColor,g);
        g.setColor(Color.white);
        g.fillOval(x-15,y-15,30,30);
    }

    public static void cyc(int x,int y,int cells,char dir,String gelColor,Graphics g) {
        if (dir == 'u') {
            for(int j=0; j<cells; j++){
                int exes[] = {x,x-8,x-12,x+12,x+8,x};
                int whys[] = {y,y,y-10,y-10,y,y};
                int pts = exes.length;
                LightThrow.UcycThrow(x,y,gelColor,g);
                g.setColor(Color.white);
                g.fillPolygon(exes,whys,pts);
                x+=21;
            }
        }
        if (dir == 'd') {
            for(int j=0; j<cells; j++){
                int exes[] = {x,x-8,x-12,x+12,x+8,x};
                int whys[] = {y+5,y+5,y+15,y+15,y+5,y+5};
                int pts = exes.length;
                LightThrow.DcycThrow(x,y,gelColor,g);
                g.setColor(Color.white);
                g.fillPolygon(exes,whys,pts);
                x+=21;
            }
        }
    }
}
