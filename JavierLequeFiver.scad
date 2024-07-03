//Part 1 of the parts clamp on the print bed
//These variables change the part 1 parameters

AcrylicThickness=4;
height1=20;
Width1=20;
Parts1=9;
GapDistance=2;


//These variables change the part 2 parameters

height2=20;
Width2=20;
Parts2=9;
GapDistance2=2;

// base 
Width=90;
Depth=420;
// Parts One and Two Boleans module 
Complete=false;

print=true;
module part1 (part1){
hull(){
translate([0,0,0])
cube(AcrylicThickness,true);
translate([0,0,height1])
cube(AcrylicThickness,true);    
}
hull(){
translate([0,Width1,height1])
cube(AcrylicThickness,true);
translate([0,0,height1])
cube(AcrylicThickness,true);    
}
hull(){
translate([0,Width1,0])
cube(AcrylicThickness,true);
translate([0,Width1,height1])
cube(AcrylicThickness,true);    
}
hull(){
translate([0,Width1,0])
cube(AcrylicThickness,true);
translate([0,Width1,height1])
cube(AcrylicThickness,true);    
}
hull(){
translate([0,Width1,0])
cube(AcrylicThickness,true);
translate([0,Width1*GapDistance,0])
cube(AcrylicThickness,true);    
}
}

module part2 (past2){
hull(){
translate([0,0,0])
cube(AcrylicThickness,true);
    translate([0,-Width2,0])
cube(AcrylicThickness,true);
    translate([0,0,height2])
cube(AcrylicThickness,true);
    translate([0,-Width2,height2])
cube(AcrylicThickness,true);
    
    }

}


module one (one){
for(j=[0:Parts2],k=[0:Parts2-1]){
 
translate([0,Width2*j*(GapDistance2),0])
part2();
    translate([0,Width2*k*(GapDistance2),0])
    hull(){
        translate([0,Width2,0]){
translate([0,0,height2])
cube(AcrylicThickness,true);
    translate([0,-Width2,height2])
cube(AcrylicThickness,true);
        }
    }
    translate([0,Width2*j*(GapDistance2),0])
    hull(){
    translate([-AcrylicThickness/2,-Width2/2,0])
    rotate([0,90,0])
   cylinder(h=AcrylicThickness,d=AcrylicThickness+2,$fn=50);
    translate([-AcrylicThickness/2,-Width2/2,-AcrylicThickness*2])
    rotate([0,90,0])
   cylinder(h=AcrylicThickness,d=AcrylicThickness+2,$fn=50);
}
}

}
//one();

module two(two){
for(i=[0:Parts1-1],w=[0:Parts1]){
    translate([0,(Width1*GapDistance)*i,0])
part1();
hull(){
translate([0,-Width1,0])
cube(AcrylicThickness,true);
translate([0,0,0])
cube(AcrylicThickness,true);    
}

translate([0,(Width1*GapDistance)*w,0])
hull(){
translate([-AcrylicThickness/2,-Width1/2,-1])
    rotate([0,90,0])
   cylinder(h=AcrylicThickness,d=AcrylicThickness+2,$fn=50);
translate([-AcrylicThickness/2,-Width1/2,-AcrylicThickness*2])
    rotate([0,90,0])
   cylinder(h=AcrylicThickness,d=AcrylicThickness+2,$fn=50);
}
}
}
module base (base){
    hull(){
    translate([0,0,0])
    cube(AcrylicThickness,true);
    translate([0,Depth,0])
    cube(AcrylicThickness,true);
    translate([Width,0,0])
    cube(AcrylicThickness,true);
    translate([Width,Depth,0])
    cube(AcrylicThickness,true);
}
}



if(Complete){
difference(){translate([0,-Width1,0])base();union(){translate([Width-2,Width1,AcrylicThickness+1])one();translate([2,Width1,AcrylicThickness+1])two();}  }
color("#90309020")
union(){translate([Width-2,Width1,AcrylicThickness])one();translate([2,Width1,AcrylicThickness])two();}
}
module fitting1 (fitting){
    translate([-AcrylicThickness,-Width1/2,-AcrylicThickness/2])
    cube([AcrylicThickness,2,AcrylicThickness+6],true);
}
module fitting2 (fitting){
    translate([0,0,-AcrylicThickness/2])
    cube([AcrylicThickness,2,AcrylicThickness+6],true);
}

module fitting (fitting){
    translate([30,0,0])
    cube([AcrylicThickness*2,2,AcrylicThickness],true);
}

if(print){
    difference(){
rotate([0,90,0])
one();
    for(d=[0:Parts2]){
    translate([-AcrylicThickness,Width2*d*(GapDistance2),0])
    fitting1();
    } 
   }
       translate([20,10,0])
difference(){
   translate([-28,10,0])
rotate([0,-90,0])
two();for(e=[0:Parts1]){
   translate([-Width1,Width1*e*(GapDistance),0])
    fitting2();}
}
   for(p1=[0:Parts1]){
translate([0,p1*AcrylicThickness,0])
fitting();}
translate([0,100,0])
 for(p2=[0:Parts2]){
translate([0,p2*AcrylicThickness,0])
fitting();}

    translate([40,0,0])
   difference(){translate([0,-Width1,0])base();union(){translate([Width-2,Width1,AcrylicThickness+1])one();translate([2,Width1,AcrylicThickness+1])two();}  } 
    }