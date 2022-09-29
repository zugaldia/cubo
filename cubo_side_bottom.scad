include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/pcbs.scad>

include <cubo_common.scad>

use <cubo_joints.scad>
use <cubo_label.scad>
use <cubo_pcbs.scad>
use <cubo_side_top.scad>

module
cubo_bottom(cube_pcb = RPI4, with_insert = true)
{
    union()
    {
        cubo_side_with_connectors(text = "launchpad",
                                  with_insert = with_insert);

        translate([ 0, 0, side_thickness]) pcb_holder(cube_pcb = cube_pcb);
    }
}

cubo_connector = "insert"; // insert, nut
with_insert = cubo_connector == "insert" ? true : false;

// More out of the box supported PCBs:
// https://github.com/nophead/NopSCADlib#PCBs
pcb_name = "rpi4";

if (pcb_name == "arduinoleonardo") {
    cubo_bottom(cube_pcb = ArduinoLeonardo, with_insert = with_insert);
} else if (pcb_name == "arduinonano") {
    cubo_bottom(cube_pcb = ArduinoNano, with_insert = with_insert);
} else if (pcb_name == "arduinouno3") {
    cubo_bottom(cube_pcb = ArduinoUno3, with_insert = with_insert);
} else if (pcb_name == "rpi3") {
    cubo_bottom(cube_pcb = RPI3, with_insert = with_insert);
} else if (pcb_name == "rpi4") {
    cubo_bottom(cube_pcb = RPI4, with_insert = with_insert);
} else if (pcb_name == "rpipico") {
    cubo_bottom(cube_pcb = RPI_Pico, with_insert = with_insert);
} else if (pcb_name == "rpi0") {
    cubo_bottom(cube_pcb = RPI0, with_insert = with_insert);
} else if (pcb_name == "nopcb") {
    cubo_side_with_connectors(text = "launchpad", with_insert = with_insert);
}
