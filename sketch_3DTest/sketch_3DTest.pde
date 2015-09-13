/*
float x,y,z;

void setup() {
  size(200,200,P3D);
  x = width/2;
  y = height/2;
  z = 0;
}

void draw() {
  translate(x,y,z);
  rectMode(CENTER);
  fill(255,0,0);
  stroke(0,255,0);
  rect(0,0,100,100);

  z++; // The rectangle moves forward as z increments.
  println("("+x+","+y+","+z+")");
}
*/
/*
size(200, 200, P3D);
background(100);
rectMode(CENTER);
fill(51);
stroke(255);

translate(100, 100, 0);
rotateZ(PI/8);
rect(0, 0, 100, 100);
*/
/*
size(640, 360, P3D); 
background(0);
lights();

noStroke();
pushMatrix();
translate(130, height/2, 0);
rotateY(1.25);
rotateX(-0.4);
box(100);
popMatrix();

noFill();
stroke(255);
pushMatrix();
translate(500, height*0.35, -200);
sphere(280);
popMatrix();
*/
