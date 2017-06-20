using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class EdgeAIOView extends Ui.DataField {

    hidden var mValue;
    
    var dura = "---";
	var time = "---";
	var alt = "---";
	var tem = "---";
	var spd = "---";
	var dst = "---";
	var hr = "---";
	var cad = "---";
	var pwr = "---";
	var ascent = "---";
	var effect = "---";
	
	var lb_hr;
	var lb_alt;
	var lb_tem;
	var lb_cad;
	var lb_spd;
	var lb_dst;
	var lb_pwr;
	var lb_time;
	var lb_dura;
	var lb_ascent;
	var lb_effect;
	

    function initialize() {
        DataField.initialize();
                
        lb_hr = Ui.loadResource(Rez.Strings.str_hr);
        lb_alt = Ui.loadResource(Rez.Strings.str_alt);
    	lb_cad = Ui.loadResource(Rez.Strings.str_cad);
    	lb_spd = Ui.loadResource(Rez.Strings.str_spd);
    	lb_dst = Ui.loadResource(Rez.Strings.str_dst);
    	lb_pwr = Ui.loadResource(Rez.Strings.str_pwr);
    	lb_time = Ui.loadResource(Rez.Strings.str_time);
    	lb_dura = Ui.loadResource(Rez.Strings.str_dura);
    	lb_ascent = Ui.loadResource(Rez.Strings.str_ascent);
    	lb_effect = Ui.loadResource(Rez.Strings.str_effect);
    }


    function onLayout(dc) {       
        return true;
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
    	
    	if (info.altitude != null) {
    		alt = info.altitude.format("%d");
    	}
    	
    	if (info has :totalAscent && info.totalAscent != null) {
    		ascent = info.totalAscent.format("%d");
    	}
    	
    	if (info has :trainingEffect && info.trainingEffect != null) {
    		effect = info.trainingEffect.format("%.1f");
    	}
    	
    	if (info has :currentHeartRate){
	    	if (info.currentHeartRate != null) {
	    		hr = info.currentHeartRate+"";
	    	}
    	}
    	
    	if (info.currentCadence !=null) {
    		cad = info.currentCadence+"";
    	}
    	
    	if (info.currentPower !=null) {
    		pwr = info.currentPower+"";
    	}
    	
    	if (info.currentSpeed != null) {
    		spd = (info.currentSpeed * 3.6);
    		if (spd < 10) {
    			spd = spd.format("%.2f");
    		} else {
    			spd = spd.format("%.1f");
    		}
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

	function drawData(dc) {		
		dc.drawText(51, 35, Graphics.FONT_NUMBER_MEDIUM, cad, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		dc.drawText(150, 35, Graphics.FONT_NUMBER_MEDIUM, hr, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		
		dc.drawText(51, 95, Graphics.FONT_NUMBER_MEDIUM, spd, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		dc.drawText(151, 95, Graphics.FONT_NUMBER_MEDIUM, pwr, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		
		dc.drawText(51, 153, Graphics.FONT_NUMBER_MEDIUM, alt, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		dc.drawText(151, 153, Graphics.FONT_NUMBER_MEDIUM, dst, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		
		dc.drawText(51, 212, Graphics.FONT_NUMBER_MEDIUM, effect, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		dc.drawText(151, 212, Graphics.FONT_NUMBER_MEDIUM, ascent, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);		
		
		dc.drawText(51, 256, Graphics.FONT_SYSTEM_SMALL, time, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);		
		dc.drawText(150, 256, Graphics.FONT_SYSTEM_SMALL, dura, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
    
    function drawLabel(dc) {    	
    	dc.drawText(1, 0, Graphics.FONT_XTINY, lb_cad, Graphics.TEXT_JUSTIFY_LEFT);    	
    	dc.drawText(199, 0, Graphics.FONT_XTINY, lb_hr, Graphics.TEXT_JUSTIFY_RIGHT);
    	
    	dc.drawText(1, 61, Graphics.FONT_XTINY, lb_spd, Graphics.TEXT_JUSTIFY_LEFT);
    	dc.drawText(199, 61, Graphics.FONT_XTINY, lb_pwr, Graphics.TEXT_JUSTIFY_RIGHT);
    	
    	dc.drawText(1, 120, Graphics.FONT_XTINY, lb_alt, Graphics.TEXT_JUSTIFY_LEFT);
    	dc.drawText(199, 120, Graphics.FONT_XTINY, lb_dst, Graphics.TEXT_JUSTIFY_RIGHT);
    	
    	dc.drawText(1, 179, Graphics.FONT_XTINY, lb_effect, Graphics.TEXT_JUSTIFY_LEFT);
    	dc.drawText(199, 179, Graphics.FONT_XTINY, lb_ascent, Graphics.TEXT_JUSTIFY_RIGHT);
    	    	
    	dc.drawText(1, 236, Graphics.FONT_XTINY, lb_time, Graphics.TEXT_JUSTIFY_LEFT);
   		dc.drawText(199, 236, Graphics.FONT_XTINY, lb_dura, Graphics.TEXT_JUSTIFY_RIGHT);    	
    }
    
    function drawGrid(dc) {    
    	dc.setPenWidth(2);
    	dc.drawLine(0, 58, 200, 58);
    	dc.drawLine(0, 117, 200, 117);
    	dc.drawLine(0, 176, 200, 176);
    	dc.drawLine(0, 233, 200, 233);
    	dc.drawLine(99, 0, 99, 265);
    }
    
	function onUpdate(dc) {	    
    	dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);    	
    	
		drawData(dc);
		drawGrid(dc);
		drawLabel(dc);		
	}
}