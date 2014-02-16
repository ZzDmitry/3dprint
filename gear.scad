module gear(n) {
	$fs = 0.01;
	
	a_step = 360 / n;
	cut_size = PI / n / 2;

	module cut(extra_height) {
		for (a = [0 : n - 1]) {
			rotate([0, 0, a_step * a])
				translate([1, 0, 0])
					cylinder(extra_height, cut_size, cut_size, true);
		}
	}

	difference() {
		union() {
			cylinder(1, 1, 1, true);
			cut(1);
		}
		rotate([0, 0, a_step / 2])
			cut(2);
	}

}

scale([1,1,0.1])
	gear(20);