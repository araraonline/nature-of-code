Box2DWorld world;
Surface surface;
Car car;

void setup() {
  size(200,200);
  world = new Box2DWorld();
  surface = new Surface();
  car = new Car();
}

void draw() {
  background(255);
  surface.display();
  car.display();
  
  world.step();
}
