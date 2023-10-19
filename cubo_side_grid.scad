include <cubo_common.scad>
use <cubo_side_generic.scad>

grid_length = side_length - frame_length;

module
cubo_grid_linear(small = false)
{
    // 15 is big enough to let the flat part of usb/power/microhdmi // cables go
    // through, 10 is better suited for regular/small zip ties.
    grid_hole = small ? 10 : 20;
    grid_count = small ? 13 : 7;

    // this makes sure that the grid has the same length both
    // vertically and horizontally
    grid_gap = (grid_length - (grid_count * grid_hole)) / (grid_count - 1);

    translate([ 0, -(grid_hole + grid_gap) * floor(grid_count / 2), 0 ]) union()
    {
        for (y = [0:1:grid_count - 1]) {
            translate([ 0, (grid_hole + grid_gap) * y, 0 ])
                cube([ grid_length, grid_hole, side_thickness + delta ],
                     center = true);
        }
    }
}

// cubo_grid_linear();

// small variation of the above, with cylinders across x and y
module
cubo_grid_gruyere(small = false)
{
    grid_hole = small ? 10 : 20;
    grid_count = small ? 13 : 7;

    // this makes sure that the grid has the same length both
    // vertically and horizontally
    grid_gap = (grid_length - grid_count * grid_hole) / (grid_count - 1);
    echo("gruyere grid_gap =", grid_gap);

    shift = -(grid_hole + grid_gap) * floor(grid_count / 2);
    translate([ shift, shift, 0 ]) union()
    {
        for (x = [0:1:grid_count - 1]) {
            for (y = [0:1:grid_count - 1]) {
                translate([
                    (grid_hole + grid_gap) * x,
                    (grid_hole + grid_gap) * y,
                    0
                ]) cylinder(h = side_thickness + delta,
                            r = grid_hole / 2,
                            center = true);
            }
        }
    }
}

// cubo_grid_gruyere();

module
cubo_side_grid_horizontal(small = false)
{
    difference()
    {
        cubo_side_with_screw_holes(text = "latitude");

        translate([ 0, 0, side_thickness / 2 ]) cubo_grid_linear(small = small);
    }
}

// cubo_side_grid_horizontal();

module
cubo_side_grid_vertical(small = false)
{
    difference()
    {
        cubo_side_with_screw_holes(text = "longitude");

        rotate([ 0, 0, 90 ]) translate([ 0, 0, side_thickness / 2 ])
            cubo_grid_linear(small = small);
    }
}

// cubo_side_grid_vertical();

module
cubo_side_grid(small = false)
{
    difference()
    {
        cubo_side_with_screw_holes(text = "flatiron");

        intersection()
        {
            translate([ 0, 0, side_thickness / 2 ])
                cubo_grid_linear(small = small);

            rotate([ 0, 0, 90 ]) translate([ 0, 0, side_thickness / 2 ])
                cubo_grid_linear(small = small);
        }
    }
}

// cubo_side_grid(small=false);

module
cubo_side_gruyere(small = false)
{
    difference()
    {
        cubo_side_with_screw_holes(text = "gruyere");

        translate([ 0, 0, side_thickness / 2 ])
            cubo_grid_gruyere(small = small);
    }
}

grid_name = "gruyere";
grid_size = "small"; // small, medium
is_small = grid_size == "small" ? true : false;

if (grid_name == "flatiron") {
    cubo_side_grid(small = is_small);
} else if (grid_name == "latitude") {
    cubo_side_grid_horizontal(small = is_small);
} else if (grid_name == "longitude") {
    cubo_side_grid_vertical(small = is_small);
} else if (grid_name == "gruyere") {
    cubo_side_gruyere(small = is_small);
}
