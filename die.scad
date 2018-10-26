hexCodes = "0123456789ABCDEF";

use <K2D-Regular.ttf> // https://fonts.google.com/?category=Sans+Serif,Monospace&subset=latin&selection.family=K2D

function spherical(r,theta,phi)=[r*cos(phi)*sin(theta),r*sin(phi)*sin(theta),r*cos(theta)];

function len(a) = sqrt(a[0]*a[0]+a[1]*a[1]+a[2]*a[2]);
function unit(a,o=[0,0,0])=(a-o)/len(a-o);
function matrix(ex,ey,ez,o)=[[ex[0],ey[0],ez[0],o[0]],[ex[1],ey[1],ez[1],o[1]],[ex[2],ey[2],ez[2],o[2]],[0,0,0,1]];

function pointCount(faces)=faces/2+2;
function point(faces,k,r)=(k < faces/2) ? spherical(r,90,(360/(faces/2))*k) : ((k == faces/2) ? [0,0,-r] : [0,0,r]);
function pointList(faces,r)=[for (k = [0:pointCount(faces)-1]) point(faces,k,r)];

function point4Count(faces)=4;
function point4(faces,k,r)=(k < 3) ? spherical(r,120,360/3*k) : [0,0,r];
function point4List(faces,r)=[for (k = [0:point4Count(faces)-1]) point4(faces,k,r)];

function faceCount(faces)=faces;
function face(faces,k)=(k<faces/2) ? [k, (k+1) % (faces/2),faces/2] : [(k+1)%(faces/2),(k)%(faces/2),faces/2+1];
function faceList(faces)=[for (k = [0:faceCount(faces)-1]) face(faces,k)];

function face4Count(faces)=faces;
function face4(faces,k)=(k<3) ? [k, (k+1) % (3),3] : [2,1,0];
function face4List(faces)=[for (k = [0:face4Count(faces)-1]) face4(faces,k)];

function faceOrigin(faces,k,r)=(point(faces,(k)%(faces/2),r)+point(faces,(k+1) % (faces/2),r))/2;
function faceEx(faces,k,r)=((k < faces/2) ? 1 : -1) *unit(point(faces,(k)%(faces/2),r),point(faces,(k+1) % (faces/2),r));
function faceEy(faces,k,r)=unit(k < faces/2 ? [0,0,-r] : [0,0,r],faceOrigin(faces,k,r));
function faceEz(faces,k,r)=unit(cross(faceEx(faces,k,r),faceEy(faces,k,r)));
function faceMatrix(faces,k,r)=matrix(faceEx(faces,k,r),faceEy(faces,k,r),faceEz(faces,k,r),faceOrigin(faces,k,r));

function face4Origin(faces,k,r)=(point4(faces,face4(faces,k)[0],r)+point4(faces,face4(faces,k)[1],r)+point4(faces,face4(faces,k)[2],r))/3;
function face4Ex(faces,k,r)=unit(point4(faces,face4(faces,k)[0],r),point4(faces,face4(faces,k)[1],r));
function face4Ey(faces,k,r)=unit(point4(faces,face4(faces,k)[2],r),face4Origin(faces,k,r));
function face4Ez(faces,k,r)=unit(cross(face4Ex(faces,k,r),face4Ey(faces,k,r)));
function face4Matrix(faces,k,r)=matrix(face4Ex(faces,k,r),face4Ey(faces,k,r),face4Ez(faces,k,r),face4Origin(faces,k,r));

// b-th bit of k
function bit(k,b)=((k % (pow(2,b+1))) >= pow(2,b)) ? 1 : 0;

function oddEvenValue(faces,k)=(k % 2 == 0) ? k : faces-k;
function revTopValue(faces,k)=(k < faces/2) ? k : faces/2+((faces-1)-k);
function faceValue(faces,k)= revTopValue(faces,oddEvenValue(faces,k));

function bitStr(faces,k)=str(faces > 8 ? bit(k,3) : "",faces > 4 ? bit(k,2) : "",faces > 2 ? bit(k,1) : "",bit(k,0));
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

module hexNCode(faces,k,r0,font0) {
  multmatrix(faceMatrix(faces,k,r0)) {
    translate([0,2*r0/3,-r0/40]) linear_extrude(height = r0/20) {
      text(hexStr(faces,faceValue(faces,k)), size = r0/(faces/3.5), font = font0, halign = "center", valign = "center", $fn=36);
    }
  }
}

module hex4Code(faces,k,r0,font0) {
  multmatrix(face4Matrix(faces,k,r0)) {
    for (s = [0:2]) {
      translate([0,r0/2,0]) {
	rotate(a=s*120+60,v=[0,0,1]) {
	  translate([0,2*r0/3,-r0/40]) linear_extrude(height = r0/20) {
	    text(hexStr(faces,faceValue(faces,k)), size = r0/6, font = font0, halign = "center", valign = "center", $fn=36);
	  }
	}
      }
    }
        
  }
}

module hexCodes(faces,r,font) {
  for (k = [0:faces-1]) {
    if (faces == 4) {
      hex4Code(faces,k,r,font);
    } else {
      hexNCode(faces,k,r,font);
    }
  }
}

module die(faces,r) {
  if (faces == 4) {
    polyhedron(points=point4List(faces,r), faces=face4List(faces));
  } else {
    polyhedron(points=pointList(faces,r), faces=faceList(faces));    
  }
}

module labeledDie(faces,r,font) {
  difference() {
    die(faces,r);
    union() {
      // bitCodes(faces,r,font);
      hexCodes(faces,r,font);
    }
  }
}

myFont = "K2D-Regular";
myFaces = 4;
myRadius = 10;

labeledDie(myFaces,myRadius,myFont);

