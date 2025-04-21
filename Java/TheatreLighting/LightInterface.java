/*
    This simple extension of the java.awt.Frame class
    contains all the elements necessary to act as the
    main window of an application.
 */

import java.awt.*;

public class LightInterface extends Frame {
    
    char kd;    //local variable for kind
    char dir;   //local variable for direction
    char an;    //local variable for angle
    char sd;    //local variable for side
    char cd;    //local variable for cycDir
	
	
	void About_Action(Event event) {
		//{{CONNECTION
		// Action from About Create and show as modal
		(new AboutDialog(this, true)).show();
		//}}
	}

	public LightInterface() {

		//{{INIT_CONTROLS
		setLayout(null);
		addNotify();
		resize(insets().left + insets().right + 485,insets().top + insets().bottom + 287);
	//	LightTypePanel = new symantec.itools.awt.BorderPanel();
		LightTypePanel.setLayout(null);
		LightTypePanel.reshape(insets().left + 0,insets().top + 24,96,132);
		add(LightTypePanel);
		LightTypePanel.setLabel("Light Type");
		LightType = new CheckboxGroup();
		FernelSw = new java.awt.Checkbox("Fernel", LightType, false);
		FernelSw.reshape(0,0,60,21);
		LightTypePanel.add(FernelSw);
		LekoSw = new java.awt.Checkbox("Leko", LightType, false);
		LekoSw.reshape(0,24,50,21);
		LightTypePanel.add(LekoSw);
		ScoopSw = new java.awt.Checkbox("Scoop", LightType, false);
		ScoopSw.reshape(0,48,60,21);
		LightTypePanel.add(ScoopSw);
		CycSw = new java.awt.Checkbox("Cyc", LightType, false);
		CycSw.reshape(0,72,60,21);
		LightTypePanel.add(CycSw);
		NumCellsText = new java.awt.Label("Number of cells");
		NumCellsText.reshape(insets().left + 360,insets().top + 108,89,20);
		add(NumCellsText);
		GelsNameText = new java.awt.Label("Color of Gel");
		GelsNameText.reshape(insets().left + 360,insets().top + 156,72,20);
		add(GelsNameText);
		GelColorChoice = new java.awt.Choice();
		GelColorChoice.addItem("DIRECTIONAL");
		GelColorChoice.addItem("Green");
		GelColorChoice.addItem("Blue");
		GelColorChoice.addItem("Red");
		GelColorChoice.addItem("Purple");
		GelColorChoice.addItem("Pink");
		GelColorChoice.addItem("Yellow");
		GelColorChoice.addItem("Light Blue");
		GelColorChoice.addItem("Orange");
		add(GelColorChoice);
		GelColorChoice.reshape(insets().left + 360,insets().top + 180,115,21);
		GelColorChoice.setBackground(new Color(16777215));
		OKbutton = new java.awt.Button("OK");
		OKbutton.reshape(insets().left + 108,insets().top + 228,75,31);
		add(OKbutton);
		Cancelbutton = new java.awt.Button("Cancel");
		Cancelbutton.reshape(insets().left + 192,insets().top + 228,75,31);
		add(Cancelbutton);
		Helpbutton = new java.awt.Button("Help");
		Helpbutton.reshape(insets().left + 276,insets().top + 228,75,31);
		add(Helpbutton);
		NumCellsChoice = new java.awt.Choice();
		NumCellsChoice.addItem("1");
		NumCellsChoice.addItem("2");
		NumCellsChoice.addItem("3");
		NumCellsChoice.addItem("4");
		add(NumCellsChoice);
		NumCellsChoice.reshape(insets().left + 360,insets().top + 132,48,21);
		NumCellsChoice.setBackground(new Color(16777215));
		NumCellsChoice.disable();
	//	LightDirectionPanel = new symantec.itools.awt.BorderPanel();
		LightDirectionPanel.setLayout(null);
		LightDirectionPanel.reshape(insets().left + 96,insets().top + 24,132,180);
		add(LightDirectionPanel);
		LightDirectionPanel.setLabel("Light Direction");
//		LightDirectionPanel.setAlignStyle(itools.awt.BorderPanel.ALIGN_LEFT);
		LightDirection = new CheckboxGroup();
		FloodSw = new java.awt.Checkbox("Flood ", LightDirection, false);
		FloodSw.reshape(0,0,110,21);
		LightDirectionPanel.add(FloodSw);
		FloodSw.disable();
		DownSw = new java.awt.Checkbox("Down Light", LightDirection, false);
		DownSw.reshape(0,72,95,21);
		LightDirectionPanel.add(DownSw);
		DownSw.disable();
		BackSw = new java.awt.Checkbox("Back Light", LightDirection, false);
		BackSw.reshape(0,96,95,21);
		LightDirectionPanel.add(BackSw);
		BackSw.disable();
		FillSw = new java.awt.Checkbox("Fill Light ", LightDirection, false);
		FillSw.reshape(0,120,108,21);
		LightDirectionPanel.add(FillSw);
		FillSw.disable();
		SideSw = new java.awt.Checkbox("Side Light ", LightDirection, false);
		SideSw.reshape(0,24,95,21);
		LightDirectionPanel.add(SideSw);
		SideSw.disable();
		KeySw = new java.awt.Checkbox("Key Light", LightDirection, false);
		KeySw.reshape(0,48,95,21);
		LightDirectionPanel.add(KeySw);
		KeySw.disable();
	//	LightAnglePanel = new symantec.itools.awt.BorderPanel();
		LightAnglePanel.setLayout(null);
		LightAnglePanel.reshape(insets().left + 228,insets().top + 24,132,84);
		add(LightAnglePanel);
		LightAnglePanel.setLabel("Angle");
	//	LightAnglePanel.setAlignStyle(symantec.itools.awt.BorderPanel.ALIGN_LEFT);
		LightAngle = new CheckboxGroup();
		AngleLeftSw = new java.awt.Checkbox("45 Stage Left", LightAngle, false);
		AngleLeftSw.reshape(0,24,120,21);
		LightAnglePanel.add(AngleLeftSw);
		AngleLeftSw.disable();
		AngleRightSw = new java.awt.Checkbox("45 Stage Right", LightAngle, false);
		AngleRightSw.reshape(0,0,120,21);
		LightAnglePanel.add(AngleRightSw);
		AngleRightSw.disable();
	//	SideLightPanel = new symantec.itools.awt.BorderPanel();
		SideLightPanel.setLayout(null);
		SideLightPanel.reshape(insets().left + 228,insets().top + 108,132,84);
		add(SideLightPanel);
		SideLightPanel.setLabel("SL Direction");
	//	SideLightPanel.setAlignStyle(symantec.itools.awt.BorderPanel.ALIGN_LEFT);
		SLDirection = new CheckboxGroup();
		StageRightSw = new java.awt.Checkbox("Stage Right", SLDirection, false);
		StageRightSw.reshape(0,0,95,21);
		SideLightPanel.add(StageRightSw);
		StageRightSw.disable();
		StageLeftSw = new java.awt.Checkbox("Stage Left", SLDirection, false);
		StageLeftSw.reshape(0,24,95,21);
		SideLightPanel.add(StageLeftSw);
		StageLeftSw.disable();
	//	CycDirectionPanel = new symantec.itools.awt.BorderPanel();
		CycDirectionPanel.setLayout(null);
		CycDirectionPanel.reshape(insets().left + 360,insets().top + 24,120,84);
		add(CycDirectionPanel);
		CycDirectionPanel.setLabel("Cyc Direction");
		CycDirection = new CheckboxGroup();
		CycUPSw = new java.awt.Checkbox("Up Stage", CycDirection, false);
		CycUPSw.reshape(0,0,95,21);
		CycDirectionPanel.add(CycUPSw);
		CycUPSw.disable();
		CycDNSw = new java.awt.Checkbox("Down Stage", CycDirection, false);
		CycDNSw.reshape(0,24,95,21);
		CycDirectionPanel.add(CycDNSw);
		CycDNSw.disable();
		setTitle("Light Type, Direction, and Gel color");
		//}}

		//{{INIT_MENUS
		//}}
	}

