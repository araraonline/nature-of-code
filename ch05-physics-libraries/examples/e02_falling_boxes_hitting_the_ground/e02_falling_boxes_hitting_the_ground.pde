Box2DWorld world;
ArrayList<Box> boxes;
Boundary boundary;

void setup() {
  size(400,400);
  world = new Box2DWorld();
  boxes = new ArrayList<Box>();
  boundary = new Boundary(0.5*width,0.8*height,0.5*width,10);
}

void draw() {
  if (mousePressed)
    boxes.add(new Box(mouseX,mouseY));
  
  background(255);
  for (Box b: boxes)
    b.display();
  boundary.display();
  
  world.step();
}
