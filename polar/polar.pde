
ArrayList<Point> points;

void setup() {
  size(640, 300);
  fill(150);
  background(150, 150, 150);
  points = new ArrayList<Point>();
  //points.add(new Point(5,0));
}

void draw() {
  clear();
  background(255);
  for (Point p : points) {
    p.draw();
  }
}

