//ONLY WORKING WITH Y AXIS RIGHT NOW
float x = 150;
float y = 0.074;
float vx = 0;
float vy = 0;
float ax = 0;
float ay = 0;
float g = 9.81;
//density of ice = 934 kg/m^3 
float m = .01; //in kg
float r = .015; //in m
float normalForce = 0;
float dWater = 1000;

float volume() {
  return 4.0*PI*pow(r, 3)/3;
}

float forceOfGravity() {
  return m * g;
}

float metersToPixels(float n) {
  return n*300/0.072;
}
float pixelsToMeters(float n) {
  return n*0.072/300;
}

float WATER_LEVEL = pixelsToMeters(100);

//http://mathworld.wolfram.com/SphericalCap.html
float buoyantForce(boolean prnt) {
  if (y-r>WATER_LEVEL) {
    if (prnt)println("fully submerged");
    return -1*dWater*volume()*g;
  } else if (y+r>WATER_LEVEL) {
    if (prnt)println("partially submerged");
    float h = WATER_LEVEL-(y-r);
    float v = volume()-(PI*pow(h, 2)*(3*r-h)/3);
    if (prnt)println("Total Volume | Submerged Volume: "+volume()+" | "+v);
    return -1*dWater*v*g;
  }
  //return forceOfGravity();
  return 0;
}

void setup() {
  size(300, 500);
  //ONLY WORKING WITH Y AXIS RIGHT NOW
  x = 150;
  y = 0.074;
  vx = 0;
  vy = 0;
  ax = 0;
  ay = 0;
  g = 9.81;
  //density of ice = 934 kg/m^3 
  m = .01; //in kg
  r = .015; //in m
  normalForce = 0;
  dWater = 1000;
  //background(255); 
  //println(volume());
  //println(forceOfGravity());
}

void checkWalls() {
  if (y+r>pixelsToMeters(height)) {
    //println("floor");
    y = pixelsToMeters(height-1)-r;
    normalForce = -1*abs(forceOfGravity() - buoyantForce(false));
  } else {
    //normalForce = 0;

    //friction
    normalForce = m*vy*-1000;
  }
  //println("Normal Force: "+normalForce);
}

float addForces() {
  //println("Gravity Force: "+forceOfGravity());
  //println("Buoyant Force: "+buoyantForce(false));
  //println("Net Force: "+(forceOfGravity()+normalForce+buoyantForce(false)));
  return forceOfGravity()+normalForce+buoyantForce(false);
}

void draw() {
  checkWalls();
  ay=0.00001*addForces()/m;
  //vx+=ax;
  vy+=ay;
  //x+=vx;
  y+=vy;
  //println("y: "+y);
  //println("vy: "+vy);
  background(255);
  fill(0, 0, 250);
  rect(0, 100, width, height-100);
  fill(250, 0, 0);
  ellipse(x, metersToPixels(y), metersToPixels(r)*2, metersToPixels(r)*2);
}

void keyPressed() {
  switch (key) {
  case 'z':
    dWater -= 1;
    break;
  case 'x':
    dWater += 1;
    break;
  case ' ':
    println("############################");
    println("----------------------------");
    println("Density of Water: "+dWater);
    println("Mass of Ball: "+ m);
    println("Density of Ball: "+ (m/volume()));
    println("Buoyant Force: "+buoyantForce(true));
    println("----------------------------");
    break;
  case 'r':
    setup();
    break;
  }
  switch (keyCode) {
  case DOWN:
    m+=0.0001;
    break;
  case UP:
    if (m>0.00015) m-=0.0001;
    break;
  case LEFT:
    if (r>0.00015) r-=0.0001;
    break;
  case RIGHT:
    r+=0.0001;
    break;
  }
}

