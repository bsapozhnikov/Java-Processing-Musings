int w = 3;
int h = 3;
int s = 50;
int min = 1;
int target = 256;
Box[][] board = new Box[w][h];
color textColor = color(255);
boolean moved = false;

void setup() {
  size(w*s, h*s);
  textSize(16);
  textAlign(CENTER, CENTER);
  setupBoard();
  addRand();
  update();
}

void setupBoard() {
  for (int r=0; r<h; r++) {
    for (int c=0; c<w; c++) {
      board[r][c] = new Box(r, c);
    }
  }
}

void endGame() {
  println("you lose");
  System.exit(0);
}
void winGame() {
  println("you win");
  System.exit(0);
}

void draw() {
}

void keyPressed() {
  println("pressed "+keyCode);
  switch(keyCode) {
  case 37:
    for (int r=0; r<h; r++) {
      for (int c=1; c<w; c++) {

        Box b = board[r][c];
        Box next = board[r][c-1];
        while (next.isEmpty () && b.getC()>0 && !b.isEmpty()) {
          moved = true;
          println("moving down "+b.getC());
          next.setValue(b.getValue());
          b.setValue(0);
          b = next;
          try {
            next = board[b.getR()][b.getC()-1];
          } 
          catch(Exception e) {
            println(b.getC()-1);
          }
        }
        if (!b.isEmpty() && !b.equals(next) && next.check(b.getValue())) {
          moved = true;
          b.setValue(0);
        }
      }
    }
    update();
    break;
  case 38:
    for (int r=1; r<h; r++) {
      for (int c=0; c<w; c++) {

        Box b = board[r][c];
        Box next = board[r-1][c];
        while (next.isEmpty () && b.getR()>0 && !b.isEmpty()) {
          moved = true;
          println("moving down "+b.getR());
          next.setValue(b.getValue());
          b.setValue(0);
          b = next;
          try {
            next = board[b.getR()-1][b.getC()];
          } 
          catch(Exception e) {
            println(b.getR()-1);
          }
        }
        if (!b.isEmpty() && !b.equals(next) && next.check(b.getValue())) {
          moved = true;
          b.setValue(0);
        }
      }
    }
    update();
    break;
  case 39:
    for (int r=0; r<h; r++) {
      for (int c=w-2; c>=0; c--) {

        Box b = board[r][c];
        Box next = board[r][c+1];
        while (next.isEmpty () && b.getC()<w-1 && !b.isEmpty()) {
          moved = true;
          println("moving down "+b.getC());
          next.setValue(b.getValue());
          b.setValue(0);
          b = next;
          try {
            next = board[b.getR()][b.getC()+1];
          } 
          catch(Exception e) {
            println(b.getC()+1);
          }
        }
        if (!b.isEmpty() && !b.equals(next) && next.check(b.getValue())) {
          moved = true;
          b.setValue(0);
        }
      }
    }
    update();
    break;
  case 40:
    for (int r=h-2; r>=0; r--) {
      for (int c=0; c<w; c++) {

        Box b = board[r][c];
        Box next = board[r+1][c];
        while (next.isEmpty () && b.getR()<h-1 && !b.isEmpty()) {
          moved = true;
          println("moving down "+b.getR());
          next.setValue(b.getValue());
          b.setValue(0);
          b = next;
          try {
            next = board[b.getR()+1][b.getC()];
          } 
          catch(Exception e) {
            println(b.getR()+1);
          }
        }
        if (!b.isEmpty() && !b.equals(next) && next.check(b.getValue())) {
          moved = true;
          b.setValue(0);
        }
      }
    }
    update();
    break;
  }
}

void update() {
  if (moved) {
    moved = false;
    addRand();
  }
  updateBoard();
}

void addRand() {
  ArrayList<Box> empty = new ArrayList<Box>();
  for (int r=0; r<h; r++) {
    for (int c=0; c<w; c++) {
      if (board[r][c].getValue() == 0) {
        empty.add(board[r][c]);
      }
    }
  }
  if (empty.size()==0) {
    endGame();
  }
  int r = (int)random(empty.size());
  Box b = empty.get(r);
  b.addValue(min);
}

void updateBoard() {
  background(255);
  for (int r=0; r<h; r++) {
    for (int c=0; c<w; c++) {
      board[r][c].draw();
    }
  }
}

