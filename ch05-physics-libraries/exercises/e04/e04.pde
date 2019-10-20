Box2DWorld world;
ArrayList<WeirdBox> boxes;

void setup() {
  size(400,400);
  world = new Box2DWorld();
  boxes = new ArrayList<WeirdBox>();
}

void draw() {
  if (mousePressed)
    boxes.add(new WeirdBox(mouseX,mouseY));
    
  background(255);
  for (WeirdBox b: boxes)
    b.display();
    
  world.step();
}
