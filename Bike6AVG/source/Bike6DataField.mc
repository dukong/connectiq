using Toybox.Graphics;
using Toybox.System;
using Toybox.Time.Gregorian;
using Toybox.WatchUi as Ui;

class Bike6DataField extends Ui.DataField {	
	var hr = "---";
	var cad = "---";
	var spd = "---";
	var dst = "---";
	var dura = "---";
	var time = "---";
	
	var lb_hr;
	var lb_cad;
	var lb_spd;
	var lb_avg_hr;
	var lb_avg_cad;
	var lb_avg_spd;
	
	var lb_dst;
	var lb_time;
	var lb_dura;
	
	var avg_flag = true;
	
    function initialize()
    {
    	lb_hr = Ui.loadResource(Rez.Strings.str_hr);
    	lb_cad = Ui.loadResource(Rez.Strings.str_cad);
    	lb_spd = Ui.loadResource(Rez.Strings.str_spd);
    	
    	lb_avg_hr = Ui.loadResource(Rez.Strings.str_avg_hr);
    	lb_avg_cad = Ui.loadResource(Rez.Strings.str_avg_cad);
    	lb_avg_spd = Ui.loadResource(Rez.Strings.str_avg_spd);
    	
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
		dc.drawText(109 - 47, 135, Graphics.FONT_NUMBER_MEDIUM, dst, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		
		if (avg_flag) {
    		dc.setColor(Graphics.COLOR_DK_RED, Graphics.COLOR_WHITE);
    	}
		dc.drawText(109 - 47, 80, Graphics.FONT_NUMBER_MEDIUM, hr, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		dc.drawText(109 + 47, 80, Graphics.FONT_NUMBER_MEDIUM, cad, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);		
		dc.drawText(109 + 47, 135, Graphics.FONT_NUMBER_MEDIUM, spd, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
    
    function drawLabel(dc) {    	
    	dc.drawText(109, 0, Graphics.FONT_XTINY, lb_time, Graphics.TEXT_JUSTIFY_CENTER);
    	dc.drawText(109, 199, Graphics.FONT_XTINY, lb_dura, Graphics.TEXT_JUSTIFY_CENTER);
    	dc.drawText(1, 113, Graphics.FONT_XTINY, lb_dst, Graphics.TEXT_JUSTIFY_LEFT);
    	
    	if (avg_flag) {
    		dc.setColor(Graphics.COLOR_DK_RED, Graphics.COLOR_WHITE);
    		dc.drawText(1, 88, Graphics.FONT_XTINY, lb_avg_hr, Graphics.TEXT_JUSTIFY_LEFT);    	
    		dc.drawText(217, 88, Graphics.FONT_XTINY, lb_avg_cad, Graphics.TEXT_JUSTIFY_RIGHT);
    		dc.drawText(217, 113, Graphics.FONT_XTINY, lb_avg_spd, Graphics.TEXT_JUSTIFY_RIGHT);
    		dc.drawText(109, 109, Graphics.FONT_XTINY, "AVG", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    	} else {    	
    		dc.drawText(1, 88, Graphics.FONT_XTINY, lb_hr, Graphics.TEXT_JUSTIFY_LEFT);    	
    		dc.drawText(217, 88, Graphics.FONT_XTINY, lb_cad, Graphics.TEXT_JUSTIFY_RIGHT);
    		dc.drawText(217, 113, Graphics.FONT_XTINY, lb_spd, Graphics.TEXT_JUSTIFY_RIGHT);
    	}
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
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
		drawGrid(dc);
		drawLabel(dc);
	}
	
	function fmt_time() {
		var now = System.getClockTime();
    	
    	if (now.sec % 5 == 0) {
    		avg_flag = !avg_flag;
    	}
    	
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
    	dura = fmt_dura(info.timerTime);
    	
    	if (info.elapsedDistance != null) {
    		dst = (info.elapsedDistance / 1000);
    		if (dst < 10) {
    			dst = dst.format("%.2f");
    		} else {
    			dst = dst.format("%.1f");
    		}
    	}
    	
    	if (avg_flag) {
	    	if (info.averageHeartRate != null) {
	    		hr = info.averageHeartRate+"";
	    	}
	    	
	    	if (info.averageCadence != null) {
	    		cad = info.averageCadence+"";
	    	}
	    	
	    	if (info.averageSpeed != null) {
	    		spd = (info.averageSpeed * 3.6);
	    		if (spd < 10) {
	    			spd = spd.format("%.2f");
	    		} else {
	    			spd = spd.format("%.1f");
	    		}
	    	}    	
    	} else {
	    	if (info.currentHeartRate != null) {
	    		hr = info.currentHeartRate+"";
	    	}
	    	
	    	if (info.currentCadence != null) {
    			cad = info.currentCadence+"";
    		}
    		
    		if (info.currentSpeed != null) {
	    		spd = (info.currentSpeed * 3.6);
	    		if (spd < 10) {
	    			spd = spd.format("%.2f");
	    		} else {
	    			spd = spd.format("%.1f");
	    		}
    		}
    	}
    }

}