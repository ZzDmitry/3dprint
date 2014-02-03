module hook2(size, width, height) {
	difference() {
		cylinder(r = 1, h = height, center = true);
		cylinder(r = 1 - width,	 h = height * 2, center = true);
		translate([0, size / 2, 0])
			#cube([3, 1, height * 2], true);
	}
}

hook2(8, 1, 2);