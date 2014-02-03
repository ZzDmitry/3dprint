
module hook_dot() {
	cube(1, true);
}


module hook(size, step) {
	for (a = [0:step:180]) {
		translate([size * -cos(a), size * -sin(a), 0])
			rotate([0, 0, a])
				hook_dot();
	}
}

module hook2(size, width, height) {
	difference() {
		cylinder(r1 = size, r2 = size, h = height, center = true);
		cylinder(r1 = size - width, r2 = size - width, h = height * 2, center = true);
		translate([0, size / 2, 0])
			cube([size * 3, size, height * 2], true);
	}
}


hook(10, 3);
hook2(8, 1, 2);