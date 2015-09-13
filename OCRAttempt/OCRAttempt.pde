PImage img;
String txt;
PImage[] charKeys;
int curR = 0;
float thresh = 150;
int maxDiff = 8;
int sizeDiff = 20;

PImage brokenL, brokenTLeft, brokenTRight, brokenU, brokenF, brokenH;

//PImage testCrop;
float testGreen = 255.0/26;

void setup() {
  charKeys = new PImage[26];
  txt = "";
  img = loadImage("letters2.jpg");
  brokenL=loadImage("brokenL.jpg");
  brokenTLeft=loadImage("brokenTLeft.jpg");
  brokenTRight=loadImage("brokenTRight.jpg");
  brokenU=loadImage("brokenU.jpg");
  brokenF=loadImage("brokenF.jpg");
  brokenH=loadImage("brokenH.jpg");
  img.filter(GRAY);
  img.resize(1000, 0);
  size(img.width, img.height);
  image(img, 0, 0);

  //testCrop = crop(img, 5, 25, 100, 110);

  img.loadPixels();
  charKeysSetup();
  tint(255, 128);
  image(img, 0, 0);
  printKeys();
  tint(255, 255);
  img.updatePixels();

  findWords();
}

void charKeysSetup() {
  /*
  //testing
   for(int r=0; r<img.height; r++){
   if(emptyRow(img,r)){
   eraseRow(img,r);
   }
   println(emptyRow(img,r));
   }
   //end testing
   */
  //find top and bottom of key
  while (curR<img.height && emptyRow (img, curR)) {
    curR++;
  }
  int startR = curR;
  while (curR<img.height && !emptyRow (img, curR)) {
    curR++;
  }
  int endR = curR;

  //find left and right of each char, crop that char, and add it to charKeys
  int startC=0;
  int endC=0;
  boolean fixedL = false;
  boolean fixedTLeft = false;
  boolean fixedTRight = false;
  boolean fixedU = false;
  boolean fixedF = false;
  boolean fixedH = false;
  for (int i=0; i<charKeys.length; i++) {
    while (startC<img.width && emptyColSeg (img, startC, startR, endR)) {
      startC+=1;
    }
    endC = startC;
    //startC--;
    while (endC<img.width && !emptyColSeg (img, endC, startR, endR)) {
      endC+=1;
    }
    charKeys[i] = crop(img, startR, startC, endR, endC);
    println("crop " + i + " ("+startC+","+startR+","+endC+","+endR+")");
    startC = endC+1;


    //check for broken L
    //println(match(brokenL,charKeys[i]));
    if (i==6 && !fixedF && match(brokenF, charKeys[6])) {
      charKeys[5] = join(charKeys[5], charKeys[6]);
      fixedF = true;
      i--;
    }
    if (i==8 && !fixedH && match(brokenH, charKeys[7])) {
      charKeys[7] = join(charKeys[7], charKeys[8]);
      fixedH = true;
      i--;
    }
    if (i==12 && !fixedL && match(brokenL, charKeys[i])) {
      charKeys[11] = join(charKeys[11], charKeys[12]);
      fixedL = true;
      i--;
    }
    if (i==20 && !fixedTLeft && match(brokenTLeft, charKeys[19])) {
      charKeys[19] = join(charKeys[19], charKeys[20]);
      fixedTLeft = true;
      i--;
    }
    if (i==20 && fixedTLeft && !fixedTRight && match(brokenTRight, charKeys[20])) {
      charKeys[19] = join(charKeys[19], charKeys[20]);
      fixedTRight = true;
      i--;
    }
    if (i==21 && !fixedU && match(brokenU, charKeys[21])) {
      charKeys[20] = join(charKeys[20], charKeys[21]);
      fixedU = true;
      i--;
    }
  }
  //charKeys[7].save(savePath("data/brokenH.jpg"));
}

