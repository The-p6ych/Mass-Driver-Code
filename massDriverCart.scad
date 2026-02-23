use <massDriverRail.scad>
use <massDriverMount.scad>

$fn = 100;

if ($preview == true){
    color("blue", 0.3)
    extrusionRail(100);
}

magnetL = 25.4;
magnetW = 9.53;
magnetH = 1.59;

bearingExD = 22;
bearingInD = 8;
bearingH = 7;

tol = 0.15;

cartL = 50;
cartW = 10;
cartH = 20;

wheelCartGap = 2;

//magnet
module magnet(){
    if ($preview == true){
    color("green", 0.3){
    cube([magnetW, magnetH, magnetL], center = true);
}    
}
}

//magnet();

//bearing/wheel
module bearing(){
    color("red", 0.3){
    difference(){
    cylinder(r = bearingExD/2, h = bearingH);
    
    cylinder(r = bearingInD/2, h = bearingH+tol);
}
}
}

module cart(){
    //dont change this
    rotate([0, 0, 0]){ //90
    
    //slot
    main_slot_loose();
        
    //main cart bodyyy
    translate([20, -cartW/2, -cartL/2]){
    difference(){    
    cube([cartH, cartW, cartL]);
       
    cube([5, cartW+tol, cartL+tol]);    
    }
    }
    
    translate([32.5,0,0])
    cube([15, 30, 20], center = true);
    
    //connection!!
    translate([20, 0, 0])
    cube([20, 6 , 6], center=true);

    //magnets
    translate([cartH+20-magnetW/2, cartW/2,0])
    magnet();
    translate([cartH+20-magnetW/2, -cartW/2,0])
    magnet();
    
    //bearing pegs
    translate([20+bearingExD/2,0,cartL/2]){
    rotate([90,0,0]){
    cylinder(h=cartH+bearingH*2+wheelCartGap*2-5, d=bearingInD-tol*2, center = true);
        
    cylinder(h=cartH, d=bearingInD+2, center = true);
    }
    }
    
    translate([20+bearingExD/2,0,-cartL/2]){
    rotate([90,0,0]){
    cylinder(h=cartH+bearingH*2+wheelCartGap*2-5, d=bearingInD-tol*2, center = true);
    cylinder(h=cartH, d=bearingInD+2, center = true);
        
    }
        
    }

}
}
cart();
