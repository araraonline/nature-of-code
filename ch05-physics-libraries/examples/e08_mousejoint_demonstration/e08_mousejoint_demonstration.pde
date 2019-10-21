Box2DWorld world;
Box box;
MouseSpring spring;

void setup() {
  size(400,400);
  
  world = new Box2DWorld();
  box = new Box();
  spring = new MouseSpring(box);
}

void draw() {
  spring.updateTarget();
  
  background(255);
  box.display();
  spring.display();
  
  world.step();
}

void mousePressed() {
  if (box.containsPixelLocation(getMousePixelLocation()))
    spring.attachToBox();
}

void mouseReleased() {
  spring.detachFromBox();
}
