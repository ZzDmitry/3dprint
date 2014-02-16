module gear(h, n, s) {
	$fs = 0.01;
	
	count = 2 * n;
	a_step = 360 / count;
	cut_size = 2 * PI / count / 2;

	module cut(extra_height) {
		for (a = [0 : n - 1]) {
			rotate([0, 0, 2 * a_step * a])
				translate([1, 0, 0])
					cylinder(extra_height * h, cut_size, cut_size, true);
		}
	}

	difference() {
		union() {
			cylinder(h, 1, 1, true);
			cut(1);
		}
		rotate([0, 0, a_step])
			cut(2);
	}

}

gear(0.1, 20);