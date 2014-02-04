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

scale(10) {
	hook(0.3, 0.2);
	hook_tip(0.3, 0.2);
	hook_extension(0.5, 0.3, 0.2);
	hook_joint(0.5, 0.3, 0.2);
	translate([0, -(hook_joint_length() + 0.5), 0]) {
		cross_joint(0, 0.3, 0.2);
		translate([0, -1, 0])
			scale([1, 0.3, 0.2])
				rotate([0, 90, 0])
					cylinder(2, 1, 1, true, $fs = 0.01);
	}
}