include <cubo_common.scad>
use <cubo_joints.scad>
use <cubo_side_generic.scad>

// a variation of cubo_side_empty where we leave a lower hole
// for typical wires entry (i.e power, hdmi).
module
cubo_side_arch(text = "arch")
{

    arch_width = side_length - 2 * (get_joint_width() + get_joint_thickness() +
                                    side_thickness);

    arch_height = arch_width / 2;

    difference()
    {
        cubo_side_with_screw_holes(text = text);

        translate(
            [ 0, (-side_length / 2) + (arch_height / 2), side_thickness / 2 ])
            cube([ arch_width, arch_height, side_thickness + delta ],
                 center = true);
    }
}

cubo_side_arch();
