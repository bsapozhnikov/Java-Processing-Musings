import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer shutter;
boolean curtains=false;
boolean space = false;
boolean edge =false;
boolean invert = false;
color bg = color(255);
int blobX, blobY;
color blobC;
color blob = color(0, 255, 0);
PImage img;
PImage copy;

int h;
int w;

boolean fakeNoLoop = false;
/**
 * Getting Started with Capture.
 * 
 * Reading and displaying an image from an attached Capture device. 
 */
double time= millis();
import processing.video.*;
int imgCount = 0;
Capture cam;
int thresh=10;

int[][] buffer;
ArrayList<Integer> table;
ArrayList<ArrayList<Integer>> blobs = new ArrayList<ArrayList<Integer>>(); 

void setup() {
  table = new ArrayList<Integer>();
  
  
  img = loadImage("test.png");
  
  h = img.height;
  w = img.width;
  size(w, h);
  buffer = new int[w][h];

  //size(283,424);
  
  copy = loadImage("test.png");
  image(img,0,0);
  String[] cameras = Capture.list();
  minim = new Minim(this); 

  if (cameras == null) {
    println("Failed to retrieve the list of available cameras, will try the default...");
    cam = new Capture(this, w, h);
  } 
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }  
    // The camera can be initialized directly using an element
    // from the array returned by list():
    cam = new Capture(this, cameras[0]);
    // Or, the settings can be defined based on the text in the list
    //cam = new Capture(this, w, h, "Built-in iSight", 30);

    // Start capturing the images from the camera
    cam.start();
    
  }
}
void draw() {
  if(fakeNoLoop){
    return;
  }
  color[]temp=new color[h*w];
  if (cam.available() == true) {
    cam.read();
  }

  //image(cam, 0, 0);
  if (edge) {

    loadPixels();
    float up ;
    float down;
    float left;
    float right ;
    int val;
    for (int y = 1; y < h - 1; y++) {
      for (int x= 1; x < w - 1; x++) {
        color wa= pixels[y*w+x];
        pixels[y*w+x]=color((int)(red(wa)+green(wa)+blue(wa)) / 3);
      }
    }
    for (int y = 1; y < h - 1; y++) {
      for (int x= 1; x < w - 1; x++) {
        up = red(pixels[(y*w)+(x-1)]);
        down = red(pixels[y*w+(x+1)]);
        left = red(pixels[((y-1)*w)+x]);
        right = red(pixels[((y+1)*w)+x]); 
        val=(int)sqrt(sq(left-right)+sq(up-down));
        if (val>thresh) {
          val=255;
        }
        if (invert) {
          val= 255-val;
        }

        temp[y*w+x]=color(val);
      }
    }
    for (int y = 1; y < h - 1; y++) {
      for (int x= 1; x < w - 1; x++) {
        pixels[y*w+x]=temp[y*w+x];
      }

      updatePixels();
    }
  }


  if (curtains) {
    image(loadImage("curtains.png"), 0, 0);
  }
  if (space) {
    image(loadImage("space.png"), 0, 0);
  }
  // The following does the same as the above image() line, but 
  // is faster when just drawing the image without any additional 
  // resizing, transformations, or tint.
  //set(0, 0, cam);


  //blob stuff
  //loadPixels();
  
  //first grayscale
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      //print("("+x+","+y+")\t");
      color src = get(x,y);
      float r = red(src);
      float g = green(src);
      float b = blue(src);
      int avg = (int)(r+g+b);
      avg/=3;
      set(x,y,color(avg));
      //print(r+" "+g+" "+b+"\t"+red(get(x,y))+" "+green(get(x,y))+" "+blue(get(x,y))+"\n");
    }
  }
  //updatePixels();
  fakeNoLoop = true;
  
  //loadPixels();
  int counter = 1;
  for (int x = 1; x<width-1; x++) {
    for (int y=1; y<height-1; y++) {
      color co = get(x, y);
      if (isFG(co)) {
        //kernel
        //print("("+x+","+y+") is in the foreground\t");
        color ac = get(x-1, y-1);
        color bc = get(x, y-1);
        color cc = get(x+1, y-1);
        color dc = get(x-1, y);

        int a = buffer[x-1][y-1];
        int b = buffer[x][y-1];
        int c = buffer[x+1][y-1];
        int d = buffer[x-1][y];
        if (a==b && b==c && c==d && a==0) {
          buffer[x][y] = counter;
          //print("("+x+","+y+") is set to " + buffer[x][y]+"\t");
          table.add(counter);
          counter++;
          //print("the new counter is " + counter+"\t");
        } else {
          int num=Integer.MAX_VALUE;
          if (a!=0) {
            num=a;
          }
          if (b!=0 && b<num) {
            num=b;
          }
          if (c!=0 && c<num) {
            num=c;
          }
          if (d!=0 && d<num) {
            num=d;
          }
          buffer[x][y]=num;
          if(buffer[x-1][y-1]!=0){//if (isFG(ac)) {
            table.set(buffer[x-1][y-1]-1,num);
            buffer[x-1][y-1] = num;
          }
          if(buffer[x][y-1]!=0){//if (isFG(bc)) {
            table.set(buffer[x][y-1]-1,num);
            buffer[x][y-1] = num;
          }
          if(buffer[x+1][y-1]!=0){//if (isFG(cc)){
            table.set(buffer[x+1][y-1]-1,num);
            buffer[x+1][y-1] = num;
          }
          if(buffer[x-1][y]!=0){//if (isFG(dc)) {
            table.set(buffer[x-1][y]-1,num);
            buffer[x-1][y] = num;
          }
        }
      }
      
    }
  }
  println(table.toString());
  println(counter);
  
  for (int x = 1; x<width-1; x++) {
    for (int y=1; y<height-1; y++) {
      int b = buffer[x][y];
      if(b!=0){
        table.set(b-1,recursion(b-1));
      }
    }
  }
  
  
  println(table.toString());
  println(counter);
  
  for (int x = 1; x<width-1; x++) {
    for (int y=1; y<height-1; y++) {
      //print(buffer[x][y]+" ");
      float c = 255.0*buffer[x][y]/counter;
      color col = color((int)c,0,0);
      set(x, y, col);
    }
    //print("\n");
  }
  //updatePixels();
  
}