	public LightInterface(String title) {
	    this();
	    setTitle(title);
	}

    public synchronized void show() {
    	move(50, 50);
    	super.show();
    }

	public boolean handleEvent(Event event) {
    	if (event.id == Event.WINDOW_DESTROY) {
            hide();         // hide the Frame
            dispose();      // free the system resources
            System.exit(0); // close the application
            return true;
    	}
        if (event.id == Event.ACTION_EVENT && event.target == OKbutton) {
            this.hide();
            Lighting.cellNum = NumCellsChoice.getSelectedIndex()+1;
            Lighting.gelColor = GelColorChoice.getSelectedItem();
            Lighting.cycdir = cd;
            Lighting.side = sd;
            Lighting.angle = an;
            Lighting.direction = dir;
            Lighting.kind = kd;
            return true;
        }
        if (event.id == Event.ACTION_EVENT && event.target == Cancelbutton) {
            this.hide();
            kd = 'q';
            return true;
        }
        if (event.id == Event.ACTION_EVENT && event.target == FernelSw) {
            kd = 'f';
            DisableTheRest();
            //enable the rest
            SideSw.enable();
            KeySw.enable();
            BackSw.enable();
            DownSw.enable();
            return true;
        }
        if (event.id == Event.ACTION_EVENT && event.target == ScoopSw) {
            kd = 's';
            DisableTheRest();
            FloodSw.enable();
            return true;
        }
        if (event.id == Event.ACTION_EVENT && event.target == LekoSw) {
            kd = 'l';
            DisableTheRest();
            KeySw.enable();
            FillSw.enable();
            return true;
        }
        if (event.id == Event.ACTION_EVENT && event.target == CycSw) {
            kd = 'c';
            DisableTheRest();
            FloodSw.enable();
            NumCellsChoice.enable();
            return true;
        }
        if (event.id == Event.ACTION_EVENT && event.target == FloodSw) {
            dir = 'o';   //'o' equals flood
            DisableHalf();
            if (kd == 'c') {
                CycUPSw.enable();
                CycDNSw.enable();
                NumCellsChoice.enable();
            }
            return true;
        }
        if (event.id == Event.ACTION_EVENT && event.target == SideSw) {
            dir = 's';
            DisableHalf();
            StageRightSw.enable();
            StageLeftSw.enable();
            return true;
        }
        if (event.id == Event.ACTION_EVENT && event.target == KeySw) {
            dir = 'k';
            DisableHalf();
            return true;
        }
        if (event.id == Event.ACTION_EVENT && event.target == DownSw) {
            dir = 'd';
            DisableHalf();
            return true;
        }
        if (event.id == Event.ACTION_EVENT && event.target == BackSw) {
            dir = 'b';
            DisableHalf();
            return true;
        }
        if (event.id == Event.ACTION_EVENT && event.target == FillSw) {
            dir = 'f';    //'f' equals fill light
            DisableHalf();
            AngleRightSw.enable();
            AngleLeftSw.enable();
            return true;
        }
        if (event.id == Event.ACTION_EVENT && event.target == AngleRightSw) {
            an = 'r';
            return true;
        }
        if (event.id == Event.ACTION_EVENT && event.target == AngleLeftSw) {
            an = 'l';
            return true;
        }
        if (event.id == Event.ACTION_EVENT && event.target == StageLeftSw) {
            sd = 'l';
            return true;
        }
        if (event.id == Event.ACTION_EVENT && event.target == StageRightSw) {
            sd = 'r';
            return true;
        }
        if (event.id == Event.ACTION_EVENT && event.target == CycUPSw) {
            cd = 'u';
            return true;
        }
        if (event.id == Event.ACTION_EVENT && event.target == CycDNSw) {
            cd = 'd';
            return true;
        }
		return super.handleEvent(event);
	}
	
