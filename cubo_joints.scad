include <NopSCADlib/core.scad>

include <BOSL/constants.scad>
use <BOSL/masks.scad>

include <cubo_common.scad>

// so that the hole position for joints (with nuts or with inserts)
// fall in the same place, both have the same height, width, and
// thickness. the thickness is the larger value, the one needed
// for threaded inserts. for regular nuts, half the size would be
// sufficient.
joint_height = (frame_length/2) - side_thickness;
joint_width = frame_length/2;

// dimensions for the cnc kitchen m3x5.7 hole
// we add one extra mm to hold it in the thickness
insert_diameter = 4;
insert_depth = 7; // min is 6.7

// provide a wall of ~1mm to host the insert
joint_thickness = insert_depth + 1;

function
get_insert_diameter() = insert_diameter;

function
get_insert_depth() = insert_depth;

function
get_joint_height() = joint_height;

function
get_joint_width() = joint_width;

function
get_joint_thickness() = joint_thickness;

module
joint_with_nut()
{
    translate([ 0, 0, joint_thickness ]) rotate([ 180, 0, 0 ]) difference()
    {
        translate([ 0, 0, joint_thickness / 2 ])
            cube([ joint_height, joint_width, joint_thickness ], center = true);

        // scale to give some wiggle room for the nut
        scale([ 1.1, 1.1, 1 ]) translate([ 0, 0, -delta ]) hull()
            nut(default_nut);
    }
}

// joint_with_nut();

module
joint_with_nut_and_screw()
{
    difference()
    {
        joint_with_nut();

        translate([ 0, 0, 9 ]) screw(default_screw, 10);
    }

    // show construction instructions
    if ($preview) {
        rotate([ 180, 0, 0 ]) translate([ 0, 0, 20 ]) screw(default_screw, 10);

        translate([ 0, 0, 25 ]) nut(default_nut);

        translate([ 0, 0, 8 ]) cylinder(h = 36, r = 0.1, center = true);
    }
}

// joint_with_nut_and_screw();

// this works well but alternatively we could reuse the insert
// from NopSCADlib instead of building one from scratch.
module
joint_with_insert()
{
    difference()
    {
        translate([ 0, 0, joint_thickness / 2 ])
            cube([ joint_height, joint_width, joint_thickness ], center = true);

        // insert hole
        translate([ 0, 0, (insert_depth / 2) - delta ])
            cylinder(h = insert_depth, r = insert_diameter / 2, center = true);
    }

    if ($preview) {
        rotate([ 180, 0, 0 ]) translate([ 0, 0, 20 ]) screw(default_screw, 10);

        translate([ 0, 0, -2 ]) cylinder(h = 17, r = 0.1, center = true);
    }
}

// joint_with_insert();

module
double_connector(with_insert = true)
{
    translate([ -joint_thickness, -joint_thickness, 0 ])
        cube([ joint_thickness, joint_thickness, joint_height ]);

    translate([ -(joint_width / 2) - joint_thickness, 0, joint_height / 2 ])
        rotate([ 90, 90, 0 ]) if (with_insert)
    {
        joint_with_insert();
    }
    else
    {
        joint_with_nut_and_screw();
    }

    translate([ 0, -(joint_width / 2) - joint_thickness, joint_height / 2 ])
        rotate([ 0, 270, 0 ]) if (with_insert)
    {
        joint_with_insert();
    }
    else
    {
        joint_with_nut_and_screw();
    }
}

with_insert = true;
double_connector(with_insert = with_insert);
