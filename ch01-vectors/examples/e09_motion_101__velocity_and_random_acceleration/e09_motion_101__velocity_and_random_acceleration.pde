Mover mover;

void setup() {
  size(200,200);
  mover = new Mover();
}

void draw() {
  background(175);
  mover.update();
  mover.display();
}

class Mover {
  
  PVector location;
  PVector velocity;
  float topspeed;
  
  Mover() {
    location = new PVector(width/2,height/2);
    velocity = new PVector(0,0);
    topspeed = 10;
  }
  
  void update() {
    PVector acceleration = PVector.random2D();
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    _checkEdges();
  }
  
  void display() {
    ellipse(location.x,location.y,16,16);
  }
  
  void _checkEdges() {
    // horizontal
    if (location.x < 0) location.x = width;
    if (location.x > width) location.x = 0;
    
    // vertical
    if (location.y < 0) location.y = height;
    if (location.y > height) location.y = 0;
  }
}
