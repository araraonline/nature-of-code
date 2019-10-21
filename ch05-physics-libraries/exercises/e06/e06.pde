Box2DWorld world;
ArrayList<Box> boxes;
Bridge bridge;

float BOX_SIDE_MIN;
float BOX_SIDE_MAX;

float BRIDGE_HEIGHT;
int N_COMPONENTS;
float COMPONENT_RADIUS;
float JOINT_LENGTH;

void settings() {
  size(640,320);
  
  BRIDGE_HEIGHT = height / 2;
  
  N_COMPONENTS = 50;
  JOINT_LENGTH = width / (N_COMPONENTS - 1); // components would be in a straight line without gravity
  
  COMPONENT_RADIUS = 4;
  
  BOX_SIDE_MIN = 2 * (JOINT_LENGTH - 2 * COMPONENT_RADIUS);
  BOX_SIDE_MAX = 2* BOX_SIDE_MIN;
}

void setup() {  
  world = new Box2DWorld();
  boxes = new ArrayList<Box>();
  bridge = new Bridge();
}

void draw() {
  if (mousePressed)
    boxes.add(new Box(mouseX,mouseY));
  
  background(255);
  for (Box b: boxes)
    b.display();
  bridge.display();
    
  world.step();
}
