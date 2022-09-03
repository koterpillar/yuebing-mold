$fa = 1;
$fs = 0.2;

e = 0.001;

base_r = 21;
thickness = 5;

petals = 12;
full_circle = 360;
angle = 360 / petals;
petal_r = 22.6;
petal_center = 15.07;

top_slope = 1.9;
bottom_slope = 1;

carve_thickness = 3;
carve_shrink = 2;

difference() {
  intersection() {
    union () {
      cylinder(h = thickness, r = base_r, center = true);
      for (angle = [0 : angle : full_circle - angle]) {
        rotate([0, 0, angle])
          translate([0, petal_center, 0])
            cylinder(h = thickness, r = petal_r - petal_center, center = true);
      }
    }
    union () {
      translate([0, 0, (bottom_slope - top_slope) / 2])
        cylinder(h = thickness - top_slope - bottom_slope, r = petal_r, center = true);
      translate([0, 0, (thickness - top_slope) / 2])
        cylinder(h = top_slope, r1 = petal_r, r2 = base_r, center=true);
      translate([0, 0, (bottom_slope - thickness) / 2])
        cylinder(h = bottom_slope, r1 = base_r, r2 = petal_r, center=true);
    }
  }
  translate([0, 0, thickness / 2])
    carve(carve_thickness, carve_shrink)
      text("fox", size = 20, halign = "center", valign = "center");
}

jaws_distance = 26.2;
jaw_depth = 3.3;
jaw_width = 5.6;
jaw_height = 6;
jaw_tooth_depth = 1.5;
jaw_tooth_height = 2.6;
for (angle = [0 : full_circle / 2 : full_circle]) {
  rotate([0, 0, angle])
    translate([0, (jaws_distance - jaw_depth) / 2, - jaw_height / 2 - thickness / 2]) {
      cube([jaw_width, jaw_depth, jaw_height], center = true);
      translate([0, jaw_depth / 2 + jaw_tooth_depth / 2, jaw_tooth_height / 2 - jaw_height / 2])
        cube([jaw_width, jaw_tooth_depth, jaw_tooth_height], center = true);
    }
}

module carve(thickness, shrink, slice_thickness = 0.1) {
  for (t = [0 : slice_thickness : thickness]) {
    translate([0, 0, -t - slice_thickness])
      linear_extrude(height = slice_thickness + e)
        offset(delta = -t * shrink / thickness)
          children();
  }
}
