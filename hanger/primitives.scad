module ring(width, height) {
	difference() {
		cylinder(r = 1 + width / 2, h = height, center = true, $fs = 0.01);
		cylinder(r = 1 - width / 2, h = height * 2, center = true, $fs = 0.01);
	}	
}

module angle_cutter(a1, a2, length, height) {

	module rect(a) {
		rotate([0, 0, -a])
			translate([length / 2, 0, 0])
				cube([length, 2 * length, height], true);
	}

	module rectpie0(a) {
		if (a <= 180) {
			intersection() {
				rect(0);
				rect(180 + a);
			}
		}
		else {
			union() {
				rect(0);
				rect(180 + a);
			}
		}
	}

	a1norm = a1 % 360;
	a2norm = a2 % 360;
	a2norm2 = a2norm < a1norm ? a2norm + 360 : a2norm;
	adiff = a2norm2 - a1norm;

	rotate([0, 0, -a1norm])
		rectpie0(adiff);
}

module arc(width, height, a1, a2) {
	intersection() {
		ring(width, height);
		angle_cutter(a1, a2, 1 + width, height * 2 );
	}
}

arc(0.2, 0.3, 1030, 1090);