
$fn = 40;

/// Variables

Screw_Separation = 50.5;
Screw_From_Wall = 17.5;
Screw_Mount_Height = 5;
Screw_Diameter = 5.4; 
Screw_Mounting_Thickness = 2;
Side_Mount_Pad = 1.6;
Side_Mount_Raise = 3;

Fudge_Print = 0.4;

Fan_WidthHeight = 40;
Fan_Depth = 20;
Fan_Mount_Thickness = 3;
Fan_Diameter = 38;
Cable_Diameter = 3;
Cable_Hole_Height = 8;
Cable_Hole_Depth = 4;

Mount_Platform_Length = 51;
Mount_Platform_Width = 17+(Fan_Mount_Thickness*2);
Mount_Platform_Thickness_Height = 4.5;
Mount_Platform_Thickness_Width = 10;

module Screw_Column (screwdiameter, screwheight, thickness){
    difference (){
        cylinder(d = screwdiameter+thickness, h = screwheight, center=true);
        cylinder(d = screwdiameter, h = screwheight+1, center=true);
    }
}

module Screw_Column_Solid (screwdiameter, screwheight){
        cylinder(d = screwdiameter+Fudge_Print, h = screwheight, center=true);
}

// Create Screw Mounts
module Screw_Mounts (w, l, h, d, t){
    translate ([w, l/2,0])
        Screw_Column (d, h, t); 
    translate ([w, -l/2,0])
        Screw_Column (d, h, t);    
    //translate ([Side_Mount_Pad+t, -l/2,Side_Mount_Raise])
        //rotate ([0,90,0])
            //Screw_Column (d, h, t); 
}

module Mount_Platform (l, w, th, tw){
    difference(){
        union(){
            translate([w/2,l/2,0])
                cube([w,tw,th], center=true);
            translate([w/2,-l/2,0])
                cube([w,tw,th], center=true);
        }
        translate ([Screw_From_Wall, Screw_Separation/2,0])
            Screw_Column_Solid (
                Screw_Diameter, 
                Screw_Mount_Height); 
        translate ([Screw_From_Wall, -Screw_Separation/2,0])
            Screw_Column_Solid (
                Screw_Diameter, 
                Screw_Mount_Height); 
    }
    
}

module Fan_Mount (lw, d){
    difference(){
        translate([Fan_Mount_Thickness/2,0,Fan_Mount_Thickness/2]) 
        cube([d+(Fan_Mount_Thickness),
            lw+Fan_Mount_Thickness,
            lw+Fan_Mount_Thickness], 
            center=true);
        translate([0,0,0])
            cube([d+Fudge_Print,lw+Fudge_Print,lw+Fudge_Print+1], center=true);
        translate([Fan_Mount_Thickness,0,(Fan_WidthHeight-Fan_Diameter)/2])
            rotate([0,90,0])
                cylinder(d=Fan_Diameter+Fudge_Print, h=Fan_Depth+(Fan_Mount_Thickness*4), center=true);
        translate([
            (Fan_Depth/2)-Cable_Hole_Depth,
            -Fan_WidthHeight/2,
            (Fan_WidthHeight/2)-Cable_Hole_Height])
            rotate([90,0,0])
                cylinder(d=Cable_Diameter+Fudge_Print, Fan_Mount_Thickness*2, center=true);
         translate([
            -(Fan_Depth/2)+Cable_Hole_Depth,
            Fan_WidthHeight/2,
            (Fan_WidthHeight/2)-Cable_Hole_Height])
            rotate([90,0,0])
                cylinder(d=Cable_Diameter+Fudge_Print, Fan_Mount_Thickness*2, center=true);
            
    }
    *translate([0,0,0])
    #cube([Fan_Depth,Fan_WidthHeight,Fan_WidthHeight], center=true);
}

//translate([0,0,Screw_Mount_Height/2])
//Screw_Mounts(
//    Screw_From_Wall, 
//    Screw_Separation, 
//    Screw_Mount_Height,
//    Screw_Diameter,
//    Screw_Mounting_Thickness);

translate([0,0,Mount_Platform_Thickness_Height/2])
Mount_Platform (
    Mount_Platform_Length, 
    Mount_Platform_Width, 
    Mount_Platform_Thickness_Height, 
    Mount_Platform_Thickness_Width);

translate([Fan_Depth/2,0,Fan_WidthHeight/2])
Fan_Mount (
    Fan_WidthHeight,
    Fan_Depth);