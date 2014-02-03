module hook(width, height) {
	difference() {
		cylinder(r = 1 + width / 2, h = height, center = true, $fs=0.01);
		cylinder(r = 1 - width / 2, h = height * 2, center = true, $fs=0.01);
		translate([0, (1 + width) / 2, 0])
			cube([3, 1 + width, height * 2], true);
	}
}


scale(10)
	hook(0.3, 0.2);
