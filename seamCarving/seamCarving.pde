PImage cur;
Node[][] en;
ArrayList<Node> safe = new ArrayList<Node>();
int spec = 2550000;

float[][] EDGE_KERNEL = { 
  {
    -1, -1, -1
  }
  , 
  {
    -1, 8, -1
  }
  , 
  {
    -1, -1, -1
  }
};

float[][] BLUR_KERNEL = { 
  {
    1.0/9, 1.0/9, 1.0/9
  }
  , 
  {
    1.0/9, 1.0/9, 1.0/9
  }
  , 
  {
    1.0/9, 1.0/9, 1.0/9
  }
};

float[][] H_SOBEL = { 
  {
    -1, 0, 1
  }
  , 
  {
    -2, 0, 2
  }
  , 
  {
    -1, 0, 1
  }
};

float[][] V_SOBEL = { 
  { 
    1, 2, 1
  }
  , 
  { 
    0, 0, 0
  }
  , 
  {
    -1, -2, -1
  }
};

float[][] GAUSSIAN_KERNEL = { 
  {
    1, 4, 7, 4, 1
  }
  , 
  {
    4, 16, 26, 16, 4
  }
  , 
  {
    7, 26, 41, 26, 7
  }
  , 
  {
    4, 16, 26, 16, 4
  }
  , 
  {
    1, 4, 7, 4, 1
  }
  ,
};

float[][] sum_normalize(float[][] m) {
  float factor = 0;
  float[][] out = new float[m.length][m[0].length];

  for (int x = 0; x < m.length; x++)
    for (int y = 0; y < m[0].length; y++)
      factor += m[x][y];

  for (int x = 0; x < m.length; x++)
    for (int y = 0; y < m[0].length; y++)
      out[x][y] = m[x][y] / factor;
  return out;
}

void setup() {
  GAUSSIAN_KERNEL = sum_normalize(GAUSSIAN_KERNEL);
  //String url = "http://www.jeffgreenhouse.com/wp-content/uploads/media-pipes-544.jpg";
  String url = "http://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/Valve_original_%281%29.PNG/300px-Valve_original_%281%29.PNG";
  // Load image from a web server
  //PImage webImg = loadImage(url, "PNG");
  PImage webImg = loadImage("photo3.jpg");
  cur = webImg;
  size(3*webImg.width, webImg.height);
  image(webImg, 0, 0);
  PImage blurred = conv(BLUR_KERNEL, webImg);
  //  blurred = conv(BLUR_KERNEL, blurred);
  //  blurred = conv(BLUR_KERNEL, blurred);
  PImage gauss_blurred = conv(GAUSSIAN_KERNEL, webImg);

  /*
  PImage edged = conv(EDGE_KERNEL, webImg);
   PImage blur_edged = conv(EDGE_KERNEL, blurred);
   PImage gauss_blur_edged = conv(EDGE_KERNEL, gauss_blurred);
   */

  PImage edged = conv(H_SOBEL, V_SOBEL, webImg);
  PImage blur_edged = conv(H_SOBEL, V_SOBEL, blurred);
  PImage gauss_blur_edged = conv(H_SOBEL, V_SOBEL, gauss_blurred);

  edged.filter(GRAY);
  //edged.filter(THRESHOLD, .3);
  blur_edged.filter(GRAY);
  //blur_edged.filter(THRESHOLD, .3);
  gauss_blur_edged.filter(GRAY);
  //gauss_blur_edged.filter(THRESHOLD, .3);

  //  image(blurred, webImg.width, 0);
  //  image(gauss_blurred, webImg.width*2, 0);
  image(edged, webImg.width, 0);
  //  image(blur_edged, webImg.width, webImg.height);
  //  image(gauss_blur_edged, webImg.width*2, webImg.height);

  image(deleteC(webImg), webImg.width*2, 0);
  //println("width of the original image is "+webImg.width);
}
void draw() {
}
void mouseClicked() {

  //println("clicked");

  //println(en[mouseY][mouseX-cur.width]);
}
void mouseDragged() {
  //safe = new ArrayList<Node>();
  Node n = en[mouseY][mouseX];
  safe.add(n);
  //addNeighbors(n);
/*
  addNeighbors(en[mouseY-1][mouseX-1]);
  addNeighbors(en[mouseY-1][mouseX+1]);
  addNeighbors(en[mouseY+1][mouseX-1]);
  addNeighbors(en[mouseY+1][mouseX+1]);
  addNeighbors(en[mouseY][mouseX-1]);
  addNeighbors(en[mouseY-1][mouseX]);
  addNeighbors(en[mouseY][mouseX+1]);
  addNeighbors(en[mouseY+1][mouseX]);
*/
  for (Node d : safe) {
    set(d.getX(), d.getY(), color(255, 0, 0)); 
    d.markForDeath();
  }
}

