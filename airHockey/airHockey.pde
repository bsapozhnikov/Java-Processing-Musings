//velocity in pixels per millis?

//puck
float x, y, vx, vy, r;

//player
float px, py, pvx, pvy, pr;
float timeDragged;
int lag = 10;
int lag2 = 20;
float[] oldpx, oldpy;
boolean pLetGo = false;

//enemy
float ex, ey, evx, evy, er;

void setup() {
  size(640, 300);
  setupPuck();
  setupPlayer();
  setupEnemy();
}

void setupPuck() { 
  x = width/2;
  y = height/2;
  vx=0;
  vy=0;
  r=10;
}
void setupPlayer() {
  px = 0;
  py = height/2;
  pvx=0;
  pvy=0;
  pr=10;

  timeDragged=0;
  oldpx = new float[lag];
  oldpy = new float[lag];
}
void setupEnemy() {
  ex=width;
  ey=height/2;
  evx=0;
  evy=0;
  er=10;
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (dist(mouseX, mouseY, px, py)<=pr) {
      timeDragged=0;
      pLetGo = true;
      oldpx = new float[lag];
      oldpy = new float[lag];
    }
  }
} 
void mouseDragged() {
  if (dist(mouseX, mouseY, px, py)<=pr && px<width/2) { //move player
    timeDragged++;

    pvx = 0;
    pvy = 0;
    /*
     pvx = mouseX-px;
     pvy = mouseY-py;
     */
    px = mouseX;
    py = mouseY;
    if (timeDragged>lag) {
      oldIncrement();
    }
  }
  //mouseReleased();
  pvx = (oldpx[lag-1]-oldpx[0])/lag2;
  pvy = (oldpy[lag-1]-oldpy[0])/lag2;

  checkCollision();
}

void mouseReleased() {
  println(pLetGo);
  if (pLetGo) {
    pLetGo = false;
    pvx = (oldpx[lag-1]-oldpx[0])/lag2;
    pvy = (oldpy[lag-1]-oldpy[0])/lag2;
  }
}

void draw() {
  clear();
  background(255);
  line(width/2,0,width/2,height);
  checkCollision();
  updatePuck();
  updatePlayer();
}

void keyPressed() {
  println("pressed " + keyCode);
  switch(keyCode) {
  case 32:
    vx = 0;
    vy = 0;
    pvx = 0;
    pvy = 0;
  }
}

void updatePuck() {
  x+=vx;
  y+=vy;
  fill(255, 0, 0);
  ellipse(x, y, 2*r, 2*r);
}

void updatePlayer() {
  px+=pvx;
  py+=pvy;
  fill(0, 0, 255);
  ellipse(px, py, 2*pr, 2*pr);
}

void checkBorders() {
  //puck
  if ((x+r>width && vx>0) || (x-r<0 && vx<0)) {
    vx*=-1;
  }
  if ((y+r>height && vy>0) || (y-r<0 && vy<0)) {
    vy*=-1;
  }

  //player
  if ((px+pr>width/2 && pvx>0) || (px-pr<0 && pvx<0)) {
    pvx*=-1;
  }
  if ((py+pr>height  && pvy>0) || (py-pr<0 && pvy<0)) {
    pvy*=-1;
  }
}

void oldIncrement() {
  for (int i=0; i<lag-1; i++) {
    oldpx[i]=oldpx[i+1];
    oldpy[i]=oldpy[i+1];
  }
  oldpx[lag-1]=mouseX;
  oldpy[lag-1]=mouseY;
}

void checkCollision() {
  checkBorders();
  if (dist(px, py, x, y)<=(pr+r)) {
    //println("collision");
    collisionPlayer();
  }
}

void collisionPlayer() {
  float v = dist(0, 0, pvx, pvy);
  updateV(v, getAnglePlayer());
}

void updateV(float v, float a) {
  vx = v*cos(a);
  vy = v*sin(a);
}

float getAnglePlayer() {

  float dx = x-px;
  float dy = y-py;
  println(atan(dy/dx));
  return atan(dy/dx);
}

