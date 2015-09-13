class SuperTTTBoard {

  TTTBoard superBoard;
  TTTBoard[][] subBoards;

  public SuperTTTBoard() {
    superBoard = new TTTBoard();
    subBoards = new TTTBoard[3][3];
    for (int r=0; r<3; r++) {
      for (int c=0; c<3; c++) {
        subBoards[r][c] = new TTTBoard(c*s*3, r*s*3);
      }
    }
    
    for (int row=0; row<3; row++) {
      for (int col=0; col<3; col++) {
        subBoards[row][col].update();
      }
    }
  }

  void mouseClicked(float x, float y) {
    clear();
    background(255);
    int r = int(y/(3*s));
    int c = int(x/(3*s));
    println("clicked ("+x+","+y+")"); 
    println("s="+s);
    println("clicked board ("+c+","+r+")"); 
    TTTBoard b = subBoards[r][c];
    b.mouseClicked(x, y);
    
    for (int row=0; row<3; row++) {
      for (int col=0; col<3; col++) {
        subBoards[row][col].update();
      }
    }
    
    for (int row=0; row<3; row++) {
      for (int col=0; col<3; col++) {
        superBoard.override(row,col,subBoards[row][col].result());
      }
    }
    
    /*
    for (int i=0; i<3; i++) {
      for (int j=0; j<3; j++) {
        print(subBoards[i][j].result()+" | ");
      }
      println("");
    }
    println("");
    */
    println(superBoard);
  }
}

