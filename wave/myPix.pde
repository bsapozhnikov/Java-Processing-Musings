class myPix {
  private float x, y;
  private float vx, vy;
  private color c;

  public myPix(float x, float y, float vx, float vy) {
    this.x=x;
    this.y=y;
    this.vx=vx;
    this.vy=vy;
    c = color(0,100,100);
  }

  public void update() {
    if (x<0 || x>=width) {
      vx*=-1;
    }
    if (y<0 || y>=height) {
      vy*=-1;
    }
    x+=vx;
    y+=vy;
    c = color(hue(c),saturation(c)-0.1, brightness(c));
    if(saturation(c)<0){
      pix.remove(this);
    }
    
    collision(getCollision(x,y));
    
  }

  void draw() {
    fill(c);
    rect(x, y, 1, 1);
    update();
  }
  
  public float getX(){return x;}
  public float getY(){return y;}
  public float getS(){return saturation(c);}
  
  public void setS(float s){
    c = color(hue(c),s,brightness(c));
  }
}

