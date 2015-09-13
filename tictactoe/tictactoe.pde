//SuperTTTBoard b; //Super TicTacToe
TTTBoard b; //Regular TicTacToe
color textColor = color(255, 0, 0);
int s;


void setup() {
  size(300, 300);
  textAlign(CENTER, CENTER);
  textSize(16);
  s = height/3;
//  b = new SuperTTTBoard(); //Super TicTacToe
  b = new TTTBoard(); //Regular TicTacToe
}

void draw() {
}

void mouseClicked() {
  b.mouseClicked(mouseX, mouseY);
}

