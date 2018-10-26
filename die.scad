hexCodes = "0123456789ABCDEF";

use <K2D-Regular.ttf> // https://fonts.google.com/?category=Sans+Serif,Monospace&subset=latin&selection.family=K2D

function spherical(r,theta,phi)=[r*cos(phi)*sin(theta),r*sin(phi)*sin(theta),r*cos(theta)];

function len(a) = sqrt(a[0]*a[0]+a[1]*a[1]+a[2]*a[2]);
function unit(a,o=[0,0,0])=(a-o)/len(a-o);
function matrix(ex,ey,ez,o)=[[ex[0],ey[0],ez[0],o[0]],[ex[1],ey[1],ez[1],o[1]],[ex[2],ey[2],ez[2],o[2]],[0,0,0,1]];

function pointCount(faces)=faces/2+2;
function point(faces,k,r)=(k < faces/2) ? spherical(r,90,360*(k/(faces/2))) : ((k == faces/2) ? [0,0,-r] : [0,0,r]);
function pointList(faces,r)=[for (k = [0:pointCount(faces)-1]) point(faces,k,r)];

function faceCount(faces)=faces;
function face(faces,k)=(k<faces/2) ? [k, (k+1) % (faces/2),faces/2] : [(k+1)%(faces/2),(k)%(faces/2),faces/2+1];
function faceList(faces)=[for (k = [0:faceCount(faces)-1]) face(faces,k)];
        
function faceOrigin(faces,k,r)=(point(faces,(k)%(faces/2),r)+point(faces,(k+1) % (faces/2),r))/2;
function faceEx(faces,k,r)=((k < faces/2) ? 1 : -1) *unit(point(faces,(k)%(faces/2),r),point(faces,(k+1) % (faces/2),r));
function faceEy(faces,k,r)=unit(k < faces/2 ? [0,0,-r] : [0,0,r],faceOrigin(faces,k,r));
function faceEz(faces,k,r)=unit(cross(faceEx(faces,k,r),faceEy(faces,k,r)));
function faceMatrix(faces,k,r)=matrix(faceEx(faces,k,r),faceEy(faces,k,r),faceEz(faces,k,r),faceOrigin(faces,k,r));

// b-th bit of k
function bit(k,b)=((k % (pow(2,b+1))) >= pow(2,b)) ? 1 : 0;

function oddEvenValue(faces,k)=(k % 2 == 0) ? k : faces-k;
function revTopValue(faces,k)=(k < faces/2) ? k : faces/2+((faces-1)-k);
function faceValue(faces,k)= revTopValue(faces,oddEvenValue(faces,k));

function bitStr(faces,k)=str(faces > 8 ? bit(k,3) : "",bit(k,2),bit(k,1),bit(k,0));
function hexStr(faces,k)=hexCodes[k];

module bitCode(faces,k,r0,font0) {
    multmatrix(faceMatrix(faces,k,r0)) {
        translate([0,r0/4,-r0/40]) linear_extrude(height = r0/20) {
            text(bitStr(faces,faceValue(faces,k)), size = r0/(faces/2.5), font = font0, halign = "center", valign = "center", $fn=24);
        }
    }
}

module bitCodes(faces,r,font) {
    for (k = [0:faces-1]) {
        bitCode(faces,k,r,font);
    }
}

module hexCode(faces,k,r0,font0) {
    multmatrix(faceMatrix(faces,k,r0)) {
        translate([0,2*r0/3,-r0/40]) linear_extrude(height = r0/20) {
            text(hexStr(faces,faceValue(faces,k)), size = r0/(faces/3.5), font = font0, halign = "center", valign = "center", $fn=36);
        }
    }
}

module hexCodes(faces,r,font) {
    for (k = [0:faces-1]) {
        hexCode(faces,k,r,font);
    }
}

module die(faces,r) {
    polyhedron(points=pointList(faces,r), faces=faceList(faces));
}

module roundedDie(faces,r) {
    intersection() {
      die(faces,r);
      sphere(r*0.95,$fn=360);
    }
}

module labeledDie(faces,r,font) {
  difference() {
    roundedDie(faces,r);
    union() {
        bitCodes(faces,r,font);
        hexCodes(faces,r,font);
    }
  }
}

font = "K2D-Regular";
faces = 8;
radius = 10;

labeledDie(faces,radius,font);