void addNeighbors(Node n) {
  int y = n.getY(); 
  int x = n.getX(); 
  if (!safe.contains(en[y-1][x-1])) {
    safe.add(en[y-1][x-1]);
  }
  if (!safe.contains(en[y-1][x+1])) {
    safe.add(en[y-1][x+1]);
  }
  if (!safe.contains(en[y+1][x-1])) {
    safe.add(en[y+1][x-1]);
  }
  if (!safe.contains(en[y+1][x+1])) {
    safe.add(en[y+1][x+1]);
  }
  if (!safe.contains(en[y][x-1])) {
    safe.add(en[y][x-1]);
  }
  if (!safe.contains(en[y-1][x])) {
    safe.add(en[y-1][x]);
  }
  if (!safe.contains(en[y][x+1])) {
    safe.add(en[y][x+1]);
  }
  if (!safe.contains(en[y+1][x])) {
    safe.add(en[y+1][x]);
  }
}

void keyPressed() {
  println(keyCode); 
  PImage edged;
  switch(keyCode) {
  case ENTER : 
    println("deleting");
    background(128); 
    cur = deleteC(cur); 
    image(cur, 0, 0); 
    edged = conv(H_SOBEL, V_SOBEL, cur); 
    edged.filter(GRAY); 
    image(edged, cur.width, 0); 
    image(deleteC(cur), cur.width*2, 0); 
    break;
  case 65:
    println("adding");
    background(128);
    cur = addC(cur);
    image(cur,0,0);
    edged = conv(H_SOBEL, V_SOBEL, cur); 
    edged.filter(GRAY); 
    image(edged, cur.width, 0); 
    image(addC(cur), cur.width*2, 0); 
    break;
  case SHIFT:
    spec*=-1;
    println(spec);
  }
  cur.save(savePath("result.jpg"));
}
PImage deleteC(PImage img) {
  PImage out = new PImage(img.width-1, img.height); 

  //setupNodes
  PImage edgeP = conv(H_SOBEL, V_SOBEL, img); 
  edgeP.filter(GRAY); 
  color[][] edged = myPImageToMatrix(edgeP); 
  //println(edgeP.length);
  en = new Node[edged.length][edged[0].length]; 
  for (int r=0; r<en.length; r++) {
    for (int c=0; c<en[0].length; c++) {
      en[r][c] = new Node(c, r, edged[r][c]); 
      //print(en[r][c].getValue() + " ");
    }
    //println("");
  }

  //calculate values

  for (Node d : safe) {
    int x = d.getX();
    int y = d.getY();
    //set(x, y, color(255, 0, 0)); 
    en[y][x].markForDeath();
    if (x==227 && y==126) {
      println("adding to safe: center of eye - " + en[y][x]);
    }
  }

  //borders get high values
  for (int c=0; c<en[0].length; c++) {
    en[0][c].setValue(255); 
    en[en.length-1][c].setValue(255); 
    en[en.length-1][c].setParent(en[en.length-2][c]);
    if (c==227 && en.length-1==126) {
      println("making border 255: " + en[126][227]);
    }
  }

  for (int r=1; r<en.length; r++) {
    en[r][0].setValue(255*(r+1)); 
    en[r][0].setParent(en[r-1][0]); 
    en[r][en[0].length-1].setValue(255*(r+1)); 
    en[r][en[0].length-1].setParent(en[r-1][en[0].length-1]);
    if (en[0].length-1==227 && en.length-1==126) {
      println("making border 255: " + en[126][227]);
    } 
    for (int c=1; c<en[0].length-1; c++) {
      if (en[r][c].mustDie()) {
        set(c, r, color(255, 0, 0));
        en[r][c].setValue(spec);
      }
      if (c==227 && r==126) {
        println("2center of eye - " + en[r][c]);
      }
      Node tl, t, tr; 
      tl = null; 
      tr = null; 
      if (c-1>0) {
        tl = en[r-1][c-1];
      }
      t = en[r-1][c]; 
      if (c+1<en[0].length) {
        tr = en[r-1][c+1];
      }
      Node n = en[r][c]; 
      if (c==227 && r==126) {
        println("center of eye - " + n);
      }
      float oldV = n.getValue(); 
      n.setValue(t.getValue()+oldV); 
      n.setParent(t); 
      if (tl!=null && tl.getValue()+oldV<n.getValue()) {
        n.setValue(tl.getValue()+oldV); 
        n.setParent(tl); 
        //println("switching to TL");
      }
      if (tr!=null && tr.getValue()+oldV<n.getValue()) {
        n.setValue(tr.getValue()+oldV); 
        n.setParent(tr); 
        //println("switching to TR");
      }
      //println("the node is " + n + "and the parent is " + n.getParent());
    }
  }
  /*
  for(int c=0; c<en[0].length; c++){
   en[0][c].setValue(255);
   en[en.length-1][c].setValue(255);
   en[en.length-1][c].setParent(en[en.length-2][c]);
   }
   */
  /*
  //for testing, print every node's value
   for(int r=0; r<en.length; r++){
   for(int c=0; c<en[0].length; c++){
   print(en[r][c].getValue()+" ");
   }
   print("\n");
   }
   */

  //find bottom node with best path
  int r = en.length-1; 
  Node b = en[r][1]; 
  for (int i=2; i<en[0].length-1; i++) {
    if (en[r][i].getValue()<b.getValue()) {
      b = en[r][i];
    }
  }

  //println(b.getParent());
  //display best path
  ArrayList<Node> path = new ArrayList<Node>(); 
  Node tmp = b.getParent(); 
  while (tmp!=null) {

    /*
    //testing
     int x = b.getX();
     int y = b.getY();
     Node tl, t, tr;
     tl = null;
     tr = null;
     if (x-1>0) {
     tl = en[y-1][x-1];
     }
     t = en[y-1][x];
     if (x+1<en[0].length) {
     tr = en[y-1][x+1];
     }
     
     if(tmp==tl){
     println("TL");
     }
     else if(tmp==t){
     println("T");
     }
     else if(tmp==tr){
     println("TR");
     }
     else{
     println("Uh-oh");
     }
     //
     */
    //println(b+"\t"+"tmp: "+tmp);
    set(img.width+b.getX(), b.getY(), color(255, 0, 0)); 
    //println(b);
    path.add(b); 
    b=tmp; 
    tmp=tmp.getParent();
  }
  //println(b+"\t"+"tmp: "+tmp);
  set(img.width+b.getX(), b.getY(), color(255, 0, 0)); 
  path.add(b); 

  //copy over pixels that aren't in path
  //out.loadPixels();
  //println(en.length);
  for (int row = 0; row < en.length; row++) {
    int dc=0; 
here : 
    for (int col = 0; col < en[0].length-1; col++) {
      if (path.contains(en[row][col])) {
        dc=1; 
        continue here;
      }
      out.set(col-dc, row, img.get(col, row)); 
      //out.set(row,col-dc, img.get(row,col));
    }
  }
  //out.updatePixels();
  //println("img size: ("+img.width+","+img.height+")");

  safe = new ArrayList<Node>();

  return out;
}

