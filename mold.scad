$fa = 1;
$fs = 0.2;

thickness = 5;
cylinder(h = thickness, r = 21, center = true);

petals = 12;
full_circle = 360;
angle = 360 / petals;
petal_r = 22.6;
petal_center = 15.07;
for (angle = [0 : angle : full_circle - angle]) {
  rotate([0, 0, angle])
    translate([0, petal_center, 0])
      cylinder(h = thickness, r = petal_r - petal_center, center = true);
}

jaws_distance = 26.2;
jaw_depth = 3.3;
jaw_width = 5.6;
jaw_height = 6;
jaw_tooth_depth = 1.5;
jaw_tooth_height = 2.6;
for (angle = [0 : full_circle / 2 : full_circle]) {
  rotate([0, 0, angle])
    translate([0, jaws_distance / 2 - jaw_depth, - jaw_height / 2 - thickness / 2]) {
      cube([jaw_width, jaw_depth, jaw_height], center = true);
      translate([0, jaw_depth / 2 + jaw_tooth_depth / 2, jaw_tooth_height / 2 - jaw_height / 2])
        cube([jaw_width, jaw_tooth_depth, jaw_tooth_height], center = true);
    }
}
