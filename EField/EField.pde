ArrayList<Charge> charges;
float conversionFactor=3200;
float k = 8.99*pow(10, 9)/conversionFactor/conversionFactor;
int w=300;
int h=300;
float testX;
float testY;
boolean setup;
float q;

void setup() {
  size(w, h);
  charges = new ArrayList<Charge>(); 
  testX=0;
  testY=0;
  setup=true;
  q=1;
}

PVector EField(float x, float y) {
  PVector net = new PVector(0, 0);
  for (Charge c : charges) {
    PVector field = c.getEField(x,y);
    if(field.mag()==0){
      return field;
    }
    net.add(field);
  }
  return net;
}

void draw() {
  if (setup) {
    background(255);
    for (int x=0; x<w; x+=50) {
      for (int y=0; y<h; y+=50) {
        PVector net = new PVector(0, 0);
        for (Charge c : charges) {
          c.draw();
          noFill();
          stroke(0, 0, 255);
          PVector field = c.getEField(x, y);
          net.add(field);
        }
        line(x, y, x+net.x, y+net.y);
      }
    }
  } else {
    PVector testE = EField(testX, testY);
    while (testX>0&&testX<w&&testY>0&&testY<h&&testE.mag()>0.01) {
      stroke(0);
      fill(0, 255, 0);
      ellipse(testX, testY, 1, 1);
      testE = EField(testX, testY);
      println("("+testE.x+","+testE.y+") ("+testE.mag()+","+degrees(testE.heading())+")");
      float dx = testE.x/testE.mag();
      float dy = testE.y/testE.mag();
      /*
      if(dx<.100 && dy<.100){
        testE.setMag(0);
      }
      */
      testX += dx;
      testY += dy;
    }
  }
}

void mouseClicked() {
  if (setup) {
    charges.add(new Charge(mouseX, mouseY, q));
    println("new charge added with charge "+q);
  } else {
    testX=mouseX;
    testY=mouseY;
  }
}

void keyPressed() {
  switch(key) {
  case 'r':
    setup();
    break;
  case ' ':
    setup=!setup;
    println("mode changed");
    break;
  case '-':
    q*=-1;
    println(q);
    break;
  default:
    try {
      q = int(key)-48;
      println(q);
    } 
    catch(Exception e) {
      println("NaN");
    }
    break;
  }
}

