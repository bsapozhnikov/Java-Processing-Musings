/**
 * Load and Display 
 * 
 * Images can be loaded and displayed to the screen at their actual size
 * or any other size. 
 */
 
// The next line is needed if running in JavaScript Mode with Processing.js
/* @pjs preload="moonwalk.jpg"; */ 

PImage img;  // Declare variable "img" of type PImage

void setup() {
  size(640, 360);
  // The image file must be in the data folder of the current sketch 
  // to load successfully
  img = loadImage("moonwalk.jpg");  // Load the image into the program
  
  loadPixels();
  for (int i =0; i<(width*height); i++){
    pixels[i] = getAvg(pixels[i]);
  }
  updatePixels();
}

void draw() {
  // Displays the image at its actual size at point (0,0)
  image(img, 0, 0);
  // Displays the image at point (0, height/2) at half of its size
  image(img, 0, height/2, img.width/2, img.height/2);
  
  //replace each pixel with its grayscale equivalent
  loadPixels(); //start working with pixels
  for (int i =0; i<(width*height); i++){
    pixels[i] = getAvg(pixels[i]);
  }
  updatePixels(); //finish working with pixels
}

//turns a color into its grayscale equivalent by taking the average of the RBG values
color getAvg(color c){
  float avg = red(c)+green(c)+blue(c);
  avg/=3;
  return color(avg);
}
