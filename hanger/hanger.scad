module hook(width, height) {
	difference() {
		cylinder(r = 1 + width / 2, h = height, center = true, $fs = 0.01);
		cylinder(r = 1 - width / 2, h = height * 2, center = true, $fs = 0.01);
		translate([0, (1 + width) / 2, 0])
			cube([3, 1 + width, height * 2], true);
	}
}

module hook_tip(width, height) {
	translate([1, 0, 0])
		cylinder(r = width / 2, h = height, center = true, $fs = 0.01);
}

scale(10) {

	minkowski() {
		union() {
			hook(0.01, 0.01);
		}
		sphere(0.1, $fs = 0.05);
	}
}