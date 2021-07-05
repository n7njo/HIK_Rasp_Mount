$fn = 20;

Screw_Mounting_Thickness = 4;

PI_Screw_Length = 58;
PI_Screw_Width = 49;
PI_Screw_Diameter = 2.75;
PI_Screw_Height = 7;

HIK_Screw_Length = 95;
HIK_Screw_Width = 44;
HIK_Screw_Diameter = 3.8;
HIK_Screw_Height = 5;

Buck_Screw_Length = 16;
Buck_Screw_Width = 32;
Buck_Screw_Diameter = 3.8;
Buck_Screw_Height = 7;

Mount_Platform_Length = 89;
Mount_Platform_Width = 44;
Mount_Platform_Thickness_Height = 3;
Mount_Platform_Thickness_Width = 2;

module Screw_Column (screwdiameter, screwheight, thickness){
    difference (){
        cylinder(d = screwdiameter+thickness, h = screwheight, center=true);
        cylinder(d = screwdiameter, h = screwheight+1, center=true);
    }
}

// Create Screw Mounts
module Screw_Mounts (w, l, h, d, t){
    translate ([w/2, l/2,0])
        Screw_Column (d, h, t); 
    translate ([-w/2, l/2,0])
        Screw_Column (d, h, t); 
    translate ([-w/2, -l/2,0])
        Screw_Column (d, h, t); 
    translate ([w/2, -l/2,0])
        Screw_Column (d, h, t); 
}

module Mount_Platform (l, w, th, tw){
    translate([w/2,0,0])
        cube([tw,l,th], center=true);
    translate([-w/2,0,0])
        cube([tw,l,th], center=true);
    translate([0,l/2,0])
        cube([w,tw,th], center=true);
    translate([0,-l/2,0])
        cube([w,tw,th], center=true);
    translate([0,-34,0])  
        cube([w,tw,th], center=true);
    translate([0,28,0])  
        cube([w,tw,th], center=true);
    cube([tw,l,th], center=true);

}

// PI 1 mounting screw Columns
translate([0,-5,PI_Screw_Height/2])
Screw_Mounts(
    PI_Screw_Width, 
    PI_Screw_Length, 
    PI_Screw_Height,
    PI_Screw_Diameter,
    Screw_Mounting_Thickness);

// Buck mounting screw Columns
translate([0,(HIK_Screw_Length/2)-(Buck_Screw_Length/2),Buck_Screw_Height/2])
Screw_Mounts(
    Buck_Screw_Width, 
    Buck_Screw_Length, 
    Buck_Screw_Height,
    Buck_Screw_Diameter,
    Screw_Mounting_Thickness);

// HIK mounting screw Columns
translate([0,0,HIK_Screw_Height/2])
Screw_Mounts(
    HIK_Screw_Width, 
    HIK_Screw_Length, 
    HIK_Screw_Height,
    HIK_Screw_Diameter,
    Screw_Mounting_Thickness);

translate([0,0,Mount_Platform_Thickness_Height/2])
Mount_Platform (
    Mount_Platform_Length, 
    Mount_Platform_Width, 
    Mount_Platform_Thickness_Height, 
    Mount_Platform_Thickness_Width);