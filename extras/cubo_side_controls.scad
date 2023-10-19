/*
 * A side with a host of controls (and a display) to manage
 * settings for different projects.
*/

include<../cubo_common.scad>
use<../cubo_side_generic.scad>
use<../cubo_pcbs.scad>
use<cubo_adafruit.scad>;

cutout_width_tft = (3.2 * 25.4) - 1; // avoids a small artifact/gap
cutout_height_tft= 2.46 * 25.4;

module adafruit_2090_tft() {
    // https://www.adafruit.com/product/2090
    board_width = 3.2 * 25.4;
    board_height = cutout_height_tft;
    hole_width = board_width-2.54;
    hole_height = board_height-2.54;
            
    translate([0,0,side_thickness/2])
    pcb_side_holder_custom(
        dimensions=[board_width,board_height,side_thickness],
        holes=[
            [hole_width,hole_height],
            [board_width-hole_width,hole_height],
            [board_width-hole_width,board_height-hole_height],
            [hole_width,board_height-hole_height]],
        calibrate=false);
}

//adafruit_2090_tft();

cutout_width_neoslider = 3 * 25.4;
cutout_height_neoslider = 0.85 * 25.4;

module adafruit_5295_neoslider() {
    // https://www.adafruit.com/product/5295
    board_width = cutout_width_neoslider;
    board_height = cutout_height_neoslider;
    hole_width = 19.05;
    hole_height = 19.05;
    
    if($preview) {
        translate([0,0,16.15])
        color("green")
        import("Adafruit_CAD_Parts/5295 NeoSlider Stemma/5295 NeoSlider Stemma.stl");
    }
            
    translate([0,0,side_thickness/2])
    pcb_side_holder_custom(
        dimensions=[board_width,board_height,side_thickness],
        holes=[
            [hole_width,hole_height],
            [board_width-hole_width,hole_height],
            [board_width-hole_width,board_height-hole_height],
            [hole_width,board_height-hole_height]],
        calibrate=false);
}

//adafruit_5295_neoslider();

cutout_width_rotary = 3 * 25.4;
cutout_height_rotary = 0.85 * 25.4;

module adafruit_5752_rotary() {
    // https://www.adafruit.com/product/5752
    board_width = cutout_width_rotary;
    board_height = cutout_height_rotary;
    hole_width = 19.05;
    hole_height = 19.05;
    
    if($preview) {
        translate([0,0,16.15])
        color("green")
        import("Adafruit_CAD_Parts/5752 Quad Rotary Breakout/5752 Quad Rotary Breakout.stl");
    }
        
    translate([0,0,side_thickness/2])
    pcb_side_holder_custom(
        dimensions=[board_width,board_height,side_thickness],
        holes=[
            [hole_width,hole_height],
            [board_width-hole_width,hole_height],
            [board_width-hole_width,board_height-hole_height],
            [hole_width,board_height-hole_height]],
        calibrate=false);
}

//adafruit_5752_rotary();

cutout_width_neokey = 3 * 25.4;
cutout_height_neokey = 0.85 * 25.4;

module adafruit_4980_neokey() {
    // https://www.adafruit.com/product/4980
    board_width = cutout_width_neokey;
    board_height = cutout_height_neokey;
    hole_width = 19.05;
    hole_height = 19.05;

    if($preview) {
        translate([-board_width/2,-board_height/2,16.15])
        color("green")
        import("Adafruit_CAD_Parts/4980 NeoKey 1x4 QT/4980 NeoKey 1x4 QT.stl");
    }
    
    translate([0,0,side_thickness/2])
    pcb_side_holder_custom(
        dimensions=[board_width,board_height,side_thickness],
        holes=[
            [hole_width,hole_height],
            [board_width-hole_width,hole_height],
            [board_width-hole_width,board_height-hole_height],
            [hole_width,board_height-hole_height]],
        calibrate=false);
}

//adafruit_4980_neokey();

module cubo_controls() {
    gap = 20;
    
    shift_neoslider = -67;
    shift_rotary = shift_neoslider + gap + 21.5/2;
    shift_tft = shift_rotary + gap + 62.5/2;
    shift_neokey = shift_tft + gap + 62.5/2;

    union() {
        difference() {
            rotate([0,0,90])
            cubo_side_with_screw_holes(text = "controls");
            
            translate([0,shift_tft,0])
            cube([cutout_width_tft, cutout_height_tft, 5*side_thickness], center=true);
            
            translate([0,shift_neoslider,0])
            cube([cutout_width_neoslider, cutout_height_neoslider, 5*side_thickness], center=true);
            
            translate([0,shift_rotary,0])
            cube([cutout_width_rotary, cutout_height_rotary, 5*side_thickness], center=true);
            
            translate([0,shift_neokey,0])
            cube([cutout_width_neokey, cutout_height_neokey, 5*side_thickness], center=true);
        }
    
        translate([0,shift_tft,-side_thickness])
        adafruit_2090_tft();
        
        translate([0,shift_neoslider,-side_thickness])
        adafruit_5295_neoslider();
        
        translate([0,shift_rotary,-side_thickness])
        adafruit_5752_rotary();
        
        translate([0,shift_neokey,-side_thickness])
        adafruit_4980_neokey();
    }
}

cubo_controls();
