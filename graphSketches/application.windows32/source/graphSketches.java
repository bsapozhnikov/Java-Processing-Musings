import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class graphSketches extends PApplet {


int r = 20;
int s = 50;
int d = PApplet.parseInt(s*sqrt(2));
float sx,sy,fx,fy;
int textColor = color(255,0,0);

public void setup(){
  size(275,275);
  background(255);
  stroke(0);
  fill(255,255,0);
  textAlign(CENTER,CENTER);
  textSize(20);
  noLoop();
  
  /*
//  ellipse(100,60,60,60);
  ellipse(100,60,2*r,2*r);
  fill(textColor);
  text("A",100,60);
  fill(150);
  
  float n = r*cos(radians(45));
  sx = 100 + n;
  sy = 60  + n;
  fx = sx+s;
  fy = sy+s;
  line(sx,sy,fx,fy);
  
  ellipse(fx+n,fy+n,2*r,2*r);
  fill(textColor);  
  text("C",fx+n,fy+n);
  fill(150);
  
//  
//  sy = fy+(2*n);
//  fx = sx-s;
//  fy = sy-s;
//  
  line(fx,fy+(2*n),fx-s,fy+(2*n)+s);
  
  
  sx = sx-(2*n);
  fx = sx-s;
//  fy = sy-s;
  line(sx,sy,fx,fy);
  
  ellipse(fx-n,fy+n,2*r,2*r);
  fill(textColor);  
  text("B",fx-n,fy+n);
  fill(150);
  */
  
  sx = 100;
  sy = 60;
  int ax = PApplet.parseInt(sx);
  int ay = PApplet.parseInt(sy);
  int bx = ax-s;
  int by = ay+s;
  int cx = ax+s;
  int cy = ay+s;
  int dx = bx+s;
  int dy = by+s;
  int gx = cx+d;
  int gy = cy;
  int rx = dx+s;
  int ry = dy+s;
//  fx = 100-s;
//  fy = 60+s;
  line(ax,ay,bx,by);
  line(ax,ay,cx,cy);
  line(bx,by,dx,dy);
  line(cx,cy,dx,dy);
  line(cx,cy,gx,gy);
  line(dx,dy,rx,ry);
  
  ellipse(ax,ay,2*r,2*r);
  ellipse(bx,by,2*r,2*r);
  ellipse(cx,cy,2*r,2*r);
  ellipse(dx,dy,2*r,2*r);
  ellipse(gx,gy,2*r,2*r);
  ellipse(rx,ry,2*r,2*r);
  
  fill(textColor);  
  text("A",ax,ay);  
  text("B",bx,by);  
  text("C",cx,cy);  
  text("D",dx,dy);  
  text("G",gx,gy);  
  text("R",rx,ry);
  fill(150);
  
}

public void draw(){
  
}

public void mouseClicked(){
  println("("+mouseX+","+mouseY+")");
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "graphSketches" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
