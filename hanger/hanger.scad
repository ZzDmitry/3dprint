use <primitives.scad>;

module hook(width, height) {
	arc(width, height, -90, 90);
}

module hook_tip(width, height) {
	translate([-1, 0, 0])
		cylinder(r = width / 2, h = height, center = true, $fs = 0.01);
}

module hook_extension(length, width, height) {
	translate([1, -0.5, 0])
		cube([width, length, height], true);
}

module hook_joint(ext_len, width, height) {
	translate([0, -ext_len, 0])
		arc(width, height, 90, 90 + 45);
}

scale(10) {
	hook(0.3, 0.2);
	hook_tip(0.3, 0.2);
	hook_extension(1, 0.3, 0.2);
	hook_joint(1, 0.3, 0.2);
}