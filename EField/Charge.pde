class Charge {
  float x, y;
  float q;

  public Charge(float x, float y, float q) {
    this.x=x;
    this.y=y;
    this.q=q;
  }

  void draw() {
    fill(255, 0, 0);
    stroke(0);
    ellipse(x, y, 10, 10);
  }

  PVector getEField(float ox, float oy) {
    if(dist(x,y,ox,oy)<1){
      return new PVector(0,0);
    }
    float mag = k*q/pow(dist(x,y,ox,oy),2);
    PVector ans = new PVector(ox-x, oy-y);
    ans.setMag(mag);
    return ans;
  }
}

