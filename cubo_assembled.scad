/*
 * Ideas:
 * - box to host base plates
 */

include <NopSCADlib/core.scad>

include <cubo_common.scad>

use <cubo_joints.scad>
use <cubo_label.scad>
use <cubo_side_bottom.scad>
use <cubo_side_empty.scad>
use <cubo_side_generic.scad>
use <cubo_side_grid.scad>
use <cubo_side_arch.scad>
use <cubo_side_top.scad>

color("violet", 0.5) cubo_bottom();

color("red", 0.5) translate([ side_length / 2, 0, side_length / 2 ])
    rotate([ 90, 0, -90 ]) cubo_side_empty(text = "side2");

color("green", 0.5) translate([ 0, side_length / 2, side_length / 2 ])
    rotate([ 90, 0, 0 ]) cubo_side_grid_horizontal();

color("blue", 0.5) translate([ -side_length / 2, 0, side_length / 2 ])
    rotate([ 90, 0, 90 ]) cubo_side_gruyere();

color("orange", 0.5) translate([ 0, -side_length / 2, side_length / 2 ])
    rotate([ 90, 0, 180 ]) cubo_side_arch();

color("violet", 0.5) translate([ 0, 0, side_length ]) rotate([ 0, 180, 0 ])
    cubo_top_empty();
