Mover mover;

void setup() {
  size(300,300);
  mover = new Mover();
  _initMouse();
}

void _initMouse() {
  mouseX = width/2;
  mouseY = height/2;
}

void draw() {
  background(175);
  mover.update();
  mover.display();
}

class Mover {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  
  Mover() {
    location = new PVector(width/2,height/2);
    velocity = new PVector(0,0);
    topspeed = 10;
  }
  
  void update() {
    // calculate acceleration (close=weak / far=strong)
    PVector diff = PVector.sub(mouse(), location);
    diff.div(1000);
    
    // trickle-down effect
    acceleration = diff;
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

PVector mouse() {
  return new PVector(mouseX, mouseY);
}
