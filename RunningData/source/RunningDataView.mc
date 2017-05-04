using Toybox.WatchUi as Ui;

class RunningDataView extends Ui.DataField {
	var dura = "---";
	var time = "---";
	var spd = "---";
	var dst = "---";
	var hr = "---";
	var cad = "---";
	
	var lb_hr;
	var lb_cad;
	var lb_spd;
	var lb_dst;
	var lb_time;
	var lb_dura;
	
	var do_update = 0;
	
    function initialize()
    {
    	lb_hr = Ui.loadResource(Rez.Strings.str_hr);
    	lb_cad = Ui.loadResource(Rez.Strings.str_cad);
    	lb_spd = Ui.loadResource(Rez.Strings.str_spd);
    	lb_dst = Ui.loadResource(Rez.Strings.str_dst);
    	lb_time = Ui.loadResource(Rez.Strings.str_time);
    	lb_dura = Ui.loadResource(Rez.Strings.str_dura);
    }
    
	function onLayout(dc) {
		// setLayout(Rez.Layouts.MainLayout(dc));
    }

    function onShow() {
    }

    function onHide() {
    }
    
    function drawData(dc) {
		dc.drawText(109, 35, Graphics.FONT_NUMBER_MILD, time, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);		
		dc.drawText(109, 218-35, Graphics.FONT_NUMBER_MILD, dura, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		
		dc.drawText(109 - 47, 80, Graphics.FONT_NUMBER_MEDIUM, hr, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		dc.drawText(109 + 47, 80, Graphics.FONT_NUMBER_MEDIUM, cad, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		
		dc.drawText(109 - 47, 135, Graphics.FONT_NUMBER_MEDIUM, dst, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		dc.drawText(109 + 43, 135, Graphics.FONT_NUMBER_MEDIUM, spd, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
    
    function drawLabel(dc) {    	
    	dc.drawText(109, 0, Graphics.FONT_XTINY, lb_time, Graphics.TEXT_JUSTIFY_CENTER);
    	dc.drawText(109, 199, Graphics.FONT_XTINY, lb_dura, Graphics.TEXT_JUSTIFY_CENTER);
    	
    	dc.drawText(1, 88, Graphics.FONT_XTINY, lb_hr, Graphics.TEXT_JUSTIFY_LEFT);    	
    	dc.drawText(217, 88, Graphics.FONT_XTINY, lb_cad, Graphics.TEXT_JUSTIFY_RIGHT);
    	
    	dc.drawText(1, 113, Graphics.FONT_XTINY, lb_dst, Graphics.TEXT_JUSTIFY_LEFT);    	
    	dc.drawText(217, 113, Graphics.FONT_XTINY, lb_spd, Graphics.TEXT_JUSTIFY_RIGHT);
    }
    
    function drawGrid(dc) {
    	dc.setPenWidth(2);
    	dc.drawLine(0, 54, 218, 54);
    	dc.drawLine(0, 109, 218, 109);
    	dc.drawLine(0, 164, 218, 164);
    	dc.drawLine(109, 54, 109, 164);    	
    }
    
	function onUpdate(dc) {
		//View.onUpdate(dc);
    	dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
		drawData(dc);
		drawGrid(dc);
		drawLabel(dc);
	}
	
	function fmt_time() {
		var now = System.getClockTime();
    	
    	return now.hour + ":" + now.min.format("%02d") + ":" + now.sec.format("%02d");
	}
	
	function fmt_dura(elapsedTime) {
    	if (elapsedTime != null) {
    		var seconds = (elapsedTime/1000);
    		var hour = seconds / 3600;
    		var min = seconds % 3600 / 60;
    		var sec = seconds % 60;
    		return hour + ":" + min.format("%02d") + ":" + sec.format("%02d");
    	} else {    	
    		return ""; 
    	}
    }
	
    function compute(info) {
    	time = fmt_time();
    	dura = fmt_dura(info.elapsedTime);
    	
    	if (info.currentHeartRate != null) {
    		hr = info.currentHeartRate+"";
    	}
    	
    	if (info.currentCadence !=null) {
    		cad = info.currentCadence+"";
    	}
    	
    	if (info.currentSpeed != null && info.currentSpeed > 0.25) {
    		var seconds = (1000/info.currentSpeed).toLong(); // seconds per km
			var min = seconds / 60;
    		var sec = seconds % 60;
    		spd = min.format("%02d") + ":" + sec.format("%02d");
    	}    	   	
    	
    	if (info.elapsedDistance != null) {
    		dst = (info.elapsedDistance / 1000);
    		if (dst < 10) {
    			dst = dst.format("%.2f");
    		} else {
    			dst = dst.format("%.1f");
    		}
    	}
    }

}