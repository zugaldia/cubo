include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/pcbs.scad>

include <cubo_common.scad>

// pcb_insert + pcb_holder + height = frame_length - side_thickness
// so that the height of the pcb is enough to clear the height 
// of the joints and wires can easily go through "empty" sides
target_height = (frame_length/2)-side_thickness;
pcb_holder_height = side_thickness;
pcb_insert_height = target_height-pcb_holder_height;
pcb_extra = 5;

// minimum recommended values for CNC kitchen 2.5 inserts
insert_height = 5;
insert_radius_internal = 2;
insert_radius_external = insert_radius_internal + 1.6;

module
pcb_insert(calibrate=false)
{
    translate([ 0, 0, pcb_insert_height /2 ])
    union() {
        difference()
        {
            cylinder(
                h = pcb_insert_height, r = insert_radius_external, center = true);

            translate([ 0, 0, ((pcb_insert_height-insert_height) / 2) + delta ]) cylinder(
                h = insert_height, r = insert_radius_internal, center = true);
        }
        
        // Helps building custom PCB holders
        if (calibrate) {
            color("black")
            translate([ 0, 0, ((pcb_insert_height-insert_height)) + delta ]) cylinder(
                h = 2*insert_height, r = 0.5*insert_radius_internal, center = true);
        }
    }
}

//pcb_insert();

module
pcb_holder(cube_pcb = RPI4)
{
    // length, width, height (e.g. [85, 56, 1.4] for RPI4)
    pcb_size = pcb_size(cube_pcb);
    
    translate([0,0,pcb_holder_height/2])
    cube([ pcb_size[0] + pcb_extra, pcb_size[1] + pcb_extra, pcb_holder_height ],
         center = true);

    translate([0,0,pcb_holder_height])
    pcb_screw_positions(cube_pcb) pcb_insert();

    if ($preview) {
        translate([ 0, 0, target_height]) pcb(cube_pcb);
    }
}

//pcb_holder();

module
pcb_holder_custom(dimensions=[], holes=[], calibrate=false, inserts_only=false)
{
    // this is helpful for things like cameras that don't need
    // the base
    if (!inserts_only) {
        translate([0,0,pcb_holder_height/2])
        cube([
            dimensions[0] + pcb_extra,
            dimensions[1] + pcb_extra,
            pcb_holder_height ], center = true);
    }
    
    for($i = [0 : 1 : len(holes) - 1]) {
        hole = holes[$i];
        translate([hole[0]-(dimensions[0]/2), hole[1]-(dimensions[1]/2), pcb_holder_height])
        pcb_insert(calibrate=calibrate);
   }
}

dimensions = [75,50,10];
sample_holes = [ [pcb_extra,pcb_extra] ];
pcb_holder_custom(dimensions=dimensions, holes=sample_holes,calibrate=true);
