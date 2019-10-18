ArrayList<Box> boxes;

void setup() {
  size(200,200);
  boxes = new ArrayList<Box>();
}

void draw() {
  if (mousePressed)
    boxes.add(new Box(mouseX,mouseY));
  
  background(255);
  for (Box b: boxes)
    b.display();

  for (Box b: boxes)
    b.update();
}

class Box {
  
  PVector location;
  PVector velocity;
  
  Box(float x, float y) {
    location = new PVector(x,y);
    velocity = new PVector(0,0);
  }
  
  void display() {
    rectMode(CENTER);
    fill(175);
    stroke(0);
    rect(location.x,location.y,16,16);
  }
  
  void update() {
    velocity.add(new PVector(0,0.07)); // gravity
    location.add(velocity);
  }
}
