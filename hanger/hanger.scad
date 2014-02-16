use <primitives.scad>;

module arc_facet(w, h, a1, a2) {
	intersection() {
		difference() {
			arc(w, h, a1, a2);
			cylinder(2 * h / 3, r1 = 1 - 2 * w / 3, r2 = 1, center = false, $fs = 0.01);
			mirror([0, 0, 1])
				cylinder(2 * h / 3, r1 = 1 - 2 * w / 3, r2 = 1, center = false, $fs = 0.01);
		}
		union() {
			cylinder(2 * h / 3, r1 = 1 + 2 * w / 3, r2 = 1, center = false, $fs = 0.01);
			mirror([0, 0, 1])
				cylinder(2 * h / 3, r1 = 1 + 2 * w / 3, r2 = 1, center = false, $fs = 0.01);
		}
	}
}

module bar_facet(l, w, h) {
	w2 = w / 2;
	h2 = h / 2;
	w6 = w / 6;
	h6 = h / 6;
	translate([0, 0, -l / 2])
	linear_extrude(height = l)
		polygon([[-w2, h6], [-w6, h2], [w6, h2], [w2, h6], [w2, -h6], [w6, -h2], [-w6, -h2], [-w2, -h6]], [[0, 1, 2, 3, 4, 5, 6, 7]]);
}

module hook(width, height) {
	arc_facet(width, height, -90, 90);
}

module hook_tip(width, height) {
	translate([-1, 0, 0])
		cylinder(r = width / 2, h = height, center = true, $fs = 0.01);
}

module hook_extension(length, width, height) {
	translate([1, -length / 2 + 0.01, 0])
		rotate([90, 0, 0])
			bar_facet(length + 0.02, width, height);
}

function hook_joint_length() = 2 * cos(30);

module hook_joint(ext_len, width, height) {
	translate([0, -ext_len, 0])
		arc_facet(width, height, 90, 90 + 61);
	translate([1, -(ext_len + hook_joint_length()), 0])
		arc_facet(width, height, -90, -30);
}

module cross_joint(shoulders_angle, width, height) {
	translate([-1, 0, 0])
		arc_facet(width, height, 90, 180 - shoulders_angle);
	translate([1, 0, 0])
		arc_facet(width, height, -180 + shoulders_angle, -89);
}

module cross_plate(width, height) {
	translate([0, -1, 0])
		scale([1, width, height])
			rotate([0, 90, 0])
				cylinder(2.1, 0.5, 0.5, true, $fs = 0.01);
}

module wing(length, width, height, end_width, end_height, round_length) {
	linear_extrude(length, scale = [end_height / height, end_width / width])
		scale([height / 2, width / 2, 1])
			circle(1, $fs = 0.01);
	translate([0, 0, length])
		scale([end_height, end_width, round_length]) {
			difference() {
				sphere(0.5, $fs = 0.01);
				translate([0, 0, -0.5])
					cube([2, 2, 1], true);
			}
		}
}

module wing_angle(length, width, height, end_width, end_height, round_length, angle) {
	translate([0, width / 2, 0])
		rotate([angle, 0, 0])
			translate([0, -width / 2, 0])
				wing(length, width, height, end_width, end_height, round_length);
}

module hanger() {

	w = 0.3;
	h = 0.2;
	h_ext = 0.5;
	l = 6;
	la = 10;
	sh_w = 3;
	sh_r = 1;

	plate_w = sqrt(2) * w;
	plate_h = sqrt(2) * h;

	scale(10) {
//		hook(w, h);
//		hook_tip(w, h);
//		hook_extension(h_ext, w, h);
//		hook_joint(h_ext, w, h);
		translate([0, -(hook_joint_length() + h_ext), 0]) {
			cross_joint(0, w, h);
			cross_plate(plate_w, plate_h);
			translate([-1, -1, 0])
				rotate([0, -90, 0])
					wing_angle(l, plate_w, plate_h, plate_w, plate_h * sh_w, sh_r, la);
//			translate([1, -1, 0])
//				rotate([0, 90, 0])
//					wing_angle(l, plate_w, plate_h, plate_w, plate_h * sh_w, sh_r, la);
		}
	}
}

hanger();
