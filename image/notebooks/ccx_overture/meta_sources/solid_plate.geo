ch_length=0.02;

Point(1) = {0.0,0.0,0.0,ch_length};
Point(2) = {1.0,0.0,0.0,ch_length};
Point(3) = {1.0,-0.25,0.0,ch_length};
Point(4) = {0.0,-0.25,0.0,ch_length};

Line(1) = {4,3}; // bot
Line(2) = {3,2}; // right
Line(3) = {2,1}; // top
Line(4) = {1,4}; // left

Line Loop(1) = {1,2,3,4};
Transfinite Line{3} = 100; // matching the fluid
Plane Surface(1) = {1};

Mesh.Smoothing = 10;

Physical Surface(1) = {1};
Physical Line(2) = {1}; // dirichlet
Physical Line(3) = {2,4}; // neumann
Physical Line(4) = {3}; // interface