	void DisableTheRest() {
	     //disable a few
         SideSw.disable();
         KeySw.disable();
         BackSw.disable();
         DownSw.disable();
         FloodSw.disable();
         FillSw.disable();
         AngleRightSw.disable();
         AngleLeftSw.disable();
         StageRightSw.disable();
         StageLeftSw.disable();
         CycUPSw.disable();
         CycDNSw.disable();
         NumCellsChoice.disable();
    }
    
    void DisableHalf() {
        AngleRightSw.disable();
        AngleLeftSw.disable();
        StageRightSw.disable();
        StageLeftSw.disable();
        CycUPSw.disable();
        CycDNSw.disable();
        NumCellsChoice.disable();
    }



	

	static public void main() {
	    (new LightInterface()).show();
	}

	//{{DECLARE_CONTROLS
	//symantec.itools.awt.BorderPanel LightTypePanel;
	java.awt.Checkbox FernelSw;
	CheckboxGroup LightType;
	java.awt.Checkbox LekoSw;
	java.awt.Checkbox ScoopSw;
	java.awt.Checkbox CycSw;
	java.awt.Label NumCellsText;
	java.awt.Label GelsNameText;
	java.awt.Choice GelColorChoice;
	java.awt.Button OKbutton;
	java.awt.Button Cancelbutton;
	java.awt.Button Helpbutton;
	java.awt.Choice NumCellsChoice;
	//symantec.itools.awt.BorderPanel LightDirectionPanel;
	java.awt.Checkbox FloodSw;
	CheckboxGroup LightDirection;
	java.awt.Checkbox DownSw;
	java.awt.Checkbox BackSw;
	java.awt.Checkbox FillSw;
	java.awt.Checkbox SideSw;
	java.awt.Checkbox KeySw;
	//symantec.itools.awt.BorderPanel LightAnglePanel;
	java.awt.Checkbox AngleLeftSw;
	CheckboxGroup LightAngle;
	java.awt.Checkbox AngleRightSw;
	//symantec.itools.awt.BorderPanel SideLightPanel;
	java.awt.Checkbox StageRightSw;
	CheckboxGroup SLDirection;
	java.awt.Checkbox StageLeftSw;
	//symantec.itools.awt.BorderPanel CycDirectionPanel;
	java.awt.Checkbox CycUPSw;
	CheckboxGroup CycDirection;
	java.awt.Checkbox CycDNSw;
	//}}

	//{{DECLARE_MENUS
	//}}
}
