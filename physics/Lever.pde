class Lever {
  Ball b;
  //float a; // angle with horizontal
  float sx, sy, r;
  
  boolean done = false;
  float it;

  public Lever(Ball b, float centerX, float centerY) {
    this.b=b;
    sx = centerX;
    sy = centerY;
    r = dist(b.getX(), b.getY(), centerX, centerY);
  }

  void draw() {
    /*
    //r = dist(b.getX(),b.getY(),sx,sy);

    float vx = b.getVX();
    float vy = b.getVY();
    float v  = dist(0, 0, vx, vy);
    float dx = (b.getX()-sx);
    float dy = (sy-b.getY());
    float a  = atan(dx/dy);//(dy/dx);
    float av = atan(vy/vx);
    float newVX = v*sin(a);
    float newVY = v*cos(a);
    //b.setVX(b.getVY()*dy/dx);
    //    if(a2<a){
    //      newVX*=-1;
    //      newVY*=-1;
    //    }

    //    float a1 = g*sin(a);
    //    float a1x = a1 * cos(a);
    //    float a1y = a1 * sin(a); 
    //    float a2 = g*cos(a);
    //    float a2x = a2*sin(a);
    //    float a2y = -1*a2*cos(a)-g;
    //    float dax =  a1x+a2x;//a1x;//a1x+a2x;//newVX - vx;
    //    float day =  a1y+a2y+g;//a1y+a2y;//newVY - vy;
    //    b.setAX(dax);
    //    b.setAY(day);//day+g

    if (dy>0){
      a = PI - a;
    }
    float t = v*v/r+g*cos(a);//g*cos(a);
    
    if(!done){
      it = t;
      done = true;
    }
    
    float tx = t*sin(a);
    float ty = -1*t*cos(a);
    if (dy>0) {
      //println("reversed tension acceleration");
      tx*=1;
      ty*=1;
      tx = -1*t*sin(a);
      ty = -1*t*cos(a);
    } else {
      //println("");
    }
    //println(degrees(a));
    float dax = tx;
    float day = g+ty;
    */
    PVector grav = new PVector(0,1);
    grav.setMag(g);
    PVector tens = new PVector(sx-b.getX(),sy-b.getY());
    float theta = PVector.angleBetween(grav,tens);
    tens.setMag(-1*g*cos(theta));
    PVector net = PVector.add(grav,tens);
    float dax = net.x;
    float day = net.y;
        
    b.setAX(dax);
    b.setAY(day);
    
    PVector corr = new PVector(b.getX()-sx,b.getY()-sy);
    corr.setMag(r);
    b.x = sx+corr.x;
    b.y = sy+corr.y;

    //THIS IS WRONG
//    float err = abs(degrees(a-av));
//    println(err);
//    if (err > 3 && err < 177) {
//      b.setVX(0);
//      b.setVY(0);
//    }

    //gray line: lever
    fill(150);
    line(sx, sy, b.getX(), b.getY());
    stroke(255, 0, 153);
    //line(b.getX(), b.getY(), b.getX()+tx*1000, b.getY()+ty*1000);
    //purple line: ball's new acceleration
    line(b.getX(),b.getY(),b.getX()+dax*1000,b.getY()+day*1000);
    //blue line: tension
    stroke(0,0,255);
    line(b.getX(),b.getY(),b.getX()+tens.x*1000,b.getY()+tens.y*1000);
    noFill();
    //Green line: gravity
    stroke(0,255,0);
    line(b.getX(),b.getY(),b.getX()+grav.x*1000,b.getY()+grav.y*1000);
    //ellipse(b.getX(),b.getY(), it*2000, it*2000);
    //black circle: correct path
    stroke(0);
    noFill();
    ellipse(sx, sy, 2*r, 2*r);
  }
}

