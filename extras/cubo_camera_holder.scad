// First is the Android Things camera:
// https://www.technexion.com/product/cam-ov5645/

include<../cubo_common.scad>
use<../cubo_pcbs.scad>
use <../cubo_side_ext.scad>

dist_x = 17.9;
dist_y = 31.4;
dim_x = 25;
dim_y = 38.3;

holes = [
    [(dim_x - dist_x)/2, (dim_y - dist_y)/2],
    [(dim_x - dist_x)/2 + dist_x, (dim_y - dist_y)/2 + dist_y],
    [(dim_x - dist_x)/2 + dist_x, (dim_y - dist_y)/2],
    [(dim_x - dist_x)/2, (dim_y - dist_y)/2 + dist_y],
];

translate([0,0,-3])
pcb_holder_custom(
    dimensions=[dim_x, dim_y], holes=holes, calibrate=false, inserts_only=false);

rotate([0,180,0])
ext_plate();
