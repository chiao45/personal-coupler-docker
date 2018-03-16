// characteristics
lc_s_f = 0.02;
lc_s_c = 0.02;

p = newp;
Point(p+1) = {0.0,0.0,0.0,lc_s_c};
Point(p+2) = {1.0,0.0,0.0,lc_s_c};
Point(p+3) = {1.0,1.0,0.0,lc_s_f};
Point(p+4) = {0.0,1.0,0.0,lc_s_f};
l = newl;
Line(l+1) = {p+1,p+2};
Line(l+2) = {p+2,p+3};
Line(l+3) = {p+3,p+4};
Line(l+4) = {p+4,p+1};
ll = newll;
Line Loop(ll+1) = {l+1,l+2,l+3,l+4};
s = news;
Plane Surface(s+1) = {ll+1};
// make structured
// (Note for later use, Using {Progression,Bump} <value> for stretch/refine)
/* Transfinite Line{l+1} = 3;
Transfinite Line{l+2} = 3;
Transfinite Line{l+3} = 3; */
Transfinite Line{l+4} = 64;
//Transfinite Surface{s+1} = {p+1,p+2,p+3,p+4};
/* Recombine Surface{s+1}; */

Mesh.Smoothing = 100;

// group physical entities
Physical Surface(1) = {s+1};
Physical Line(2) = {l+1};
Physical Line(3) = {l+2};
Physical Line(4) = {l+3};
Physical Line(5) = {l+4};
