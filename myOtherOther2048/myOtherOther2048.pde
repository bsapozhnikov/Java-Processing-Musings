int w = 3;
int h = 3;
int s = 100;
int numInitBoxes = 1;
Box[][] board;
int moving;
int step = 20;
ArrayList<Box> deathRow;
int score;

void setup() {
  size(w*s, h*s);
  noStroke();
  PFont font = loadFont("Calibri-Bold-48.vlw");
  textFont(font, 48);
  textAlign(CENTER, CENTER);
  board = new Box[h][w];
  moving = 0;
  deathRow = new ArrayList<Box>();
  for (int i=0; i<numInitBoxes; i++) {
    new Box();
  }
  score = 0;
}

void draw() {
  background(200);
  ArrayList<Box> killedRow = new ArrayList<Box>();
  for (Box b : deathRow) {
    println(b);
    println(moving);
    b.display();
    if (!b.executioner.mov) {
      killedRow.add(b);
    }
  }
  for (Box b : killedRow) {
    deathRow.remove(b);
  }
  for (int r=0; r<board.length; r++) {
    for (int c=0; c<board[0].length; c++) {
      if (board[r][c]!=null) {
        board[r][c].draw();
      }
    }
  }
  strokeWeight(10);
  stroke(150);
  for (int r=0; r<=height; r+=s) {
    line(0, r, width, r);
  }
  for (int c=0; c<=width; c+=s) {
    line(c, 0, c, height);
  }
  strokeWeight(1);
  fill(255, 180, 180);
  text(score, width/2, 20);  
}

void keyPressed() {
  //println(moving);
  //printBoard();
  if (moving>0)return;
  switch(keyCode) {
  case UP:
    //println("UP");
    for (int r=0; r<board.length; r++) {
      for (int c=0; c<board[0].length; c++) {
        if (board[r][c]!=null) {
          if (board[r][c].canMove(0, -1*s)) {
            moving++;
            board[r][c].mov = true;
            board[r][c].move(0, -1*s);
          }
        }
      }
    }
    break;
  case LEFT:
    //println("LEFT");
    for (int r=0; r<board.length; r++) {
      for (int c=0; c<board[0].length; c++) {
        if (board[r][c]!=null && board[r][c].canMove(-1*s, 0)) {
          moving++;
          board[r][c].mov = true;
          board[r][c].move(-1*s, 0);
        }
      }
    }
    break;
  case RIGHT:
    //println("RIGHT");
    for (int r=board.length-1; r>=0; r--) {
      for (int c=board[0].length-1; c>=0; c--) {
        if (board[r][c]!=null && board[r][c].canMove(s, 0)) {
          moving++;
          board[r][c].mov = true;
          board[r][c].move(s, 0);
        }
      }
    }
    break;
  case DOWN:
    //println("DOWN");
    for (int r=board.length-1; r>=0; r--) {
      for (int c=board[0].length-1; c>=0; c--) {
        if (board[r][c]!=null && board[r][c].canMove(0, s)) {
          moving++;
          board[r][c].mov = true;
          board[r][c].move(0, s);
        }
      }
    }
    break;
  }
  switch(key) {
  case 'r':
    setup();
  }
}

void printBoard() {
  String s = "";
  for (int r=0; r<board.length; r++) {
    for (int c=0; c<board[0].length; c++) {
      s+=board[r][c]+"\t";
    }
    s+="\n";
  }
  println(s);
}