void findWords() {
  ArrayList<PImage> row = new ArrayList<PImage>();
  while (curR<img.height && emptyRow (img, curR)) {
    curR++;
  }
  int startR = curR;
  while (curR<img.height && !emptyRow (img, curR)) {
    curR++;
  }
  int endR = curR;
  line(0, startR, width, startR);
  line(0, endR, width, endR);

  int startC=0;
  int endC=0;
  boolean fixedL = false;
  boolean fixedTLeft = false;
  boolean fixedTRight = false;
  boolean fixedU = false;
  boolean fixedF = false;
  boolean fixedH = false;
  while (startC<img.width && endC<img.width) {
    while (emptyColSeg (img, startC, startR, endR)) {
      startC+=1;
    }
    endC = startC;
    //startC--;
    while (!emptyColSeg (img, endC, startR, endR)) {
      endC+=1;
    }
    PImage P = crop(img, startR, startC, endR, endC);
    row.add(P);
    //println("crop " + i + " ("+startC+","+startR+","+endC+","+endR+")");
    startC = endC+1;


    //check for broken L
    //println(match(brokenL,charKeys[i]));
    if (match(brokenF, P)) {
      row.remove(row.size()-1);
      row.set(row.size()-1, charKeys[5]);
    }
    if (match(brokenL, P)) {
      row.remove(row.size()-1);
      row.set(row.size()-1, charKeys[11]);
    }
    if (match(brokenTLeft, P)) {
      row.remove(row.size()-1);
      row.set(row.size()-1,join(row.get(row.size()-1),P));
    }
    if (match(brokenTRight, P)) {
      row.remove(row.size()-1);
      row.set(row.size()-1,join(row.get(row.size()-1),P));
    }
    /*
    if (match(brokenU, P)) {
      row.remove(row.size()-1);
      row.set(row.size()-1, join(row.get(row.size()-1), P));
    }
    */
    /*
    if(i==6 && !fixedF && match(brokenF,charKeys[6])){
     charKeys[5] = join(charKeys[5],charKeys[6]);
     fixedF = true;
     i--;
     }
     if(i==8 && !fixedH && match(brokenH,charKeys[7])){
     charKeys[7] = join(charKeys[7],charKeys[8]);
     fixedH = true;
     i--;
     }
     if(i==12 && !fixedL && match(brokenL,charKeys[i])){
     charKeys[11] = join(charKeys[11],charKeys[12]);
     fixedL = true;
     i--;
     }
     if(i==20 && !fixedTLeft && match(brokenTLeft,charKeys[19])){
     charKeys[19] = join(charKeys[19],charKeys[20]);
     fixedTLeft = true;
     i--;
     }
     if(i==20 && !fixedTRight && match(brokenTRight,charKeys[20])){
     charKeys[19] = join(charKeys[19],charKeys[20]);
     fixedTRight = true;
     i--;
     }
     if(i==21 && !fixedU && match(brokenU,charKeys[21])){
     charKeys[20] = join(charKeys[20],charKeys[21]);
     fixedU = true;
     i--;
     }*/
  }
  printRow(row);
}

//p2 will be resized to fit p1
boolean match(PImage p1, PImage p2) {
  p1.loadPixels();
  p2.loadPixels();
  if (abs(p1.pixels.length-p2.pixels.length)>sizeDiff) {
    return false;
  }
  p2.resize(p1.width, p1.height);
  int diff=0;
  for (int i=0; i<p1.width*p1.height; i++) {
    boolean b1 = isBlack(p1, i);
    boolean b2 = isBlack(p2, i);
    if (b1!=b2) {
      diff++;
    }
  }
  println(diff);
  return diff<maxDiff;
}

//p2 resized to match height of p1
PImage join(PImage p1, PImage p2) {
  p1.loadPixels();
  p2.loadPixels();
  p2.resize(0, p1.height);
  PImage ans = new PImage(p1.width+p2.width, p1.height+p2.height);
  ans.loadPixels();
  for (int r=0; r<p1.height; r++) {
    for (int c=0; c<p1.width; c++) {
      ans.pixels[r*ans.width+c] = p1.pixels[r*p1.width+c];
    }
  }
  for (int r=0; r<p2.height; r++) {
    for (int c=0; c<p2.width; c++) {
      ans.pixels[r*ans.width+c+p1.width] = p2.pixels[r*p2.width+c];
    }
  }
  ans.updatePixels();
  return ans;
}
boolean emptyRow(PImage img, int r) {
  for (int c=0; c<img.width; c++) {
    if (red(img.pixels[r*img.width+c])<thresh) {
      return false;
    }
  }
  return true;
}
boolean emptyColSeg(PImage img, int c, int startR, int endR) {
  int saveMe = 0;
  for (int r=startR; r<endR; r++) {
    if (isBlack(img, r, c)) {
      return false;
    } else if (c>0 && c<img.width-1 && isBlack(img, r, c-1) && isBlack(img, r, c+1)) {
      saveMe++;
    }
  } 
  return saveMe < 2;
}

boolean isBlack(PImage img, int r, int c) {
  return red(img.pixels[r*img.width+c])<thresh;
}
boolean isBlack(PImage img, int i) {
  return red(img.pixels[i])<thresh;
}

PImage crop(PImage img, int startR, int startC, int endR, int endC) {
  PImage cropped = new PImage(endC-startC+1, endR-startR+1);
  for (int r=0; r<cropped.height; r++) {
    for (int c=0; c<cropped.width; c++) {
      cropped.pixels[r*cropped.width+c] = img.pixels[(startR+r)*img.width+(startC+c)];
      loadPixels();
      pixels[(startR+r)*width+(startC+c)] = color(0, testGreen, 0);
      updatePixels();
    }
  }
  testGreen+=255.0/26;
  return cropped;
}

//for testing
void eraseRow(PImage img, int r) {
  for (int c=0; c<img.width; c++) {
    img.pixels[r*img.width+c] = color(0, 255, 0);
  }
}

void printKeys() {
  printKeys(0, 10, 200);
}
void printKeys(int i, int x, int y) {
  if (i>25) {
    return;
  }
  image(charKeys[i], x, y);
  printKeys(i+1, x+20, y+2);
}

void printRow(ArrayList<PImage> row) {
  printRow(row, 0, 10, 250);
}
void printRow(ArrayList<PImage> row, int i, int x, int y) {
  if (i>=row.size())return;
  image(row.get(i), x, y);
  printRow(row, i+1, x+20, y+2);
}

void draw() {
  //background(255);
  //image(img,0,0);
  //image(testCrop,mouseX,mouseY);
}

void mousePressed() {
  println(red(img.pixels[mouseY*img.width+mouseX]));
}

