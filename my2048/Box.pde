class Box {

  public int r, c, value;
  public color c4;

  public Box(int row, int col) {
    r = row;
    c = col;
    c4 = color(150, 150, 150);
    value = 0;
  }

  void draw() {
    //println("("+c+","+r+") "+value);
    updateColor();
    fill(c4);
    rect(c*s, r*s, s, s);
    if (value != 0) {
      fill(textColor); 
      text(value, c*s+s/2, r*s+s/2);
    }
  }

  void updateColor(){
    float constant = 200/(log(target)/log(2));
    c4 = color(200-constant*(log(value)/log(2)));
  }

  boolean check(int other) {
    if (other == value) {
      value*=2;
      if (value==target) {
        winGame();
      }
      return true;
    }
    return false;
  }


  int getR() {
    return r;
  }
  int getC() {
    return c;
  }
  int getValue() {
    return value;
  }
  void setValue(int v) {
    value = v;
  }
  void addValue(int dv) {
    value+=dv;
  }
  boolean isEmpty() {
    return value==0;
  }
}

