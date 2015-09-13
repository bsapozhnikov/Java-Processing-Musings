class TTTBoard {

  Square[][] board;
  Square[][] lines; //all 8 of the possible three-in-a-row lines (3 squares per line)
  
  //used for lines and ai
  ArrayList<Square[]> human = new ArrayList<Square[]>();
  ArrayList<Square[]> both = new ArrayList<Square[]>();
  ArrayList<Square[]> comp = new ArrayList<Square[]>();
  
  int cur;
  int p1 = 1; //player
  int p2 = -1; //ai
  boolean game = true; //the game hasn't ended yet
  int win; //who won the game
  int startX, startY; //offset from origin


  public TTTBoard(int sx, int sy) {
    startX = sx;
    startY = sy;
    cur = 1;
    //setup board
    board = new Square[3][3];
    for (int r=0; r<3; r++) {
      for (int c=0; c<3; c++) {
        board[r][c] = new Square(r, c, startX, startY);
        println(board[r][c]);
      }
    }
    /*
    for(int i=0; i<3; i++){
     for(int j=0; j<3; j++){
     print(board[i][j]+" | ");
     }
     println("");
     }
     println("");
     */
     
    //setup lines
    lines = new Square[8][3];
    lines[0][0] = board[0][0];
    lines[0][1] = board[0][1];
    lines[0][2] = board[0][2];
    lines[1][0] = board[1][0];
    lines[1][1] = board[1][1];
    lines[1][2] = board[1][2];
    lines[2][0] = board[2][0];
    lines[2][1] = board[2][1];
    lines[2][2] = board[2][2];
    lines[3][0] = board[0][0];
    lines[3][1] = board[1][0];
    lines[3][2] = board[2][0];
    lines[4][0] = board[0][1];
    lines[4][1] = board[1][1];
    lines[4][2] = board[2][1];
    lines[5][0] = board[0][2];
    lines[5][1] = board[1][2];
    lines[5][2] = board[2][2];
    lines[6][0] = board[0][0];
    lines[6][1] = board[1][1];
    lines[6][2] = board[2][2];
    lines[7][0] = board[2][0];
    lines[7][1] = board[1][1];
    lines[7][2] = board[0][2];
    /*
    for(int i=0; i<8; i++){
     for(int j=0; j<3; j++){
     print(lines[i][j]+" | ");
     }
     println("");
     }
     */
    update();
  }
  public TTTBoard() {
    startX = 0;
    startY = 0;
    cur = 1;
    //setup board
    board = new Square[3][3];
    for (int r=0; r<3; r++) {
      for (int c=0; c<3; c++) {
        board[r][c] = new Square(r, c);
        println(board[r][c]);
      }
    }
    /*
    for(int i=0; i<3; i++){
     for(int j=0; j<3; j++){
     print(board[i][j]+" | ");
     }
     println("");
     }
     println("");
     */
    //setup lines
    lines = new Square[8][3];
    lines[0][0] = board[0][0];
    lines[0][1] = board[0][1];
    lines[0][2] = board[0][2];
    lines[1][0] = board[1][0];
    lines[1][1] = board[1][1];
    lines[1][2] = board[1][2];
    lines[2][0] = board[2][0];
    lines[2][1] = board[2][1];
    lines[2][2] = board[2][2];
    lines[3][0] = board[0][0];
    lines[3][1] = board[1][0];
    lines[3][2] = board[2][0];
    lines[4][0] = board[0][1];
    lines[4][1] = board[1][1];
    lines[4][2] = board[2][1];
    lines[5][0] = board[0][2];
    lines[5][1] = board[1][2];
    lines[5][2] = board[2][2];
    lines[6][0] = board[0][0];
    lines[6][1] = board[1][1];
    lines[6][2] = board[2][2];
    lines[7][0] = board[2][0];
    lines[7][1] = board[1][1];
    lines[7][2] = board[0][2];
    /*
    for(int i=0; i<8; i++){
     for(int j=0; j<3; j++){
     print(lines[i][j]+" | ");
     }
     println("");
     }
     */
    update();
  }

  void mouseClicked(float x, float y) {
    x-= startX;
    y-= startY;
    if (!game) { 
      return; //game has ended already
    }
    if (cur != p1) {
      return; //it's not your turn
    }
    //get row and col based on where you clicked
    int r = int(y/s);
    int c = int(x/s);
    //    println("("+c+","+r+")");
    Square s = board[r][c]; //get the square at that location
    if (s.isEmpty()) {
      //move there and next turn
      s.setValue(p1);
      cur*=-1;
    }
    update();
  }

  void update() {
    //    background(255);
    checkLines();
    if (cur==p2 && game) {
      ai();
    }
    for (int r=0; r<3; r++) {
      for (int c=0; c<3; c++) {
        board[r][c].draw();
      }
    }
    //draw the board
    stroke(0, 0, 255);
    noFill();
    strokeWeight(5);
    rect(startX, startY, s*3+startX, s*3+startY);
    stroke(0);
    strokeWeight(1);
    if (!game) { //show winner
      String str = "";
      if (win==p1) {
        str = "X";
      } else if (win==p2) {
        str = "O";
      }
      textSize(50);
      fill(color(0, 255, 0));
      int midX = (int)(s * 1.5+startX);
      int midY = (int)(s * 1.5+startY);
      text(str, midX, midY);    
      textSize(16);
      fill(textColor);
    }
  }

  void checkLines() {
    if (!game) {
      return;
    }
    
    //if there is a line with three-in-a-row, the game is over
    for (int i=0; i<8; i++) {
      Square[] a = lines[i];
      int a0 = a[0].getValue();
      int a1=a[1].getValue();
      int a2=a[2].getValue();
      if (a0!=0 && a0==a1 && a1==a2) {
        winner(a0);
      }
    }
    
    //if there are no empty squares, it's a tie
    boolean tie = true;
    for ( int r=0; r<3; r++) {
      for (int c=0; c<3; c++) {
        if (board[r][c].isEmpty()) {
          tie = false;
        }
      }
    }
    if (tie) {
      winner(0);
    }
  }

  void winner(int w) {
    println(w);
    win = w; //record winner
    
    //draw winner
    String str = "";
    if (w==p1) {
      str = "X";
    } else if (w==p2) {
      str = "O";
    }
    textSize(50);
    fill(color(0, 255, 0));
    int midX = (int)(s * 1.5+startX);
    int midY = (int)(s * 1.5+startY);
    text(str, midX, midY);    
    textSize(16);
    fill(textColor);
    game = false;
  }

  void ai() {
    Square s;
    Square[] a; //the line that the computer will make a move on 
    getLists();

    //if no empty squares, it's a tie
    if (human.size()+comp.size()+both.size() == 0) {
      winner(0);
      return;
    }
    
    //block if you can
    else if (human.size()>0) {
      a = human.get(0);
    }

    //attack if you can't block
    else if (comp.size()>0) {
      a = comp.get(0);
    }

    //random move if can't block ot attack
    else {
      a = both.get(0);
    }

    //move in the first empty square in the chosen line
    Square s0=a[0];
    Square s1=a[1];
    Square s2=a[2];
    if (s0.isEmpty()) {
      s = s0;
    } else if (s1.isEmpty()) {
      s = s1;
    } else {
      s = s2;
    }
    s.setValue(p2);
    cur*=-1;
    checkLines();
  }

  void getLists() {
    human = new ArrayList<Square[]>();
    comp = new ArrayList<Square[]>();
    both = new ArrayList<Square[]>();

    for (int i=0; i<8; i++) {
      Square[] a = lines[i];
      int a0 = a[0].getValue();
      int a1=a[1].getValue();
      int a2=a[2].getValue();
      int numP1 = 0;
      int numP2 = 0;
      if (a0 == p1) {
        numP1++;
      }
      if (a0 == p2) {
        numP2++;
      }
      if (a1 == p1) {
        numP1++;
      }
      if (a1 == p2) {
        numP2++;
      }
      if (a2 == p1) {
        numP1++;
      }
      if (a2 == p2) {
        numP2++;
      }
      //      println("numP1,numP2: " + numP1 + "," + numP2+" = "+(numP1+numP2));
      if (numP1+numP2<3) {
        println("numP1,numP2: " + numP1 + "," + numP2+" = "+(numP1+numP2));
        if (numP1>0 && numP2==0) {
          if (numP1==1) {
            human.add(a);
            println("added to end of human");
          } else {
            human.add(0, a);
            println("added to start of human");
          }
        } else if (numP1==0 && numP2>0) {
          if (numP2==1) {
            comp.add(a);
            println("added to end of comp");
          } else {
            comp.add(0, a);
            println("added to start of comp");
          }
        } else {
          both.add(a);
          println("added to both");
        }
      }
    }

    //print stuff
    String str = "human\n";
    for (Square[] a : human) {
      for (int i=0; i<a.length; i++) {
        Square sqr = a[i];
        str+=sqr.toString()+" | ";
      }
      str+="\n";
    }
    str += "\ncomp\n";
    for (Square[] a : comp) {
      for (int i=0; i<a.length; i++) {
        Square sqr = a[i];
        str+=sqr.toString()+" | ";
      }
      str+="\n";
    }
    str += "\nboth\n";
    for (Square[] a : both) {
      for (int i=0; i<a.length; i++) {
        Square sqr = a[i];
        str+=sqr.toString()+" | ";
      }
      str+="\n";
    }
    println(str);
  }

  public int result() {
    return win;
  }

  //used for SuperTTTBoard
  public void override(int r, int c, int value) {
    board[r][c].setValue(value);
    checkLines();
    if(!game){
      exit();
    }
  }

  public String toString() {
    String str = "";
    for (int i=0; i<3; i++) {
      for (int j=0; j<3; j++) {
        str+=(board[i][j].getValue()+" | ");
      }
      str+="\n";
    }
    str+=("\n");
    return str;
  }
}

