include <BOSL/constants.scad>
use <BOSL/masks.scad>

include <cubo_common.scad>
use <cubo_side_top.scad>
use <cubo_joints.scad>

stand_gap = 20;
stand_x = stand_gap + side_length;
stand_y = stand_gap + side_thickness + get_joint_height();
stand_z = side_thickness + get_joint_width() + get_joint_thickness();

module heat_stand() {
    union() {
        // base
        translate([0,-(stand_gap)/2,2-side_thickness/2])
        cube([stand_x+stand_gap,stand_y+stand_gap,side_thickness], center=true);
        
        // holder
        difference() {
            translate([0,-(stand_y/2)+(stand_gap/2),(stand_z/2)])
            chamfer(chamfer=2, size=[stand_x,stand_y,stand_z]) {
                cube([stand_x,stand_y,stand_z], center=true);
            }

            translate([0,0,side_length/2])
            rotate([90,0,0])
            cubo_top(with_insert = true);

            joint_hole_x = get_joint_width() + get_joint_thickness();
            joint_hole_y = get_joint_height();
            joint_hole_z = 50;

            joint_translate_x = (side_length/2)-side_thickness-(joint_hole_x/2);
            translate([
                joint_translate_x,
                -(joint_hole_y/2)-side_thickness,
                (joint_hole_z/2)+side_thickness])
            cube([joint_hole_x , joint_hole_y, joint_hole_z ], center=true);

            translate([
                -joint_translate_x,
                -(joint_hole_y/2)-side_thickness,
                (joint_hole_z/2)+side_thickness])
            cube([joint_hole_x , joint_hole_y, joint_hole_z ], center=true);
        }
    }
}

heat_stand();
