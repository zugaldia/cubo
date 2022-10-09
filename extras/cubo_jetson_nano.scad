include<../cubo_common.scad>
use<../cubo_joints.scad>
use<../cubo_pcbs.scad>
use <../cubo_side_top.scad>

// Got the step file from NVIDIA, then exported the base as
// a STL file with freeCAD
module cubo_nano_dev_board() {
    dimensions = [95.10, 74.15];
    nano_holes = [
        [1.55,14.57],
        [1.55,72.57],
        [87.55,72.57],
        [87.55,14.57],
    ];

    translate([ 0, 0, side_thickness])
    pcb_holder_custom(
        dimensions=dimensions, holes=nano_holes, calibrate=false);

    if($preview) {
        color("green")
        translate([-46.00,-22.50,21])
        import("nano/jetson_nano_base.stl");
    }
}

//cubo_nano_dev_board();

module cubo_bottom_nano() {
    union() {
        cubo_nano_dev_board();
        cubo_side_with_connectors(
            text = "nano", with_insert = true);
    }
}

cubo_bottom_nano();
