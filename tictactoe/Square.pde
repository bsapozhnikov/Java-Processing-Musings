class Square {

  int r, c; //location in board 
  int startX, startY; //offset from origin
  int value; //1 for player, -1 for computer, 0 for niether

  public Square(int row, int col, int sx, int sy){
    this(row,col);
    startX = sx;
    startY = sy;
  }
  public Square(int row, int col) {
    r=row;
    c=col;
    value = 0;
    startX = 0;
    startY = 0;
  }

  public int getValue() {
    return value;
  }
  public void setValue(int v) {
    value = v;
  }
  public boolean isEmpty(){
    return value==0;
  }

  void draw() {
    noFill();
    rect(c*s+startX, r*s+startY, c*s+s+startX, r*s+s+startY);
    String str = "";
    if (value == 1) {
      str="X";
    }
    if (value == -1) {
      str="O";
    }
    fill(textColor);
    text(str, c*s+s/2+startX, r*s+s/2+startY);
  }
  
  public String toString(){
    return "("+c+","+r+")\t"+value+"\t"+"("+(c*s+startX)+","+(r*s+startY)+")"+"\t"+"("+(c*s+s+startX)+","+(r*s+s+startY)+")";
  }
}

