module ring(width, height) {
	difference() {
		cylinder(r = 1 + width / 2, h = height, center = true, $fs = 0.01);
		cylinder(r = 1 - width / 2, h = height * 2, center = true, $fs = 0.01);
	}	
}

module angle_cutter(a1, a2, length, height) {
	union() {
		rotate([0, 0, -a1])
			translate([length / 2, 0, 0])
				cube([length, 2 * length, height], true);
		rotate([0, 0, -a2])
			translate([length / 2, 0, 0])
				cube([length, 2 * length, height], true);
	}
}

module hook(width, height) {
	difference() {
		cylinder(r = 1 + width / 2, h = height, center = true, $fs=0.01);
		cylinder(r = 1 - width / 2, h = height * 2, center = true, $fs=0.01);
		translate([0, (1 + width) / 2, 0])
			cube([3, 1 + width, height * 2], true);
	}
}

module hook_tip(width, height) {
	translate([1, 0, 0])
		cylinder(r = width / 2, h = height, center = true, $fs = 0.01);
}

module hook_extension(length, width, height) {
	translate([-1, 0.5, 0])
		cube([width, length, height], true);
}

module hook_joint(ext_len, width, height) {
	union() {
		ring(width, height);
		angle_cutter(30, 90, 1 + width, height * 2);
	}
}

scale(10) {
//	hook(0.3, 0.2);
// hook_tip(0.3, 0.2);
//	hook_extension(1, 0.3, 0.2);
	hook_joint(1, 0.3, 0.2);
}