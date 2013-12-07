// TopOpt PRUSA Mendel  
// Frame vertex
// GNU GPL v2
// Joshua Stults
// Topological Optimization of frame vertex
// https://github.com/jstults/topopt-framev
// From the original: 
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel
// Based on http://www.thingiverse.com/thing:5094/
// which was based on http://www.thingiverse.com/thing:2003 aka Viks footed 
// frame vertex, which is based on http://www.thingiverse.com/thing:1780 
// aka Tonokps parametric frame vertex

include <configuration.scad>

vfM8=m8_diameter+0.9;
vfvertex_height=vfM8+4;

vfFN=8;
module vertex(with_foot=true){
//with_foot=1;		// Comment out for no foot.


translate ([58,19,vfvertex_height/2])mirror()difference() 
{
	union () {
		dxf_linear_extrude(file = "vertex-body-fixed-qcad.dxf",height=vfvertex_height,center=true);
		//import_stl("vertex-body-fixed.stl");
		if (with_foot) {
			translate([40,-15,0]) vertex_foot();
		}
	}

	translate([11.013,59.912]) zhole(vfM8); 
	translate([40.274,9.249,0]) zhole(vfM8); 
	translate([40,21,0]) 
		xteardrop(vfM8,40);
	translate([13.687,41.010,0]) rotate(a=60,v=[0,0,1])
		xteardrop(vfM8,62);
	translate([15,17,0])big_hole();
}
}
vertex(true);

module zhole(diameter) cylinder(h=18,r=(diameter/2),center=true,$fn=vfFN); 

module xteardrop(diameter,length) rotate(a=-90,v=[0,1,0]) rotate(a=-90,v=[0,0,1]) zteardrop(diameter,length);

module yteardrop(diameter,length) rotate(a=90,v=[1,0,0]) zteardrop(diameter,length);

module zteardrop(diameter,height)
{
	rotate(a=0, v=[0,0,1]) union()
	{
		//translate([0,0,-height/2]) cube(size=[diameter/2,diameter/2,height],center=false);
		rotate(a=22.5, v=[0,0,1])cylinder(r=diameter/2, h = height,center=true,$fn=vfFN);
	}
}

module vertex_foot() {
	difference () {
		union () {
			cube([18,4,vfvertex_height],center=true);
			translate ([-5,8,0]) cube([5,18,vfvertex_height],center=true);
			translate ([5,9,0]) cube([5,18,vfvertex_height],center=true);
		}
		//translate ([0,8,0]) xteardrop(7,200);
	}
}

module big_hole(){
	difference(){
		scale([0.6,0.6,2])dxf_linear_extrude(file = "vertex-body-fixed-qcad.dxf",height=vfvertex_height,center=true);

scale([2,2,2]){translate([0,2,0])xteardrop(vfM8,50);
translate([-2,10,0])rotate(60)xteardrop(vfM8,50);}
}
}
