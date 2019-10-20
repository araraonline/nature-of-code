Box2DWorld world;
ArrayList<Pair> pairs;
Boundary boundary;

void setup() {
  size(400,400);
  world = new Box2DWorld();
  pairs = new ArrayList<Pair>();
  boundary = new Boundary(0.5*width,0.8*height,0.5*width,10);
}

void draw() {
  if (mousePressed)
    pairs.add(new Pair(mouseX,mouseY));
  
  background(255);
  for (Pair p: pairs)
    p.display();
  boundary.display();
  
  world.step();
}
