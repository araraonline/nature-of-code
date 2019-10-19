Box2DWorld world;
ArrayList<Box> boxes;

void setup() {
  size(400,200);
  world = new Box2DWorld();
  boxes = new ArrayList<Box>();
}

void draw() {
  if (mousePressed)
    boxes.add(new Box(mouseX,mouseY));
  
  background(255);
  for (Box b: boxes)
    b.display();
  
  world.step();
}
