size = 100;
$fs = 1;

intersection() {
	cylinder(size * 2, size, size, true);
	rotate([90, 0, 0])
		cylinder(size * 2, size, size, true);
	rotate([0, 90, 0])
		cylinder(size * 2, size, size, true);
}