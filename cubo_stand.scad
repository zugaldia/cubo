include <BOSL/constants.scad>
use <BOSL/masks.scad>

include <cubo_common.scad>

stand_length = side_length / 2;

module cubo_stand_proto() {
    chamfer(chamfer=2, size=[stand_length,stand_length,stand_length]) {
        cube(size=[stand_length,stand_length,stand_length], center=true);
    }
}

//cubo_stand_proto();

// https://forum.prusa3d.com/forum/prusaslicer/rotate-a-cube-model-to-stand-on-one-of-its-corners/
y_rotation = atan(1 / sqrt(2));

module
cubo_stand(with_base = true)
{
    // unnecessary but the png looks a bit better with this rotation
    rotate([ 0, 0, -90 ]) union()
    {
        if (with_base) {
            translate([ 0, 0, -47 ])
                cylinder(h = side_thickness, r = stand_length, center = true);
        }

        difference()
        {
            rotate([ 45, y_rotation, 0 ]) cubo_stand_proto();

            translate([ 0, 0, 140 ]) rotate([ 45, y_rotation, 0 ])
                cube([ side_length, side_length, side_length ], center = true);

            translate([ 0, 0, -140 ])
                cube([ side_length, side_length, side_length ], center = true);
        }
    }
}

stand_type = "with_base";
if (stand_type == "with_base") {
    cubo_stand(with_base = true);
} else if (stand_type == "free_standing") {
    cubo_stand(with_base = false);
}
