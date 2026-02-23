
$fn = 100;

width = 40;
cav_width = 20.5;
wedge_width = 10.2;
in_width = 8.2;
w_thickness = 1.8;
length = 100;

tol = 0.1;

//ALUM Profile
//center
module core(length){
difference(){
    cube([12,12,length], center=true); 
    
    cylinder(length+tol, 3, 3, center=true);
}}



//corner
module corner(length){
    //diagonal piece
    difference(){
  
    rotate([0,0,45])
    translate([0,-2/2,-length/2])
    cube([sqrt((20^2)*2),2,length]);
    
    cylinder(length+tol, 3, 3, center=true);
    
    translate([10.25, 10.25,-length/2])
    translate([1.3, 1.3, -tol/2])
        cube([19.5/2 - 1.3*2, 19.5/2 - 1.3*2,length+tol]);
   
    }
    
    hook_edge(length);
    
    scale([-1,1,1])
    rotate([0,0,90])
    hook_edge(length);
}

module hook_edge(length){
    //not rounded rect
    translate([10.25, 10.25,-length/2])
    difference(){
        cube([19.5/2, 19.5/2,length]);
        
        translate([1.3, 1.3, -tol/2])
        cube([19.5/2 - 1.3*2, 19.5/2 - 1.3*2,length+tol]);
         
    }
    
    //edge
    translate([20-1.8, 0, -length/2]){
    difference(){
        cube([1.8, 20, length]);
        
        translate([0,0,length/2])
        cube([8.2,8.2,length+tol], center=true);
        
        translate([.8,8.2/2,-tol/2])
        cube([1,1,length+tol]);
    
    }
    //lil cube with notch for hooky part
    translate([-4.5+1.8, 8.2/2, 0])
    cube([4.5-1.8, 1.8, length]);
    }
 

}

module extrusionRail(length){
core(length);
for ( i = [0:1:3]){
    rotate([0,0,90*i])
    
    difference(){
        
    corner(length);

    /////// roudning

    translate([20-4.5,20-4.5,-length/2])
    cube([6,6,length+tol]);

    }
    
    rotate([0,0,90*i])
        
        intersection(){
        difference(){
            translate([20-4.5,20-4.5,0])
            cylinder(length, r=4.5, center = true);
            
            translate([20-4.5,20-4.5,0])
            cylinder(length+tol, r=4.5-1.8, center = true);
        }
        translate([20-4.5,20-4.5,-length/2])
        cube([5,5,length]);
        }
    }
}