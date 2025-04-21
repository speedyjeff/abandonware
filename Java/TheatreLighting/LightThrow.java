import java.awt.*;
import java.applet.*;

public class LightThrow extends Lights {

    private static void GelColor(String GC,Graphics g) {
        if (GC.equals("Red"))
            g.setColor(Color.red);
        if (GC.equals("Green"))
            g.setColor(Color.green);
        if (GC.equals("Blue"))
            g.setColor(Color.blue);
        if (GC.equals("Purple"))
            g.setColor(Color.magenta);
        if (GC.equals("Pink"))
            g.setColor(Color.pink);
        if (GC.equals("Yellow"))
            g.setColor(Color.yellow);
        if (GC.equals("Light Blue"))
            g.setColor(Color.cyan);
        if (GC.equals("Orange"))
            g.setColor(Color.orange);
    }
    
    public static void KlekoThrow(int x, int y,String GC,Graphics g) {
        if (GC.equals("DIRECTIONAL")) 
            g.setColor(Color.magenta);
        else GelColor(GC,g);
        g.drawLine(x-6,y-35,x-46,y-145);
        g.drawLine(x-5,y-35,x-39,y-147);
        g.drawLine(x-4,y-35,x-31,y-149);
        g.drawLine(x-3,y-35,x-23,y-150);
        g.drawLine(x-2,y-35,x-16,y-151);
        g.drawLine(x-1,y-35,x-8,y-152);
        g.drawLine(x,y-35,x,y-152);
        g.drawLine(x+1,y-35,x+8,y-152);
        g.drawLine(x+2,y-35,x+16,y-151);
        g.drawLine(x+3,y-35,x+23,y-150);
        g.drawLine(x+4,y-35,x+31,y-149);
        g.drawLine(x+5,y-35,x+39,y-147);
        g.drawLine(x+6,y-35,x+46,y-145);
    }

    public static void KBfernelThrow(int x, int y,char kind,String GC,Graphics g) {
        if (GC.equals("DIRECTIONAL")) 
              g.setColor(Color.orange);
        else GelColor(GC,g);
        int pos = 0;
        int dir = 1;
        if (kind == 'k') {
           pos = 0;
           dir = 1;
        }
        if (kind == 'b') {
           pos = 5;
           dir = -1;
        }
        g.drawLine(x-10,y-18*dir+pos,x-70,y-80*dir);
        g.drawLine(x-9,y-18*dir+pos,x-63,y-84*dir);
        g.drawLine(x-8,y-18*dir+pos,x-56,y-87*dir);
        g.drawLine(x-7,y-18*dir+pos,x-49,y-90*dir);
        g.drawLine(x-6,y-18*dir+pos,x-42,y-93*dir);
        g.drawLine(x-5,y-18*dir+pos,x-35,y-95*dir);
        g.drawLine(x-4,y-18*dir+pos,x-28,y-97*dir);
        g.drawLine(x-3,y-18*dir+pos,x-21,y-98*dir);
        g.drawLine(x-2,y-18*dir+pos,x-14,y-99*dir);
        g.drawLine(x-1,y-18*dir+pos,x-7,y-100*dir);
        g.drawLine(x,y-18*dir+pos,x,y-100*dir);
        g.drawLine(x+1,y-18*dir+pos,x+7,y-100*dir);
        g.drawLine(x+2,y-18*dir+pos,x+14,y-99*dir);
        g.drawLine(x+3,y-18*dir+pos,x+21,y-98*dir);
        g.drawLine(x+4,y-18*dir+pos,x+28,y-97*dir);
        g.drawLine(x+5,y-18*dir+pos,x+35,y-95*dir);
        g.drawLine(x+6,y-18*dir+pos,x+42,y-93*dir);
        g.drawLine(x+7,y-18*dir+pos,x+49,y-90*dir);
        g.drawLine(x+8,y-18*dir+pos,x+56,y-87*dir);
        g.drawLine(x+9,y-18*dir+pos,x+63,y-84*dir);
        g.drawLine(x+10,y-18*dir+pos,x+70,y-80*dir);
    }
    
    public static void RLfernelThrow(int x, int y,char kind,String GC,Graphics g) {
        int dir = 1;
        if (GC.equals("DIRECTIONAL")) {
            if (kind == 'r') {
                g.setColor(Color.pink);
            }
            if (kind == 'l') {
                g.setColor(Color.cyan);
                dir = 1;
            }
        }
        else GelColor(GC,g);
        if (kind == 'r') 
            dir = -1;
        g.drawLine(x+18*dir,y-9,x+80*dir,y-70);
        g.drawLine(x+18*dir,y-8,x+84*dir,y-63);
        g.drawLine(x+18*dir,y-7,x+87*dir,y-56);
        g.drawLine(x+18*dir,y-6,x+90*dir,y-49);
        g.drawLine(x+18*dir,y-5,x+93*dir,y-42);
        g.drawLine(x+18*dir,y-4,x+95*dir,y-35);
        g.drawLine(x+18*dir,y-3,x+97*dir,y-28);
        g.drawLine(x+18*dir,y-2,x+98*dir,y-21);
        g.drawLine(x+18*dir,y-1,x+99*dir,y-14);
        g.drawLine(x+18*dir,y,x+100*dir,y-7);
        g.drawLine(x+18*dir,y+1,x+100*dir,y); 
        g.drawLine(x+18*dir,y+2,x+100*dir,y+7); //center
        g.drawLine(x+18*dir,y+3,x+99*dir,y+14);
        g.drawLine(x+18*dir,y+4,x+98*dir,y+21);
        g.drawLine(x+18*dir,y+5,x+97*dir,y+28);
        g.drawLine(x+18*dir,y+6,x+95*dir,y+35);
        g.drawLine(x+18*dir,y+7,x+93*dir,y+42);
        g.drawLine(x+18*dir,y+8,x+90*dir,y+49);
        g.drawLine(x+18*dir,y+9,x+87*dir,y+56);
        g.drawLine(x+18*dir,y+10,x+84*dir,y+63);
        
        
    }