PImage addC(PImage img) {
  PImage out = new PImage(img.width+1, img.height); 

  //setupNodes
  PImage edgeP = conv(H_SOBEL, V_SOBEL, img); 
  edgeP.filter(GRAY); 
  color[][] edged = myPImageToMatrix(edgeP); 
  //println(edgeP.length);
  en = new Node[edged.length][edged[0].length]; 
  for (int r=0; r<en.length; r++) {
    for (int c=0; c<en[0].length; c++) {
      en[r][c] = new Node(c, r, edged[r][c]); 
      //print(en[r][c].getValue() + " ");
    }
    //println("");
  }

  //calculate values

  for (Node d : safe) {
    int x = d.getX();
    int y = d.getY();
    //set(x, y, color(255, 0, 0)); 
    en[y][x].markForDeath();
    if (x==227 && y==126) {
      println("adding to safe: center of eye - " + en[y][x]);
    }
  }

  //borders get high values
  for (int c=0; c<en[0].length; c++) {
    en[0][c].setValue(255); 
    en[en.length-1][c].setValue(255); 
    en[en.length-1][c].setParent(en[en.length-2][c]);
    if (c==227 && en.length-1==126) {
      println("making border 255: " + en[126][227]);
    }
  }

  for (int r=1; r<en.length; r++) {
    en[r][0].setValue(255*(r+1)); 
    en[r][0].setParent(en[r-1][0]); 
    en[r][en[0].length-1].setValue(255*(r+1)); 
    en[r][en[0].length-1].setParent(en[r-1][en[0].length-1]);
    if (en[0].length-1==227 && en.length-1==126) {
      println("making border 255: " + en[126][227]);
    } 
    for (int c=1; c<en[0].length-1; c++) {
      if (en[r][c].mustDie()) {
        set(c, r, color(255, 0, 0));
        en[r][c].setValue(spec);
      }
      if (c==227 && r==126) {
        println("2center of eye - " + en[r][c]);
      }
      Node tl, t, tr; 
      tl = null; 
      tr = null; 
      if (c-1>0) {
        tl = en[r-1][c-1];
      }
      t = en[r-1][c]; 
      if (c+1<en[0].length) {
        tr = en[r-1][c+1];
      }
      Node n = en[r][c]; 
      if (c==227 && r==126) {
        println("center of eye - " + n);
      }
      float oldV = n.getValue(); 
      n.setValue(t.getValue()+oldV); 
      n.setParent(t); 
      if (tl!=null && tl.getValue()+oldV<n.getValue()) {
        n.setValue(tl.getValue()+oldV); 
        n.setParent(tl); 
        //println("switching to TL");
      }
      if (tr!=null && tr.getValue()+oldV<n.getValue()) {
        n.setValue(tr.getValue()+oldV); 
        n.setParent(tr); 
        //println("switching to TR");
      }
      //println("the node is " + n + "and the parent is " + n.getParent());
    }
  }
  /*
  for(int c=0; c<en[0].length; c++){
   en[0][c].setValue(255);
   en[en.length-1][c].setValue(255);
   en[en.length-1][c].setParent(en[en.length-2][c]);
   }
   */
  /*
  //for testing, print every node's value
   for(int r=0; r<en.length; r++){
   for(int c=0; c<en[0].length; c++){
   print(en[r][c].getValue()+" ");
   }
   print("\n");
   }
   */

  //find bottom node with best path
  int r = en.length-1; 
  Node b = en[r][1]; 
  for (int i=2; i<en[0].length-1; i++) {
    if (en[r][i].getValue()<b.getValue()) {
      b = en[r][i];
    }
  }

  //println(b.getParent());
  //display best path
  ArrayList<Node> path = new ArrayList<Node>(); 
  Node tmp = b.getParent(); 
  while (tmp!=null) {

    /*
    //testing
     int x = b.getX();
     int y = b.getY();
     Node tl, t, tr;
     tl = null;
     tr = null;
     if (x-1>0) {
     tl = en[y-1][x-1];
     }
     t = en[y-1][x];
     if (x+1<en[0].length) {
     tr = en[y-1][x+1];
     }
     
     if(tmp==tl){
     println("TL");
     }
     else if(tmp==t){
     println("T");
     }
     else if(tmp==tr){
     println("TR");
     }
     else{
     println("Uh-oh");
     }
     //
     */
    //println(b+"\t"+"tmp: "+tmp);
    set(img.width+b.getX(), b.getY(), color(255, 0, 0)); 
    //println(b);
    path.add(b); 
    b=tmp; 
    tmp=tmp.getParent();
  }
  //println(b+"\t"+"tmp: "+tmp);
  set(img.width+b.getX(), b.getY(), color(255, 0, 0)); 
  path.add(b); 

  //copy over pixels (those that are in path twice)
  //out.loadPixels();
  //println(en.length);
  for (int row = 0; row < en.length; row++) {
    int dc=0; 
here : 
    for (int col = 0; col < en[0].length-1; col++) {
      if (path.contains(en[row][col])) {
        out.set(col+dc, row, img.get(col, row)); 
        dc=1; 
        //continue here;
      }
      out.set(col+dc, row, img.get(col, row)); 
      //out.set(row,col-dc, img.get(row,col));
    }
  }
  //out.updatePixels();
  //println("img size: ("+img.width+","+img.height+")");

  safe = new ArrayList<Node>();

  return out;
}

