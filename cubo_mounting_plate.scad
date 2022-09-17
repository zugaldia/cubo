include <BOSL/constants.scad>
use <BOSL/masks.scad>
use <BOSL/shapes.scad>

include <cubo_common.scad>

module
cubo_mounting_plate(screw_size = M4_cs_cap_screw)
{
    // this value is slightly larger than the grid length which
    // is 20 or lower, so that it holds in place.
    plate_length = 25;
    
    difference() {
        cyl(h=side_thickness,r=plate_length/2,
            center=true, chamfer=1);

        translate([ 0, 0, side_thickness / 2 + delta ])
        screw(screw_size, 10);
        
        translate([ 0, 0, 5 ])
        screw(screw_size, 10);
    }
}

// mounting plate where you can specify the distance between
// two M4 scres. the default is 75mm which the OAK-D-Lite
// by Luxonis uses and claims to be VESA:
// https://docs.luxonis.com/projects/hardware/en/latest/pages/DM9095.html#dimensions-and-weight

module
cubo_mounting_vesa(screw_gap = 75)
{
    plate_width = screw_gap + (2 * 10); // 1 cm gap on the sides
    plate_height = plate_width / 2;

    chamfer(chamfer = 1, size = [ plate_width, plate_height, side_thickness ])
    {
        difference()
        {
            cube([ plate_width, plate_height, side_thickness ], center = true);

            translate([ screw_gap / 2, 0, side_thickness / 2 + delta ])
                screw(M4_cs_cap_screw, 10);
            translate([ screw_gap / 2, 0, 5 ]) screw(M4_cs_cap_screw, 10);

            translate([ -screw_gap / 2, 0, side_thickness / 2 + delta ])
                screw(M4_cs_cap_screw, 10);
            translate([ -screw_gap / 2, 0, 5 ]) screw(M4_cs_cap_screw, 10);
        }
    }
}

mounting_type = "m4";
if (mounting_type == "m25") {
    cubo_mounting_plate(screw_size = M2p5_cap_screw);
} else if (mounting_type == "m3") {
    cubo_mounting_plate(screw_size = M3_cs_cap_screw);
} else if (mounting_type == "m4") {
    cubo_mounting_plate(screw_size = M4_cs_cap_screw);
} else if (mounting_type == "vesa") {
    cubo_mounting_vesa();
}
