class Node {

  boolean called;
  boolean callNextFrame;

  Node() {
    called = false;
    callNextFrame = false;
  }

  void go() {
    if (callNextFrame) {
      for (int i=0; i<numBranches/*int(random(maxBranches))+1*/; i++) {
        int k = (int)(random(numNodes));
        if (!L[k].called) {
          L[k].called = true;
          L[k].callNextFrame = true;
        }
      }
      callNextFrame = false;
    }
  }
}

