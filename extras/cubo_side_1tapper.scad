include<../cubo_common.scad>
use <../cubo_side_generic.scad>
use<cubo_adafruit.scad>;

module cubo_side_1tapper() {
    union() {
        color("blue")
        translate([0,45,2*side_thickness])
        rotate([0,0,90])
        adafruit_412_solenoid();
        
        translate([0,-10,0])
        rotate([0,0,180])
        adafruit_3619_feather();
        
        difference() {
            cubo_side_with_screw_holes(text = "1tapper");

            // Room for wiring
            translate([0,-60,side_thickness/2])
            cube([ side_length - frame_length, frame_length/2, side_thickness + delta ], center = true);
        }
    }
}

cubo_side_1tapper();
