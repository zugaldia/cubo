// A generic side to mount a bunch of different
// adafruit panel mounts

include<cubo_common.scad>
use <cubo_side_generic.scad>

// a few round panel mounts use a 21.70 diameter
// dc power: https://www.adafruit.com/product/5607
// usb c: https://www.adafruit.com/product/4218

// others use a slightly larger one (24.70)
// https://www.adafruit.com/product/4129

// buttons are 28
// https://www.adafruit.com/product/3489
module cubo_round_mount(hole_diameter = 21.70) {
    hole_gap = 1.0;
    cylinder(h=2*side_thickness, r=(hole_diameter+hole_gap)/2, center=true);
}

//cubo_round_mount();

// Micro USB
// https://www.adafruit.com/product/3258
module adafruit_mount_microusb_3258() {
    screw_distance = 17.30;
    screw_diameter = 3.50;
    center_size_gap = 2.5;
    center_size_x = 9.05 + center_size_gap;
    center_size_y = 4.55 + center_size_gap;
    dent_x = 25.50;
    dent_y = 10.00;
    dent_gap = 2.0;
    
    translate([0,0,side_thickness/2])
    cube([dent_x+dent_gap, dent_y+dent_gap, side_thickness], center=true);

    translate([-screw_distance/2,0,0])
    cylinder(h=2*side_thickness+delta, r=screw_diameter/2, center=true);
    
    translate([screw_distance/2,0,0])
    cylinder(h=2*side_thickness+delta, r=screw_diameter/2, center=true);
    
    cube([center_size_x, center_size_y, 2*side_thickness+delta], center=true);
    
//    if ($preview) {
//        import("extras/Adafruit_CAD_Parts/3258 USB Panel Mout Cable/3258 microUSB panel mount.stl");
//    }
}

//adafruit_mount_microusb_3258();

// usb a
// https://www.adafruit.com/product/908
module adafruit_mount_usb_908() {
    screw_distance = 30.00;
    screw_diameter = 3.50;
    center_size_gap = 2.5;
    center_size_x = 14.65 + center_size_gap;
    center_size_y = 7.10 + center_size_gap;
    dent_x = 38.30;
    dent_y = 11.90;
    dent_gap = 2.0;
    
    translate([0,0,side_thickness/2])
    cube([dent_x+dent_gap, dent_y+dent_gap, side_thickness], center=true);
    
    translate([-screw_distance/2,0,0])
    cylinder(h=2*side_thickness+delta, r=screw_diameter/2, center=true);
    
    translate([screw_distance/2,0,0])
    cylinder(h=2*side_thickness+delta, r=screw_diameter/2, center=true);
    
    cube([center_size_x, center_size_y, 2*side_thickness+delta], center=true);
}

//adafruit_mount_usb_908();

// ethernet
// https://www.adafruit.com/product/909
module adafruit_mount_ethernet_909() {
    screw_distance = 25.00;
    screw_diameter = 3.50;
    center_size_gap = 2.5;
    center_size_x = 15.75 + center_size_gap;
    center_size_y = 13.65 + center_size_gap;
    dent_x = 33.45;
    dent_y = 20.65;
    dent_gap = 2.0;
    
    translate([0,0,side_thickness/2])
    cube([dent_x+dent_gap, dent_y+dent_gap, side_thickness], center=true);
    
    translate([-screw_distance/2,0,0])
    cylinder(h=2*side_thickness+delta, r=screw_diameter/2, center=true);
    
    translate([screw_distance/2,0,0])
    cylinder(h=2*side_thickness+delta, r=screw_diameter/2, center=true);
    
    cube([center_size_x, center_size_y, 2*side_thickness+delta], center=true);
}

//adafruit_mount_ethernet_909();

module cubo_side_mounts() {
    spacing = 55;
    
    difference() {
        cubo_side_with_screw_holes("plug&play");
        
        // Top row (arcade buttons)
        
        translate([0,spacing,side_thickness/2])
        cubo_round_mount(hole_diameter = 28);
        
        translate([spacing,spacing,side_thickness/2])
        cubo_round_mount(hole_diameter = 28);
        
        translate([-spacing,spacing,side_thickness/2])
        cubo_round_mount(hole_diameter = 28);
        
        // Middle row
        
        translate([0,0,side_thickness/2])
        cubo_round_mount(hole_diameter = 24.7);
        
        translate([spacing,0,side_thickness/2])
        cubo_round_mount(hole_diameter = 24.7);
        
        translate([-spacing,0,side_thickness/2])
        cubo_round_mount(hole_diameter = 24.7);
        
        // Lower row

        translate([0,-spacing,side_thickness/2])
        cubo_round_mount(hole_diameter = 21.7);
        
        translate([spacing,-spacing,side_thickness/2])
        cubo_round_mount(hole_diameter = 21.7);
        
        translate([-spacing,-spacing,side_thickness/2])
        cubo_round_mount(hole_diameter = 21.7);
        
        // Extras
        
        translate([-spacing/2,spacing/2,side_thickness/2])
        adafruit_mount_usb_908();

        translate([spacing/2,spacing/2,side_thickness/2])
        adafruit_mount_usb_908();

        translate([-spacing/2,-spacing/2,side_thickness/2])
        adafruit_mount_microusb_3258();
                
        translate([spacing/2,-spacing/2,side_thickness/2])
        adafruit_mount_ethernet_909();
    }
}

cubo_side_mounts();