    public static void UcycThrow(int x, int y,String GC,Graphics g) {
        if (GC.equals("DIRECTIONAL")) 
            g.setColor(Color.yellow);
        else GelColor(GC,g);
        g.drawLine(x-12,y-10,x-80,y-50);
        g.drawLine(x-9,y-10,x-60,y-50);
        g.drawLine(x-6,y-10,x-40,y-50);
        g.drawLine(x-3,y-10,x-20,y-50);
        g.drawLine(x,y-10,x,y-50);
        g.drawLine(x+3,y-10,x+20,y-50);
        g.drawLine(x+6,y-10,x+40,y-50);
        g.drawLine(x+9,y-10,x+60,y-50);
        g.drawLine(x+12,y-10,x+80,y-50);
    }
    
    public static void DcycThrow(int x, int y,String GC,Graphics g) {
        if (GC.equals("DIRECTIONAL")) 
            g.setColor(Color.yellow);
        else GelColor(GC,g);
        g.drawLine(x-12,y+15,x-80,y+55);
        g.drawLine(x-9,y+15,x-60,y+55);
        g.drawLine(x-6,y+15,x-40,y+55);
        g.drawLine(x-3,y+15,x-20,y+55);
        g.drawLine(x,y+15,x,y+55);
        g.drawLine(x+3,y+15,x+20,y+55);
        g.drawLine(x+6,y+15,x+40,y+55);
        g.drawLine(x+9,y+15,x+60,y+55);
        g.drawLine(x+12,y+15,x+80,y+55);
    }

    
    public static void scoopThrow(int x,int y,String GC, Graphics g) {
        int xdir = 1,ydir= 1;
        if (GC.equals("DIRECTIONAL")) 
            g.setColor(Color.green);
        else GelColor(GC,g);
        for(int j=0; j<=4; j++) {
            if (j == 2)
                xdir=-1;
            if (j == 3)
                ydir=-1;
            if (j == 4)
                xdir=1;
            g.drawLine(x,y,x+80*xdir,y);
            g.drawLine(x,y,x+79*xdir,y-14*ydir);
            g.drawLine(x,y,x+75*xdir,y-27*ydir);
            g.drawLine(x,y,x+69*xdir,y-40*ydir);
            g.drawLine(x,y,x+61*xdir,y-51*ydir);
            g.drawLine(x,y,x+51*xdir,y-61*ydir);
            g.drawLine(x,y,x+40*xdir,y-69*ydir);
            g.drawLine(x,y,x+27*xdir,y-75*ydir);
            g.drawLine(x,y,x+14*xdir,y-79*ydir);
            g.drawLine(x,y,x,y-80*ydir);
        }
    }
        
    public static void DfernelThrow(int x,int y,String GC, Graphics g) {
        int xdir = 1,ydir= 1;
        if (GC.equals("DIRECTIONAL")) 
            g.setColor(Color.green);
        else GelColor(GC,g);
        for(int j=0; j<=4; j++) {
            if (j == 2)
                xdir=-1;
            if (j == 3)
                ydir=-1;
            if (j == 4)
                xdir=1;
            g.drawLine(x,y,x+60*xdir,y);
            g.drawLine(x,y,x+59*xdir,y-10*ydir);
            g.drawLine(x,y,x+56*xdir,y-20*ydir);
            g.drawLine(x,y,x+52*xdir,y-30*ydir);
            g.drawLine(x,y,x+45*xdir,y-38*ydir);
            g.drawLine(x,y,x+38*xdir,y-46*ydir);
            g.drawLine(x,y,x+30*xdir,y-51*ydir);
            g.drawLine(x,y,x+20*xdir,y-56*ydir);
            g.drawLine(x,y,x+10*xdir,y-59*ydir);
            g.drawLine(x,y,x,y-60*ydir);
        }
    }
    
    public static void RLlekoThrow(int x,int y,char kind,String GC,Graphics g) {
        int dir=1;
        if (GC.equals("DIRECTIONAL")) {
            if (kind == 'l') {
                g.setColor(Color.red);
                dir = -1;
            }
            if (kind == 'r') {
                g.setColor(Color.blue);
                dir = 1;
            }
        }
        else GelColor(GC,g);
        if (kind == 'l')
            dir = -1;
        g.drawLine(x-28*dir,y-20,x-135*dir,y-69);
        g.drawLine(x-27*dir,y-20,x-131*dir,y-76);
        g.drawLine(x-26*dir,y-21,x-127*dir,y-83);
        g.drawLine(x-26*dir,y-22,x-123*dir,y-89);
        g.drawLine(x-25*dir,y-22,x-118*dir,y-96);
        g.drawLine(x-24*dir,y-23,x-113*dir,y-102);
        g.drawLine(x-24*dir,y-24,x-107*dir,y-107);
        g.drawLine(x-23*dir,y-24,x-102*dir,y-113);
        g.drawLine(x-22*dir,y-25,x-96*dir,y-118);
        g.drawLine(x-22*dir,y-26,x-89*dir,y-123);
        g.drawLine(x-21*dir,y-26,x-83*dir,y-127);
        g.drawLine(x-20*dir,y-27,x-76*dir,y-131);
        g.drawLine(x-20*dir,y-28,x-69*dir,y-135);
    }
}
