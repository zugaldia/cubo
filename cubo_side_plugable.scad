include <cubo_common.scad>
use <cubo_side_empty.scad>

module ext_connector_top() {
    difference() {
        translate([0,0,side_thickness/4])
        cube([10,10,side_thickness/2], center=true);
        
        translate([0,0,-delta])
        nut(default_nut);
        
        translate([0,0,5])
        scale([1.1,1.1,1.1]) screw(default_screw, 10);
    }
}

module ext_connector_bottom() {
    difference() {
        translate([0,0,side_thickness/4])
        cube([10,10,side_thickness/2], center=true);
        
        translate([0,0,0])
        rotate([0,180,0])
        screw(default_screw, 10);
        
        translate([0,0,5])
        screw(default_screw, 10);
    }
}

module ext_connector_top_set() {
    translate([70,70,0])
    ext_connector_top();
    
    translate([70,-70,0])
    ext_connector_top();
    
    translate([-70,70,0])
    ext_connector_top();
    
    translate([-70,-70,0])
    ext_connector_top();
}

module ext_connector_bottom_set() {
    translate([70,70,0])
    ext_connector_bottom();
    
    translate([70,-70,0])
    ext_connector_bottom();
    
    translate([-70,70,0])
    ext_connector_bottom();
    
    translate([-70,-70,0])
    ext_connector_bottom();
}

module cubo_side_ext() {
    cubo_side_empty(text="ext");
    ext_connector_bottom_set();
}

module ext_plate() {
    difference() {
        translate([0,0,side_thickness/2])
        cube([side_length - frame_length,side_length - frame_length,side_thickness], center=true);
        
        translate([70,70,0])
        cube([10,10,20], center=true);
        
        translate([70,-70,0])
        cube([10,10,20], center=true);
        
        translate([-70,70,0])
        cube([10,10,20], center=true);
        
        translate([-70,-70,0])
        cube([10,10,20], center=true);
        
        translate([90,0,0])
        cylinder(h=10, r=50, center=true);
        
        translate([-90,0,0])
        cylinder(h=10, r=50, center=true);
        
        translate([0,90,0])
        cylinder(h=10, r=50, center=true);
        
        translate([0,-90,0])
        cylinder(h=10, r=50, center=true);
    }
    
    translate([0,0,side_thickness/2])
    ext_connector_top_set();
}

//cubo_side_ext();
//ext_plate();
