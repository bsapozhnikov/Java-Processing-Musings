myPix test;
ArrayList<myPix> pix = new ArrayList<myPix>();

void setup() {
  size(640, 300);
  colorMode(HSB, 100);
  //fill(150,150,150);
  background(0, 0, 100);
  noStroke();
  //test = new myPix(320, 150, 2, 2);
}

void draw() {
  clear();
  background(0, 0, 100);
  //fill(255, 0, 0);
  //test.draw();
  for (myPix p : pix) {
    p.draw();
  }
}

void mouseClicked() {
  float x = mouseX;
  float y = mouseY;
  for (float a=0; a<360; a+=.1) {
    float vx = cos(radians(a));
    float vy = sin(radians(a));
    pix.add(new myPix(x, y, vx, vy));
  }
}

public ArrayList<myPix> getCollision(float x, float y) {
  ArrayList<myPix> ans = new ArrayList<myPix>();
  for (myPix p : pix){
    if(p.getX()==x && p.getY()==y){
      ans.add(p);
    }
  }
  return ans;
}

public void collision(ArrayList<myPix> L){
  //saturation
  float s = 0;
  for(myPix p : L){
    s+=p.getS();
  }
  for(myPix p : L){
    p.setS(s);
  }
}
