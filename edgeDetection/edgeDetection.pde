PImage img;

void setup(){
  size(453,503);
  img = loadImage("smile.jpg");
  image(img,0,0);
  
  loadPixels();
  for(int x=0; x<img.width; x++){
    for(int y=0; y<img.height; y++){
      
    }
  }
}

//0 = red, 1=green, 2=blue
float UDSum(int c){
  //float k;
  float tl = 1;
  float t = 2;
  float tr =1;
  float bl = -1;
  float b = -2;
  float br = -1;
  if(c==0){
    tl *= cols[0][0];
    t *= cols[1][0];
    tr *= cols[2][0];
    bl *= cols[6][0];
    b *= cols[7][0];
    br *= cols[8][0];
  }
  if(c==1){
    //k = green(get(x,y));
    
    tl *= cols[0][1];
    t *= cols[1][1];
    tr *= cols[2][1];
    bl *= cols[6][1];
    b *= cols[7][1];
    br *= cols[8][1];
  }
  if(c==2){
    //k = blue(get(x,y,));
    
    tl *= cols[0][2];
    t *= cols[1][2];
    tr *= cols[2][2];
    bl *= cols[6][2];
    b *= cols[7][2];
    br *= cols[8][2];
  }
  return tl+t+tr+bl+b+br; 
}

//0 = red, 1=green, 2=blue
float LRSum(int c){
  //float k;
  float tl = 1;
  float l = 2;
  float bl =1;
  float tr = -1;
  float r = -2;
  float br = -1;
  if(c==0){
    tl *= cols[0][0];
    l *= cols[3][0];
    bl *= cols[6][0];
    tr *= cols[2][0];
    r *= cols[5][0];
    br *= cols[8][0];
  }
  if(c==1){
    //k = green(get(x,y));
    
    tl *= cols[0][1];
    l *= cols[3][1];
    bl *= cols[6][1];
    tr *= cols[2][1];
    r *= cols[5][1];
    br *= cols[8][1];
  }
  if(c==2){
    //k = blue(get(x,y,));
    
    tl *= cols[0][2];
    l *= cols[3][2];
    bl *= cols[6][2];
    tr *= cols[2][2];
    r *= cols[5][2];
    br *= cols[8][2];
  }
  return tl+l+bl+tr+r+br; 
}

