use <massDriverRail.scad>

$fn = 50;

w_thickness = 1.8;
tol = 0.5;


if ($preview == true){
    color("blue", 0.3)
    extrusionRail(10);
}

screw_radius = 2;
screw_padding = 5;

slot_height = 40;

arm_length = 6;

peg_depth = 5.5;

peg_tol = 0.1;

coil_support_length = 30;


core=2.378;
interior_radius=4;
wire_diameter=2.05;
wall_radius=5;
coil_length=20;
wall_width=5;

/// Main body
module main_slot(){
difference(){
    
    translate([21-4.5*2, 0,0])
    cube([20-4.5-12/2 -w_thickness/2 +1 - tol*4, 40-4.5*4-w_thickness - tol*5, slot_height], center=true);
    
    //slicing 45 degree chunks out
    rotate([0,0,45])
    translate([0,-2/2 -tol*5,-50])
    cube([30,10,100]);
    
    
    rotate([0,0,-45])
    translate([0,2/2 - 10 + tol*5,-50]) //rotates from bottom left corner, so shift it over
    cube([30,10,100]);
    
    //must cut off abit on the tip
    translate([20-4.5 +.5,0,0])
    cube([1+ tol*2, 100, 100], center =true); 
}
}

module main_slot_loose(){
difference(){
    
    translate([20-4.5*2, 0,0])
    cube([20-4.5-12/2 -w_thickness/2 +1 - tol*6, 40-4.5*4-w_thickness - tol*6, slot_height], center=true);
    
    //slicing 45 degree chunks out
    rotate([0,0,45])
    translate([0,-2/2 -tol*6,-50])
    cube([30,10,100]);
    
    
    rotate([0,0,-45])
    translate([0,2/2 - 10 + tol*6,-50]) //rotates from bottom left corner, so shift it over
    cube([30,10,100]);
    
    //must cut off abit on the tip
    translate([20-4.5 +.5,0,0])
    cube([1+ tol*6, 100, 100], center =true); 
}
}

// main bracket and holes
difference(){
    main_slot();
    
    s_offset = slot_height/2 - screw_padding;
    
    //screw hole
    translate([10,0,s_offset])
    rotate([0, 90, 0])
    cylinder(h=30, r=screw_radius, center=true);
    
    //screw hole
    translate([10,0,-s_offset])
    rotate([0, 90, 0])
    cylinder(h=30, r=screw_radius, center=true);
    
}


//attachments
difference(){
    translate([15 + arm_length/2,0,0])
    cube([arm_length, 8- tol, 16], center = true);
    
    
    translate([15 + arm_length - peg_depth,0,-screw_radius*2])
    rotate([0, 90, 0])
    cylinder(h=30, r=screw_radius);
    translate([15 + arm_length - peg_depth,0,screw_radius*2])
    rotate([0, 90, 0])
    cylinder(h=30, r=screw_radius);
}

translate([10, 0, 0]){

//peg/EVIL (-1)
#translate([-peg_depth-1,0,0]){
translate([15 + arm_length + 10,0, screw_radius*2])
rotate([0, 90, 0])
cylinder(h=peg_depth-peg_tol, r=screw_radius-peg_tol*2);
translate([15 + arm_length + 10,0, -screw_radius*2])
rotate([0, 90, 0])
cylinder(h=peg_depth-peg_tol, r=screw_radius-peg_tol*2);

}
//coil support
translate([15 + arm_length + 10,-coil_support_length/2+8/2, 0])
difference(){
    cube([5, coil_support_length, 16], center=true);
    rotate([0, 90, 0]){
    cylinder(r=1, h=20, center=true);
    
}
}}

//coil holder
module coil_holder(){
    
    translate([40-wall_width+arm_length-1.5, -coil_support_length-wall_radius/8, 0]){
    
    //core
    rotate([0, 90, 0]){
    difference(){
    union(){
    cylinder(r=interior_radius, h=coil_length);
    translate([0,0,-1])
    cylinder(r=wall_radius+interior_radius, h=wall_width);
    translate([0, 0, coil_length])
    cylinder(r=wall_radius+interior_radius, h=wall_width);
    }   
    
    translate([0,0,-wall_width])
    cylinder(r=core+tol, h=coil_length*2+tol);
    
}
//translate([0,0,coil_length+ wall_width + 3/2])
//cylinder(r=3, center = true, $fn=6, h=3);
}
}
}
coil_holder();