int value(color c) {
  return (int) ((red(c)+blue(c)+green(c)) / 3);
}

//Convolves two matrices on the same img and combines results.
PImage conv(float[][] h_matrix, float[][] v_matrix, PImage img) {
  color[][] in = PImageToMatrix(img); 
  color[][] h_out = conv(h_matrix, in); 
  color[][] out = conv(v_matrix, in); 
  for (int x = 0; x < in.length; x++)
    for (int y = 0; y < in[0].length; y++) {
      color hc = h_out[x][y]; 
      color vc = out[x][y]; 
      out[x][y] = color(sqrt(sq(red(hc)) + sq(red(vc))), 
      sqrt(sq(green(hc)) + sq(green(vc))), 
      sqrt(sq(blue(hc)) + sq(blue(vc))) );
    }
  return matrixToPImage(out);
}

PImage matrixToPImage(color[][] matrix) {
  int w = matrix.length; 
  int h = matrix[0].length; 
  PImage out = new PImage(w, h); 
  out.loadPixels(); 
  for (int x = 0; x < w; x++)
    for (int y = 0; y < h; y++) {
      out.pixels[x + y*w] = matrix[x][y];
    }
  out.updatePixels(); 
  return out;
}

color[][] myPImageToMatrix(PImage img) {
  color[][] out = new color[img.height][img.width]; 
  img.loadPixels(); 
  for (int r=0; r<out.length; r++) {
    for (int c=0; c<out[0].length; c++) {
      out[r][c] = img.pixels[c+r*img.width];
    }
  }
  return out;
}

