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
				cylinder(2, 0.5, 0.5, true, $fs = 0.01);
}

module wing(length, width_scale, height_scale) {
	linear_extrude(length, scale = [width_scale, height_scale])
		circle(1, $fs = 0.01);
	translate([0, 0, length])
		scale([width_scale, height_scale, 1])
			sphere(1, $fs = 0.01);
}

module wing2(length, width, height, end_width, end_height, round_length) {
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

module wing2_angle(length, width, height, end_width, end_height, round_length, angle) {
	translate([0, width / 2, 0])
		rotate([angle, 0, 0])
			translate([0, -width / 2, 0])
				wing2(length, width, height, end_width, end_height, round_length);
}

module hanger() {

	w = 0.3;
	h = 0.2;
	h_ext = 0.5;
	l = 6;
	la = 10;

	plate_w = sqrt(2) * w;
	plate_h = sqrt(2) * h;

	scale(10) {
		hook(w, h);
		hook_tip(w, h);
		hook_extension(h_ext, w, h);
		hook_joint(h_ext, w, h);
		translate([0, -(hook_joint_length() + h_ext), 0]) {
			cross_joint(0, w, h);
			//cross_plate(w / 2, h / 2);
			cross_plate(plate_w, plate_h);
			translate([-1, -1, 0])
				rotate([0, -90, 0])
					wing2_angle(l, plate_w, plate_h, plate_w, plate_h * 3, 2, la);
			translate([1, -1, 0])
				rotate([0, 90, 0])
					wing2_angle(l, sqrt(2) * 0.3, sqrt(2) * 0.2, sqrt(2) * 0.3, sqrt(2) * 0.2 * 3, 2, la);
/*//
			translate([0, -1, 0]) {
				scale([1, w * 0.7, h * 0.7])
					rotate([0, 90, 0]) {
						//cylinder(2, 1, 1, true, $fs = 0.01);
						translate([0, 0, 1])
							#wing(6, 3, 0.5);
					}
			}
//*/

		}
	}
}

hanger();
/*
scale([1, 0.3 * 0.7, 0.2 * 0.7])
	rotate([0, 90, 0])
		wing(6, 3, 1);

scale([1, sqrt(2), sqrt(2)])
	translate([0, 1, 0])
		rotate([0, 90, 0])
			wing2(6, 0.3, 0.2, 0.3, 0.2 * 3, 2);
*/
translate([0, -1, 0])
	rotate([0, 90, 0])
		wing2(6, 0.3, 0.2, 0.3, 0.2 * 3, 2);

translate([0, 0, 0])
	rotate([0, 90, 0])
		wing2_angle(6, 0.3, 0.2, 0.3, 0.2 * 3, 2, 10);
