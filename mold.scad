$fa = 1;
$fs = 0.2;

e = 0.001;

base_r = 21;
thickness = 4;

petals = 12;
full_circle = 360;
angle = 360 / petals;
petal_r = 22.6;
petal_center = 15.07;

top_slope = 1.9;
bottom_slope = 1;

carve_thickness = 2;

lunokhod_scale = 0.056 * 4;

module main_cylinder() {
  cylinder(h = thickness, r = base_r - 1, center = true);
}

module stamp() {
  difference() {
    intersection() {
      union () {
        difference() {
          main_cylinder();
          translate([0, 0, thickness / 2])
            children();
        }
        difference() {
          for (angle = [0 : angle : full_circle - angle]) {
            rotate([0, 0, angle])
              translate([0, petal_center, 0])
                cylinder(h = thickness - e, r = petal_r - petal_center, center = true);
          }
          main_cylinder();
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
  }
}

stamp() {
  translate([0, 0, -carve_thickness + 8 * e])
    rotate(10)
      scale([lunokhod_scale, lunokhod_scale, -carve_thickness / 100])
        surface("lunokhod_out.png", center = true, invert = true);
}
