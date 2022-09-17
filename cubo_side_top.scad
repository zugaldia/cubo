include <NopSCADlib/core.scad>

include <cubo_common.scad>

use <cubo_joints.scad>
use <cubo_label.scad>
use <cubo_side_generic.scad>

shift = (side_length / 2) - side_thickness;

module
cubo_side_with_connectors(text = "ready", with_insert = true)
{
    union()
    {
        cubo_side_with_label(text = text);

        rotate([ 0, 0, 0 ]) translate([ shift, shift, side_thickness ])
            double_connector(with_insert = with_insert);

        rotate([ 0, 0, 90 ]) translate([ shift, shift, side_thickness ])
            double_connector(with_insert = with_insert);

        rotate([ 0, 0, 180 ]) translate([ shift, shift, side_thickness ])
            double_connector(with_insert = with_insert);

        rotate([ 0, 0, 270 ]) translate([ shift, shift, side_thickness ])
            double_connector(with_insert = with_insert);
    }
}

module
cubo_top(with_insert = true)
{
    cubo_side_with_connectors(text = "hat", with_insert = with_insert);
}

// cubo_top();

module
cubo_top_empty(with_insert = true)
{
    difference()
    {
        cubo_top(with_insert = with_insert);

        translate([ 0, 0, side_thickness / 2 ]) cube(
            [
                side_length - frame_length,
                side_length - frame_length,
                side_thickness +
                delta
            ],
            center = true);
    }
}

cubo_connector = "insert"; // insert, nut
cubo_fill = "empty";       // filled, empty

with_insert = cubo_connector == "insert" ? true : false;
is_empty = cubo_fill == "empty" ? true : false;

if (is_empty) {
    cubo_top_empty(with_insert = with_insert);
} else {
    cubo_top(with_insert = with_insert);
}
