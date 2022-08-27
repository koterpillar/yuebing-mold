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
