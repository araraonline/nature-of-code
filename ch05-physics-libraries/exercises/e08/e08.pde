Box2DWorld world;
Box box;
MouseSpring spring;

void setup() {
  size(400,400);
  
  world = new Box2DWorld();
  box = new Box();
  spring = new MouseSpring(box);
  spring.attachToBox();
}

void draw() {
  spring.updateTarget();
  
  background(255);
  box.display();
  spring.display();
  
  world.step();
}
