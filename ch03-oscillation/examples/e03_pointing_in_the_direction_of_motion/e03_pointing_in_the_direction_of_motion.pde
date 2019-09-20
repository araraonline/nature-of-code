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
    // calculate acceleration
    PVector acceleration = PVector.sub(mouse(), location);
    acceleration.setMag(0.1);
    
    // trickle-down effect
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    
    _checkEdges();
  }
  
  void display() {
    float angle = velocity.heading();
    
    pushMatrix();
    translate(location.x,location.y);
    rotate(angle);
    rectMode(CENTER);
    rect(0,0,25,8);
    popMatrix();
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

PVector mouse() {
  return new PVector(mouseX, mouseY);
}
