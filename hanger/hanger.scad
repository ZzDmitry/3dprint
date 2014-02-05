use <primitives.scad>;

module hook(width, height) {
	arc(width, height, -90, 90);
}

module hook_tip(width, height) {
	translate([-1, 0, 0])
		cylinder(r = width / 2, h = height, center = true, $fs = 0.01);
}

module hook_extension(length, width, height) {
	translate([1, -length / 2, 0])
		cube([width, length, height], true);
}

function hook_joint_length() = 2 * cos(30);

module hook_joint(ext_len, width, height) {
	translate([0, -ext_len, 0])
		arc(width, height, 90, 90 + 60);
	translate([1, -(ext_len + hook_joint_length()), 0])
		arc(width, height, -90, -30);
}

module cross_joint(shoulders_angle, width, height) {
	translate([-1, 0, 0])
		arc(width, height, 90, 180 - shoulders_angle);
	translate([1, 0, 0])
		arc(width, height, -180 + shoulders_angle, -90);
}

module cross_plate(width, height) {
	translate([0, -1, 0])
		scale([1, width, height])
			rotate([0, 90, 0])
				cylinder(2, sqrt(2), sqrt(2), true, $fs = 0.01);
}

module wing(length, width_scale, height_scale) {
	linear_extrude(length, scale = [width_scale, height_scale])
		circle(1, $fs = 0.01);
	translate([0, 0, length])
		scale([width_scale, height_scale, 1])
			sphere(1, $fs = 0.01);
}

module hanger() {

	w = 0.3;
	h = 0.2;
	h_ext = 0.5;

	scale(10) {
		hook(w, h);
		hook_tip(w, h);
		hook_extension(h_ext, w, h);
		hook_joint(h_ext, w, h);
		translate([0, -(hook_joint_length() + h_ext), 0]) {
			cross_joint(0, w, h);
			cross_plate(w / 2, h / 2);
//			translate([0, -1, 0])
//				scale([1, w * 0.5, h * 0.5])
//					rotate([0, 90, 0]) {
//						cylinder(2, 1, 1, true, $fs = 0.01);
//						translate([0, 0, 1])
//							wing(6, 3, 0.5);
//					}
		}
	}
}

hanger();

wing(6, 3, 1);