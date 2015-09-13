int len = 50;
int wid = len*2;
float a, x, y;
int dropped;
int overlap;
float myPi, diff;
int fRate = 2;

void setup() {
  size(600, 600);
  background(0, 0, 255);
  frameRate(fRate);
  dropped = 0;
  overlap = 0;
  stroke(255, 0, 0);
  for (int k=0; k<width; k+=wid) {
    line(k, 0, k, height);
  }
}

//void draw(){}

void draw() {
  x = random(width);
  y = random(height);
  a = radians(random(360));
  float x1 = 1.0*len*cos(a)/2 + x;
  float y1 = 1.0*len*sin(a)/2 + y;
  a += PI;
  float x2 = 1.0*len*cos(a)/2 + x;
  float y2 = 1.0*len*sin(a)/2 + y;
  stroke(255);
  line(x1, y1, x2, y2);
  dropped++;
  if ((int(x2/wid) != int(x1/wid)) || x1<0 || x2<0) {
    overlap++;
  }
  myPi = 1.0*dropped/overlap;
  diff = 100*abs(myPi-PI)/PI;
  println(dropped+" / "+overlap+" = "+myPi+"\t"+diff+"%");
}

void keyPressed() {
  switch(key) {
  case 'r':
    setup();
    break;
  case '+':
    frameRate(frameRate+2);
    break;
  case '-':
    frameRate(frameRate-2);
    break;
  }
}

