Box2DWorld world;
ArrayList<Box> boxes;
Surface surface;

void setup() {
  size(400,400);
  world = new Box2DWorld();
  boxes = new ArrayList<Box>();
  surface = new Surface();
}

void draw() {
  if (mousePressed)
    boxes.add(new Box(mouseX,mouseY));
  
  background(255);
  surface.display();
  for (Box b: boxes)
    b.display();
  
  world.step();
}
