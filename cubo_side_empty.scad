include <cubo_common.scad>
use <cubo_side_generic.scad>

module
cubo_side_empty(text = "nada")
{
    difference()
    {
        cubo_side_with_screw_holes(text = text);

        translate([ 0, 0, side_thickness / 2 ]) cube(
            [
                side_length - frame_length,
                side_length - frame_length,
                side_thickness + delta
            ],
            center = true);
    }
}

cubo_side_empty();
