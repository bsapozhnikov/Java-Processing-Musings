class Point {
  float a, r;
  color c;

  public Point(float r, float a) {
    noStroke();
    this.a=a;
    this.r=r;
    c = color(255, 0, 0);
  }

  void draw() {
    fill(c);
    rect(getX(), getY(), 2, 2);
  }

  public void incrementA(){
    a+=1;
  }
  public void incrementR(){
    r+=1;
  }

  public float dist(Point other) {
    float sqr = (this.r*this.r)+(other.r*other.r)-2*this.r*other.r*cos(this.a-other.a);
    return sqrt(sqr);
  }
  public float getAngle() {
    return a;
  }
  public float getR() {
    return r;
  }
  public void setAngle(float a) {
    this.a=a;
  }
  public void setR(float r) {
    this.r=r;
  }
  public float getX() {
    float x = r*cos(a);
    return x+width/2;
  }
  public float getY() {
    float y = r*sin(a);
    return height/2-y;
  }
}
