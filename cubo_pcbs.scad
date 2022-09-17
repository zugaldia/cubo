include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/pcbs.scad>

include <cubo_common.scad>

// pcb_insert + pcb_holder + height = frame_length - side_thickness
// so that the height of the pcb is enough to clear the height 
// of the joints and wires can easily go through "empty" sides
target_height = (frame_length/2)-side_thickness;
pcb_holder_height = side_thickness;
pcb_insert_height = target_height-pcb_holder_height;

// minimum recommended values for CNC kitchen 2.5 inserts
insert_height = 5;
insert_radius_internal = 2;
insert_radius_external = insert_radius_internal + 1.6;

module
pcb_insert()
{
    translate([ 0, 0, pcb_insert_height /2 ])
    difference()
    {
        cylinder(
            h = pcb_insert_height, r = insert_radius_external, center = true);

        translate([ 0, 0, ((pcb_insert_height-insert_height) / 2) + delta ]) cylinder(
            h = insert_height, r = insert_radius_internal, center = true);
    }
}

//pcb_insert();

module
pcb_holder(cube_pcb = RPI4)
{
    // length, width, height (e.g. [85, 56, 1.4] for RPI4)
    pcb_extra = 5;
    pcb_size = pcb_size(cube_pcb);
    
    translate([0,0,pcb_holder_height/2])
    cube([ pcb_size[0] + pcb_extra, pcb_size[1] + pcb_extra, pcb_holder_height ],
         center = true);

    #translate([0,0,pcb_holder_height])
    pcb_screw_positions(cube_pcb) pcb_insert();

    if ($preview) {
        translate([ 0, 0, target_height]) pcb(cube_pcb);
    }
}

pcb_holder();
