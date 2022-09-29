// all sides have the same basic structure described here, and they're
// technically interchangeable. this is true for the all except
// the top and the bottom sides, which contain the inserts.

include <BOSL/constants.scad>
use <BOSL/masks.scad>
use <BOSL/shapes.scad>

include <cubo_common.scad>
use <cubo_joints.scad>
use <cubo_label.scad>

module
cubo_side()
{
    cube([ side_length, side_length, side_thickness ]);
}

// cubo_side();

module
cubo_side_with_chamfer()
{
    rotate([ 180, 0, 0 ])
        translate([ -side_length / 2, -side_length / 2, -side_thickness ])
            difference()
    {
        cubo_side();

        translate([ side_length / 2, 0, 0 ])
            chamfer_mask_x(l = side_length, chamfer = side_thickness);

        translate([ side_length / 2, side_length, 0 ])
            chamfer_mask_x(l = side_length, chamfer = side_thickness);

        translate([ 0, side_length / 2, 0 ])
            chamfer_mask_y(l = side_length, chamfer = side_thickness);

        translate([ side_length, side_length / 2, 0 ])
            chamfer_mask_y(l = side_length, chamfer = side_thickness);
    }
}

// cubo_side_with_chamfer();

module
cubo_side_with_label(text = "generic side")
{
    union()
    {
        cubo_side_with_chamfer();

        translate(
            [ 0, (side_length / 2) - (3 * side_thickness), side_thickness ])
            cubo_label(text = text);
    }
}

// base side for top and bottom
// cubo_side_with_label();

// finally, add the screw holes
joint_thickness = get_joint_thickness();

screw_x = (side_length / 2) - side_thickness - get_joint_thickness() -
          (get_joint_width() / 2);
screw_y = (side_length / 2) - (get_joint_height() / 2) - side_thickness;
screw_z = delta;

module
cubo_screw_set()
{
    rotate([ 180, 0, 0 ]) union()
    {
        // it happens twice for each screw (to remove the
        // center of the screw)
        translate([ screw_x, screw_y, screw_z ]) screw(default_screw, 10);
        translate([ screw_x, screw_y, screw_z + 5 ]) screw(default_screw, 10);

        translate([ screw_x, -screw_y, screw_z ]) screw(default_screw, 10);
        translate([ screw_x, -screw_y, screw_z + 5 ]) screw(default_screw, 10);

        translate([ -screw_x, screw_y, screw_z ]) screw(default_screw, 10);
        translate([ -screw_x, screw_y, screw_z + 5 ]) screw(default_screw, 10);

        translate([ -screw_x, -screw_y, screw_z ]) screw(default_screw, 10);
        translate([ -screw_x, -screw_y, screw_z + 5 ]) screw(default_screw, 10);
    }
}

// cubo_screw_set();

// base side for all except top and bottom
module
cubo_side_with_screw_holes(text = "cubo")
{
    difference()
    {
        cubo_side_with_label(text = text);
        cubo_screw_set();
    }
}

cubo_side_with_screw_holes();