color[][] PImageToMatrix(PImage img) {
  color[][] out = new color[img.width][img.height]; 
  img.loadPixels(); 
  for (int x = 0; x < img.width; x++)
    for (int y = 0; y < img.height; y++) {
      out[x][y] = img.pixels[x + y*img.width];
    }
  return out;
}

PImage conv(float[][] matrix, PImage img) {
  return matrixToPImage( conv(matrix, PImageToMatrix(img)) );
}

color[][] conv(float[][] matrix, color[][] img) {
  color[][] out = new color[img.length][img[0].length]; 
  int xoff = matrix.length/2; 
  int yoff = matrix[0].length/2; 
  for (int x = xoff; x < img.length - xoff; x++)
    for (int y = yoff; y < img[0].length - yoff; y++) {
      out[x][y] = pointconv(x, y, matrix, img);
    }
  //border
  for (int y = 0; y < img[0].length; y++) {
    for (int x = 0; x < xoff; x++)
      out[x][y] = img[x][y]; 
    for (int x = img.length - xoff; x < img.length; x++)
      out[x][y] = img[x][y];
  }
  for (int x = 0; x < img.length; x++) {
    for (int y = 0; y < yoff; y++)
      out[x][y] = img[x][y]; 
    for (int y = img[0].length - yoff; y < img[0].length; y++)
      out[x][y] = img[x][y];
  }
  //border
  return out;
}

//Applies 'matrix' to the designated part of the color[][] array.
color pointconv(int x, int y, float[][] matrix, color[][] img) {
  int xoff = matrix.length/2; 
  int yoff = matrix[0].length/2; 
  float r = 0.0; 
  float g = 0.0; 
  float b = 0.0; 
  for (int i = 0; i < matrix.length; i++)
    for (int j = 0; j < matrix[0].length; j++) {
      color c = img[x+i-xoff][y+j-yoff]; 
      //bitshifting is faster than red/green/blue
      /*  r+= matrix[i][j] * red(c);
       g+= matrix[i][j] * green(c);
       b+= matrix[i][j] * blue(c);  */
      r+= matrix[i][j] * ((c >> 16) & 0xFF); 
      g+= matrix[i][j] * ((c >> 8) & 0xFF); 
      b+= matrix[i][j] * (c & 0xFF);
    }
  return color(r, g, b);
}

color[][] colorMatPlus(color[][] A, color[][] B) {
  if (A.length != B.length || A[0].length != B[0].length)
    return null; 
  color[][] C = new color[A.length][A[0].length]; 
  for (int x = 0; x < C.length; x++)
    for (int y = 0; y < C[0].length; y++) {
      color cA = A[x][y]; 
      color cB = B[x][y]; 
      int rA = (cA >> 16) & 0xFF; 
      int rB = (cB >> 16) & 0xFF; 
      int gA = (cA >> 8) & 0xFF; 
      int gB = (cB >> 8) & 0xFF; 
      int bA = cA & 0xFF; 
      int bB = cB & 0xFF; 
      C[x][y] = color(rA+rB, gA+gB, bA+bB);
    }
  return C;
}

