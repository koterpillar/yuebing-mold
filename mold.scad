cylinder(h = 5, r = 42, center = true);

petals = 12;
full_circle = 360;
angle = 360 / petals;
petal_r = 45.2;
petal_center = 30.37;
for (angle = [0 : angle : full_circle - angle]) {
  rotate([0, 0, angle]) translate([0, petal_center, 0]) cylinder(h = 5, r = petal_r - petal_center, center = true);
}
