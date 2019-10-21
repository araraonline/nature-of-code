Box2DWorld world;
Rain rain;
Windmill windmill;

void setup() {
  size(200,200);
  world = new Box2DWorld();
  rain = new Rain();
  windmill = new Windmill();
}

void draw() {
  if (mousePressed)
    rain.addDrop();
  
  background(255);
  windmill.display();
  rain.display();
  
  world.step();
}
