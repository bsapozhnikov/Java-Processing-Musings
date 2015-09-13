class Box {

  int x, y, endX, endY, v;
  boolean mov = false;
  boolean needToDouble = false;
  Box executioner;
  boolean canJoin = true;

  public Box() {
    int a = (int)(random(w))*s;
    int b = (int)(random(h))*s;
    while (!setup (a, b)) {
      a = (int)(random(w))*s;
      b = (int)(random(h))*s;
    }
  }

  public Box(int x, int y) {
    while (!setup (x, y)) {
    }
  }

  boolean setup(int x, int y) {
    if (board[y/s][x/s]!=null) {
      return false;
    }
    board[y/s][x/s] = this;
    this.x = x;
    this.y = y;
    endX = x;
    endY = y;
    v = 2;
    return true;
  }

  void draw() {
    if (x!=endX) {
      x+=step*((endX-x)/abs(endX-x));
    } else if (y!=endY) {
      y+=step*((endY-y)/abs(endY-y));
    } else {
      if (mov) {
        moving--;
        mov = false;
        if(needToDouble){
          needToDouble = false;
        }
        if (moving==0) {
          println("i would make a new box now");
          new Box();
        }
        /*
        if(needToDouble){
         v*=2;
         needToDouble = false;
         }
         */
      }
      canJoin = true;
    }
    display();
  }

  boolean canMove(int dx, int dy) {
    //println("canMove("+dx+","+dy+")\t"+this);
    int dc = dx/s;
    int dr = dy/s;
    int c = endX/s+dc;
    int r = endY/s+dr;
    if (c<0 || c>=board[0].length || r<0 || r>=board.length) {
      return false;
    }
    Box b = board[endY/s+dr][endX/s+dc];
    return (b==null) || (b.v==v);
  }

  void move(int dx, int dy) {
    Box b = board[endY/s+dy/s][endX/s+dx/s];
    board[endY/s][endX/s] = null;
    endX = endX+dx;
    endY = endY+dy;
    if (b != null && canJoin) {
      //board[endY/s+dy/s][endX/s+dx/s] = null;
      if (board[endY/s][endX/s].mov) {
        moving--;
        board[endY/s][endX/s].mov = false;
      }
      println("joining\t"+this);
      v*=2;
      score+=v;
      needToDouble = true;
      b.executioner = this;
      deathRow.add(b);
      board[endY/s][endX/s] = this;
      canJoin = false;
      return;
    }
    board[endY/s][endX/s] = this;
    if (canMove(dx, dy)) {
      move(dx, dy);
    }
  }

  void display() {
    color c=color(50);
    //colors taken from http://www.ng-newsletter.com/posts/building-2048-in-angularjs.html
    switch(v) {
    case 2:
      c = color(238, 228, 218);
      break;
    case 4:
      c = color(234, 224, 200);
      break;
    case 8:
      c = color(245, 149, 99);
      break;
    case 16:
      c = color(51, 153, 255);
      break;
    case 32:
      c = color(255,163,51);
      break;
    case 64:
      c = color(206,240,48);
      break;
    case 128:
      c = color(232,216,206);
      break;
    case 256:
      c = color(153,3,3);
      break;
    case 512:
      c = color(107,165,222);
      break;
    case 1024:
      c = color(220,173,96);
      break;
    case 2048:
      c = color(182,0,34);
      break;
    }
    fill(c);
    rect(x, y, s, s);
    fill(100);
    if (v>4) {
      fill(240);
    }
    if (mov && needToDouble) {
      text(v/2, x+s/2, y+s/2);
    } else {
      text(v, x+s/2, y+s/2);
    }
  }

  String toString() {
    return "("+x+","+y+")\t("+endX+","+endY+")";
  }
}