void keyPressed() {
  println(keyCode);
  if (keyCode == 32) {
    imgCount++;
    shutter = minim.loadFile("shutter.mp3");
    shutter.play();
    saveFrame("line-"+imgCount+".jpg");
    String currentImg = "line-"+imgCount+".jpg";
    time= millis();
    while (millis () < time+1000) {
      image(loadImage(currentImg), 0, 0);
    }
  }
  if (keyCode == 38 ) {
    thresh--;
  }
  if (keyCode == 40 ) {
    thresh ++;
  }
  if (keyCode == 69) {
    edge=!edge;
    space=false;
    curtains=false;
  }
  if (keyCode == 73) {
    invert=!invert;
  }
  if (keyCode == 67) {
    curtains=!curtains;
    space=false;
  }
  if (keyCode == 83) {
    space=!space;
    curtains=false;
  }
  keyCode = 0;
}

void mousePressed() {
  int x = (int)mouseX;
  int y = (int)mouseY;
  loadPixels();
  println("("+x+","+y+")\t"+red(get(x,y))+" "+green(get(x,y))+" "+blue(get(x,y)));
  
  /*
  blobX = (int)mouseX;
  blobY = (int)mouseY;
  loadPixels();
  blobC = get(blobX, blobY);
  fill();
  updatePixels();
  //fill((int)mouseX, (int)mouseY);
  */
}

void fill() {
  fill(blobX, blobY);
}
void fill(int x, int y) {
  //loadPixels();
  if (get(x, y)==blob) {
    return;
  }
  if (abs(red(get(x, y))- red(blobC)) <thresh) {
    //set(x,y,blob);
    fill(x+1, y);
    fill(x-1, y);
    fill(x, y+1);
    fill(x, y-1);
    set(x, y, blob);
  }
}

boolean isBG(color c){
  return abs(red(c)-red(bg))<=thresh;
}
boolean isFG(color c){
  return !isBG(c);
}

int recursion(int i){
  if(i==0){
    return 1;
  }
  int v = table.get(i);
  if(i==v-1){
    return i;
  }
  else{
    return recursion(v-1);
  }
}

