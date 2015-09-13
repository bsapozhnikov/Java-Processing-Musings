class Box {

  public float r, c; 
  public int value;
  public color c4;

  public Box(int row, int col) {
    r = row;
    c = col;
    c4 = color(150, 150, 150);
    value = min;
  }

  void draw() {
//    println("("+c+","+r+") "+value);
    updateColor();
    fill(c4);
    rect(c*s, r*s, s, s);
    if (value != 0) {
      fill(textColor); 
      text(value, c*s+s/2, r*s+s/2);
    }
  }

  void updateColor() {
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

  void move(int dr, int dc) {
    if (r+dr<0 || r+dr>=h || c+dc<0 || c+dc>=w) {
      println("on the edge");
      return;
    }
    Box next = board[(int)(r+dr)][(int)(c+dc)];
    if (next == null) {
      println("filling empty space");
      moved = true;
      float pr = 1.0*dr/lag;
      float pc = 1.0*dc/lag;
      println("step ("+pc+","+pr+")");
      int tr = (int)r+dr;
      int tc = (int)c+dc;
      while (abs(r-tr)>2/lag || abs(c-tc)>2/lag) {
        println((r-tr)+"\t"+(abs(r-tr)>2/lag)+"\t"+(c-tc)+"\t"+(abs(c-tc)>2/lag));
        r+=pr;
        c+=pc;
        updateBoard();
        /*
        if(r>h || c>w){
          break;
        }
        */
      }
      r=tr;
      c=tc;
      updateBoard();
      move(dr, dc);
      return;
    }
    if (next.getValue()==value) {
      moved = true;
      next = null;
      r+=dr;
      c+=dc;
      value*=2;
      println("merged into (" + c + "," + r + ") new value: "+value);
      return;
    }
  }

  int getR() {
    return (int)r;
  }
  float getRFloat() {
    return r;
  }
  int getC() {
    return (int)c;
  }
  float getCFloat() {
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

