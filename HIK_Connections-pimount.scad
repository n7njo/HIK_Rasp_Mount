
$fn=20;

Platform_Width = 143;
Platform_Length = 85;
Platform_Thickness = 2;
Platform_Raise = 2;

Rear_Screw_Distance = 127.5;
Front_Screw_Distance = 133.5;
Front2Rear_Screw_Distance = 55;
Left_Screw_Offset = 11.5;
Rear_Screw_Wall_Distance = 21;

Mounting_Thread_Height = 4.5;
Mounting_Thread_Diameter = 5.4;
Mounting_Thread_Thickness = 3;

/// Modules

module Screw_Column_Solid (screwdiameter,screwheight,thickness){
        cylinder(
            d = screwdiameter+thickness, 
            h = screwheight, 
            center=true);
}



// Create Screw Mounts
module Screw_Mounts (rearw, frontw, l, h, d, t){
    //Rear right
    echo (rearw);
    translate ([frontw/2, l/2,0])
        Screw_Column_Solid (d, h, t);
    //Front right 
    translate ([frontw/2, -l/2,0])
        Screw_Column_Solid (d, h, t);
    //Rear left
    translate ([(frontw/2)-Rear_Screw_Distance, l/2,0])
        Screw_Column_Solid (d, h, t); 
    //Front left
    translate ([-frontw/2, -l/2,0])
        Screw_Column_Solid (d, h, t); 
    //translate ([Side_Mount_Pad+t, -l/2,Side_Mount_Raise])
        //rotate ([0,90,0])
            //Screw_Column (d, h, t); 
}



module Cutout(l,d,t){
    hull(){
        translate([-l/2,0,-t])
            cylinder(d=d, h=t*2);
        translate([l/2,0,-t])
            cylinder(d=d, h=t*2);
        }
}

module Platform (w,l,t){
    difference(){
        cube ([w,l,t], center=true);
//        translate([0,35,0])
//            Cutout(w-20,6,t);
//        translate([0,25,0])
//            Cutout(w-20,6,t);
//        translate([0,10,0])
//            Cutout(w-20,6,t);
//        translate([0,0,0])
//            Cutout(w-20,6,t);
//        translate([0,-10,0])
//            Cutout(w-20,6,t);
//        translate([0,-20,0])
//            Cutout(w-20,6,t);
//        translate([0,-30,0])
//            Cutout(w-20,6,t);
        // Temp block out for test print
        translate([0,-7,0])
            cube([w-8,l-40,t*2], center=true);
        translate([0,34,0])
            cube([w-8,l-75,t*2], center=true);
        translate([2,-1,0])
            cube([w-26,l-7,t*2], center=true);
    }
}


/// Render

translate ([0,0,Platform_Thickness+Platform_Raise])
difference (){
    union(){
        // Base plate
        translate([0,6,0])
            Platform (
                Platform_Width,
                Platform_Length,
                Platform_Thickness);
        // Raised screw mounts
        translate([0,0,-Mounting_Thread_Height/2])
            Screw_Mounts (
                Rear_Screw_Distance, 
                Front_Screw_Distance,
                Front2Rear_Screw_Distance,
                Mounting_Thread_Height,
                Mounting_Thread_Diameter,
                Mounting_Thread_Thickness);
    }
    // Removed screw mounts
    translate ([0,0,-Platform_Thickness])
        Screw_Mounts (
            Rear_Screw_Distance, 
            Front_Screw_Distance,
            Front2Rear_Screw_Distance,
            Mounting_Thread_Height+Platform_Thickness,
            Mounting_Thread_Diameter,
            0);
}