/*
 * Common definitions
 */

include <NopSCADlib/core.scad>

$fn = 50;

// the largest prime number I can fit in a 25x21x21cm bed
side_length = 190;
side_thickness = 4;

// for "empty" sides
frame_length = 40;

// to avoid rendering artifacts (shimmering walls)
delta = 0.01;

default_nut = M3_nut;
// nut(default_nut);

default_screw = M3_cs_cap_screw;
// screw(default_screw, 10);

// 2.77128 (radius from opposite flat sides)
// echo("nut_flat_radius: ", nut_flat_radius(default_nut));

// 2.4
// echo("nut_thickness: ", nut_thickness(default_nut));
