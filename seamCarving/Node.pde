class Node {

  Node parent;
  int x, y;
  float c;
  float value;
  boolean die;

  Node(int x, int y, color c) {
    this.x=x;
    this.y=y;
    this.c=red(c);
    value = red(c);
    if (x==227 && y==126) {
      println("creating node: "+this);
    }
    die = false;
  }

  int getX() {
    return x;
  }
  int getY() {
    return y;
  }
  float getC() {
    return c;
  }
  float getValue() {
    return value;
  }
  Node getParent() {
    return parent;
  }
  
  boolean mustDie(){
    return die;
  }

  void setParent(Node p) {
    parent = p;
  }
  void setValue(float v) {
    if (x==227 && y==126) {
      println("setting value from "+value+" to "+v+"\t"+this);
    }
    value = v;
  }

  void markForDeath(){
    die = true;
  }

  String toString() {
    return "("+x+","+y+"): "+value;
  }
}

