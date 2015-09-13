ArrayList<Lever> levers = new ArrayList<Lever>();
ArrayList<Ball> balls = new ArrayList<Ball>();
Ball b;
Lever L;
boolean pause = false;

int fps = 100;
float r = 0.9;
float pressForce = 2;
float g = 9.8/fps;

void setup() {
  size(640, 300);
//  b = new Ball(width/2+50,115); //QIV
//  b = new Ball(width/2+50,100); //x-axis
  b = new Ball(width/2+25,60); //QI
  balls.add(b);
  L = new Lever(b,width/2,100);
  levers.add(L);
  frameRate(10);
}

void draw() {
  if(pause){return;}
  //clear();
  background(255);
  for (Ball b : balls) {
    b.draw();
  }
  //LEVERS DON'T WORK WHEN BALL IS ABOVE THE BASE OF THE LEVER :(
  for (Lever L : levers){
    L.draw();
  }
  //saveFrame("test.png");
}

void keyPressed() {
  println(keyCode);
  switch(keyCode){
    case 32:
      b.retard();
      break;
    case 37:
      b.addVX(0-pressForce);
      break;
    case 38:
      b.addVY(0-pressForce);
      break;
    case 39:
      b.addVX(pressForce);
      break;
    case 40:
      b.addVY(pressForce);
      break;
    case 80:
      pause = !pause;
      break;
  }
}

