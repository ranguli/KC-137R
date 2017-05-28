# KC-137R Roll/Pitch Stabilization Augmentation System by Joshua Davidson (it0uchpods)
# V0.9.1

##############################
# Engage/Disengage Functions #
##############################

setprop("/it-fbw/roll-disable", 1);
setprop("/it-fbw/man-roll-btn", 0);
setprop("/it-fbw/pitch-disable", 0);
setprop("/it-fbw/man-pitch-btn", 0);

var roll = func {
	setprop("/it-autoflight/input/ap1", 0);
	setprop("/it-autoflight/input/ap2", 0);
	if (getprop("/it-fbw/man-roll-btn") == 0) {
		setprop("/it-fbw/roll-disable", 1);
		setprop("/it-fbw/man-roll-btn", 1);
	} else {
		setprop("/it-fbw/roll-disable", 0);
		setprop("/it-fbw/man-roll-btn", 0);
	}
}

var pitch = func {
	setprop("/it-autoflight/input/ap1", 0);
	setprop("/it-autoflight/input/ap2", 0);
	if (getprop("/it-fbw/man-pitch-btn") == 0) {
		setprop("/it-fbw/pitch-disable", 1);
		setprop("/it-fbw/man-pitch-btn", 1);
	} else {
		setprop("/it-fbw/pitch-disable", 0);
		setprop("/it-fbw/man-pitch-btn", 0);
	}
}

var update_fbw = func {
	if (getprop("/orientation/roll-deg") < 45 and getprop("/orientation/roll-deg") > -45) {
		if (getprop("/it-fbw/man-pitch-btn") == 0) {
			setprop("/it-fbw/pitch-disable", 0);
		}
	} else {
		setprop("/it-fbw/pitch-disable", 1);
	}
	if (getprop("/instrumentation/airspeed-indicator/indicated-speed-kt") >= 210) {
		if (getprop("/it-fbw/man-roll-btn") == 0) {
			setprop("/it-fbw/roll-disable", 0);
		}
	} else {
		setprop("/it-fbw/roll-disable", 1);
	}
}


####################
# Init and Various #
####################

setlistener("/sim/signals/fdm-initialized", func {
	update.start();
	print("Stabilization System ... OK!")
});

##########
# Timers #
##########
var update = maketimer(0.01, update_fbw);
