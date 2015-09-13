class Ball {
  float ax = 0;
  float ay = g; // positive is down
  float vx = 0;
  float vy = 0;
  float x = 0;
  float y = 0;
  int d = 25;

  public Ball() {
    x = width/2;
  }
  public Ball(float x, float y) {
    this.x = x;
    this.y = y;
  }
  public Ball(float x, float y, float vx, float vy) {
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
  }

  void draw() {
    vx+=ax;
    vy+=ay;
    x+=vx;
    y+=vy;
    collision();
    fill(255, 0, 0);
    ellipse(x, y, d, d);
    
    //Blue line: ball's acceleration 
    //stroke(0,0,255);
    //line(x,y,1000*ax+x,1000*ay+y);
    //Green line: gravity
    //stroke(0,255,0);
    //line(x,y,x,y+g*1000);
    noFill();
//    ellipse(x,y,2*g*1000,2*g*1000);
    fill(150);
    //Red line: ball's velocity
    //stroke(255,0,0);
    //line(x,y,1000*vx+x,1000*vy+y);
//    println("v = ("+vx+","+vy+") = "+dist(0,0,vx,vy));
    stroke(0,0,0);
//    println("("+x+","+y+") <"+ax+","+ay+">");
  }

  void collision() {
    if (x>width) {
      vx*=0-r;
      vy*=r;
      x = width;
    }
    if (x<0) {
      vx*=0-r;
      vy*=r;
      x = 0;
    }
    if (y>height) {
      //    println(vy);
      vx*=r;
      vy*=0-r;
      y = height;
    }
    //no roof
    //  if(y<0){
    //    vx*=r;
    //    vy*=0-r;
    //    y = 0;
    //  }

    for (Ball b : balls) {
      if (dist(x, y, b.getX(), b.getY())<d) {
        //???
      }
    }
  }

  public void retard() {
    vx/=2;
    vy/=2;
  }
  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }
  public float getVX() {
    return vx;
  }
  public float getVY() {
    return vy;
  }
  public void setVX(float x) {
    vx = x;
  }
  public void setVY(float y) {
    vy = y;
  }
  public void addVX(float dv) {
    vx+=dv;
  }
  public void addVY(float dv) {
    vy+=dv;
  }
  public void setAX(float x) {
    ax = x;
  }
  public void setAY(float y) {
    ay = y;
  }
}

