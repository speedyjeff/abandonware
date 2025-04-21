import java.applet.*;
import java.awt.*;

public class CompareSig extends Applet {

	private final int HORDIFF = 4;
	private final int VERTDIFF = 4;
	private final int HEIGHTDIFF = 15;
	private final int WIDTHDIFF = 30;
	private int horDiff = -999, vertDiff = -999;
	private int hDiff = -999,wDiff = -999;

	public void init() {
		setBackground(Color.black);
	}

	public int getHorDiff() {
		return horDiff;
	}

	public int getVertDiff() {
		return vertDiff;
	}

	public int getHeightDiff() {
		return hDiff;
	}

	public int getWidthDiff() {
		return wDiff;
	}

	public boolean compare(int pc1,int pc2,int w1,int w2,int h1,int h2,int hr1,int hr2,int vr1,int vr2) {

		boolean okay = false;
		boolean stop = false;

		if (pc1 == pc2) {     //Pick Up's most match perfectly
			horDiff = hr1 - hr2;
			if (horDiff < 0) { horDiff *= -1; }
			vertDiff = vr1 - vr2;
			if (vertDiff < 0) { vertDiff *= -1; }
			if ((horDiff <= HORDIFF) && (vertDiff <= VERTDIFF)) { 
				//Horivontal changes and vertical changes may vary
				if ((hr1 == 0) || (hr2 == 0))  //if either is 0 then
					if (hr1 != hr2) 			// both must be	
						stop = true;
				if ((vr1 == 0) || (vr2 == 0))  //if either is 0 then
					if (vr1 != vr2) 			// both must be	
						stop = true;
				if (!stop) {
					hDiff = h1 - h2;
					if (hDiff < 0) hDiff *= -1;
					wDiff = w1 - w2;
					if (wDiff < 0) wDiff *= -1;
					if ((hDiff <= HEIGHTDIFF) && (wDiff <= WIDTHDIFF)) {
						okay = true;
					}
				}
			}
		}
/*		System.out.println("(pc1,pc2) --> ("+pc1+","+pc2+")");
		System.out.println("horChange -->  "+horDiff);
		System.out.println("verChange -->  "+vertDiff);
		System.out.println("height    -->  "+hDiff+" ("+h1+","+h2+")");
		System.out.println("widht     -->  "+wDiff+" ("+w1+","+w2+")");
		System.out.println("************************************");  */
		return okay;
	}  // end of compare()

}
