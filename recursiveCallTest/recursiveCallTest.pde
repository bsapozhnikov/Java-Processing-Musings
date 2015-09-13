Node[] L;
int numNodes = 100000;
int numBranches = 3;
int maxBranches = numBranches*2-1; //for random branch #
int numInit = 1;

float curX;
float Xincrement = 20;

int sum = 0; //for repeated testing
int numTests = 0;

void setup() {
  frameRate(80);
  size(500,500);
  background(255);
  noStroke();
  fill(255, 0, 0);
  curX = 0.0;
  L = new Node[numNodes];
  for(int i=0; i<numNodes; i++){
    L[i] = new Node();
  }
  for (int i=0; i<numInit; i++) {
    L[i].called = true;
    L[i].callNextFrame = true;
  }
}

void draw() {
  for (int i=0; i<numNodes; i++) {
    L[i].go();
  }
  //println(countCalled());
  float y = height - countCalled()/(1.0*numNodes/height);
  ellipse(curX, y, 2, 2);
  curX+=Xincrement;
  if(curX>width){
    sum+=countCalled();
    numTests++;
    println("sum: "+sum+"\tnumTests: "+numTests);
    println(1.0*sum/numTests);
    setup();
  }
}

int countCalled() {
  int ans = 0;
  for (int i=0; i<numNodes; i++) {
    if (L[i].called) {
      ans++;
    }
  }
  return ans;
}

