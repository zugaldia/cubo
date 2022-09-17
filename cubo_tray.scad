include <openscad-tray/tray.scad>

include <cubo_common.scad>
use <cubo_label.scad>

module cubo_tray() {
    union() {
        column_split = 2/3;

        // y needs to be slightly larger so that there is some wiggle
        // room for the pieces + include thickness
        tray_thickness = side_thickness;
        tray_y = side_length + (3*tray_thickness);
        tray_x = tray_y;
        tray_z = side_length / 2;

        tray([tray_x, tray_y, tray_z],
            thickness = tray_thickness,
            n_columns=2,
            n_rows=[1,3],
            columns=[column_split, 1-column_split],
            curved=false);

        delta_z = tray_thickness;

        translate([
            (column_split * tray_x)/2,tray_y/2,delta_z])
        cubo_label(text = "cubo");

        translate([
            ((column_split + 1) * tray_x)/2,5*tray_y/6,delta_z])
        cubo_label(text = "m4");

        translate([
            ((column_split + 1) * tray_x)/2,tray_y/2,delta_z])
        cubo_label(text = "m3");

        translate([
            ((column_split + 1) * tray_x)/2,tray_y/6,delta_z])
        cubo_label(text = "m2.5");

    }
}

cubo_tray();
