include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/pcbs.scad>

include <cubo_common.scad>

use <cubo_joints.scad>
use <cubo_label.scad>
use <cubo_pcbs.scad>
use <cubo_side_top.scad>

module
cubo_side_cable_pin() {
    pin_height = get_joint_height() - 5;

    union() {
        cylinder(h = pin_height, r=5, center=true);

        translate([0,0,8])
        cylinder(h = 5, r1=5, r2=10, center=true);
    }
}

//cubo_side_cable_pin();

module
cubo_bottom(cube_pcb = RPI4, text = "launchpad", with_insert = true, include_pins=true)
{
    union()
    {
        cubo_side_with_connectors(text = text,
                                  with_insert = with_insert);

        translate([ 0, 0, side_thickness]) pcb_holder(cube_pcb = cube_pcb);
        
        if (include_pins) {
            ping_gap = (side_length/2)-30;
            translate([ping_gap,ping_gap,5.5 + side_thickness])
            cubo_side_cable_pin();
            translate([ping_gap,-ping_gap,5.5 + side_thickness])
            cubo_side_cable_pin();
            translate([-ping_gap,ping_gap,5.5 + side_thickness])
            cubo_side_cable_pin();
            translate([-ping_gap,-ping_gap,5.5 + side_thickness])
            cubo_side_cable_pin();
        }
    }
}

cubo_connector = "insert"; // insert, nut
with_insert = cubo_connector == "insert" ? true : false;

// More out of the box supported PCBs:
// https://github.com/nophead/NopSCADlib#PCBs
pcb_name = "rpi4";

if (pcb_name == "arduinoleonardo") {
    cubo_bottom(cube_pcb = ArduinoLeonardo, text = "leonardo", with_insert = with_insert);
} else if (pcb_name == "arduinonano") {
    cubo_bottom(cube_pcb = ArduinoNano, text = "nano", with_insert = with_insert);
} else if (pcb_name == "arduinouno3") {
    cubo_bottom(cube_pcb = ArduinoUno3, text = "uno", with_insert = with_insert);
} else if (pcb_name == "rpi3") {
    cubo_bottom(cube_pcb = RPI3, text = "rpi3", with_insert = with_insert);
} else if (pcb_name == "rpi4") {
    cubo_bottom(cube_pcb = RPI4, text = "rpi4", with_insert = with_insert);
} else if (pcb_name == "rpipico") {
    cubo_bottom(cube_pcb = RPI_Pico, text = "pico", with_insert = with_insert);
} else if (pcb_name == "rpi0") {
    cubo_bottom(cube_pcb = RPI0, text = "zero", with_insert = with_insert);
} else if (pcb_name == "nopcb") {
    cubo_side_with_connectors(text = "launchpad", with_insert = with_insert);
}
