include<../cubo_common.scad>
use<../cubo_joints.scad>
use<../cubo_pcbs.scad>

// Feather Board
// https://www.adafruit.com/product/3619
module adafruit_3619_feather() {
    dimensions = [50.80, 22.85];
    tripler_gap = 2.55;
    tripler_back_gap = 0.75;
    tripler_holes = [
        [tripler_gap,tripler_gap],
        [dimensions[0]-tripler_gap,tripler_gap-tripler_back_gap],
        [tripler_gap,dimensions[1]-tripler_gap],
        [dimensions[0]-tripler_gap,dimensions[1]-tripler_gap+tripler_back_gap]
    ];

    translate([ 0, 0, side_thickness])
    pcb_holder_custom(
        dimensions=dimensions, holes=tripler_holes, calibrate=false);

    if($preview) {
        // https://github.com/adafruit/Adafruit_CAD_Parts
        translate([
            -dimensions[0]/2,
            -dimensions[1]/2,
            2*side_thickness+12])
        color("green")
        import("Adafruit_CAD_Parts/3405 ESP32 Feather HUZZAH/3405 Adafruit HUZZAH32 ESP32 Feather.stl");
    }
}

//adafruit_3619_feather();

// Holder for FeatherWing Tripler Mini Kit
// Prototyping Add-on For Feathers
// https://www.adafruit.com/product/3417
module adafruit_3417_tripler() {
    // Assembled dimensions in docs: 71.25 x 51 x 12 mm
    // Adjusted based on the CAD file
    dimensions = [71.10, 50.85];
    tripler_gap = 2.55;
    tripler_holes = [
        [tripler_gap,tripler_gap],
        [dimensions[0]-tripler_gap,tripler_gap],
        [tripler_gap,dimensions[1]-tripler_gap],
        [dimensions[0]-tripler_gap,dimensions[1]-tripler_gap]
    ];

    translate([ 0, 0, side_thickness])
    pcb_holder_custom(
        dimensions=dimensions, holes=tripler_holes, calibrate=false);

    if($preview) {
        // https://github.com/adafruit/Adafruit_CAD_Parts
        translate([
            dimensions[0]/2,
            -dimensions[1]/2,
            2*side_thickness+12])
        rotate([0,0,90])
        color("green")
        import("Adafruit_CAD_Parts/3417 Tripler FeatherWing/3417 Tripler FeatherWing.stl");
    }
}

//adafruit_3417_tripler();

// Holder for small Adafruit solenoid
// https://cdn-shop.adafruit.com/product-files/412/412_C514-B.PDF
module adafruit_412_solenoid() {
    height = get_insert_depth()+1;
    distance_x = 18.2;
    distance_y = 16;
    distance_z = (height-get_insert_depth())/2+delta;

    difference() {
        cube([30, 30, height], center=true);

        translate([distance_x/2,distance_y/2,distance_z])
        cylinder(h = get_insert_depth(), r = get_insert_diameter() / 2, center = true);

        translate([-distance_x/2,-distance_y/2,distance_z])
        cylinder(h = get_insert_depth(), r = get_insert_diameter() / 2, center = true);
    }
}

//adafruit_412_solenoid();

module adafruit_arcade_5296() {
    dimensions=[76.3,21.5,13.0];
    holes=[
        [18.95,2.33],
        [18.95,19.16],
        [57.10,2.33],
        [57.10,19.16]
    ];
    pcb_holder_custom(
        dimensions=dimensions, holes=holes,
        calibrate=false, inserts_only=false);
    
    plate_gap = 50;
    screw_gap = (dimensions[0]+plate_gap)/2-(plate_gap/4);
    
    difference() {
        translate([0,0,side_thickness/2])
        cube([dimensions[0]+plate_gap,
            dimensions[1], side_thickness], center=true);
        
        translate([screw_gap,0,side_thickness/2])
        hull() nut(default_nut);
        
        translate([screw_gap,0,7])
        screw(default_screw, 10);
        
        translate([-screw_gap,0,side_thickness/2])
        hull() nut(default_nut);
        
        translate([-screw_gap,0,7])
        screw(default_screw, 10);
    }
}

adafruit_arcade_5296();
