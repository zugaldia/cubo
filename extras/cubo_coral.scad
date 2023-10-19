include<../cubo_common.scad>
use<../cubo_joints.scad>
use<../cubo_pcbs.scad>
use<../cubo_side_top.scad>
use<../cubo_side_generic.scad>
use<../cubo_side_arch.scad>

// Dimensions
// https://coral.ai/docs/dev-board/datasheet/#mechanical-dimensions
module cubo_coral_dev_board() {
    dimensions = [85, 56];
    coral_gap = 3.50;
    coral_gap_x = 58;
    coral_gap_y = 49;
    coral_holes = [
        [coral_gap,coral_gap],
        [coral_gap+coral_gap_x,coral_gap],
        [coral_gap,coral_gap+coral_gap_y],
        [coral_gap+coral_gap_x,coral_gap+coral_gap_y]
    ];

    translate([ 0, 0, side_thickness])
    pcb_holder_custom(
        dimensions=dimensions, holes=coral_holes, calibrate=false);

    if($preview) {
        color("green")
        translate([-47.43,31.78,19])
        rotate([90,0,0])
        import("Coral-Dev-Board-and-case/Dev Board case - bottom.STL");
    }
}

//cubo_coral_dev_board();

module cubo_coral_camera_holder() {
    dimensions = [25,25];
    coral_gap = 2.5;
    coral_holes = [
        [coral_gap,coral_gap],
        [dimensions[0]-coral_gap,coral_gap],
        [coral_gap,dimensions[1]-coral_gap],
        [dimensions[0]-coral_gap,dimensions[1]-coral_gap]
    ];

    // Camera hole
    camera_pcb_length = 25;
    camera_pcb_gap = 1;
    translate([0,0,side_thickness])
    cube([
        camera_pcb_length+camera_pcb_gap,
        camera_pcb_length+camera_pcb_gap,
        side_thickness], center=true);
    
    // Screw holes
    for($i = [0 : 1 : len(coral_holes) - 1]) {
        hole = coral_holes[$i];
        translate([hole[0]-(dimensions[0]/2), hole[1]-(dimensions[1]/2), 5])
        color("black")
        screw(M2p5_cap_screw, 10);
    }
    
    // Cross
    translate([0,0,side_thickness/2])
    cube([
        2*camera_pcb_length+camera_pcb_gap,
        camera_pcb_length-10-camera_pcb_gap,
        side_thickness+delta], center=true);
    
    translate([0,0,side_thickness/2])
    rotate([0,0,90])
    cube([
        2*camera_pcb_length+camera_pcb_gap,
        camera_pcb_length-10-camera_pcb_gap,
        side_thickness+delta], center=true);

//    if($preview) {
//        color("green")
//        translate([-29.5,-27.5,-103])
//        import("Coral-Camera-and-Dev-Board-base/Dev Board camera base - camera mount.STL");
//    }
}

//cubo_coral_camera_holder();

module cubo_bottom_coral() {
    union() {
        cubo_coral_dev_board();
        cubo_side_with_connectors(
            text = "coral", with_insert = true);
    }
}

module cubo_coral_camera() {
    difference() {
        cubo_side_arch(text = "coral");
        
        translate([0,25,0])
        cubo_coral_camera_holder();
    }
}

cubo_bottom_coral();
//cubo_coral_camera();
