Mover[] movers = new Mover[20];

void setup() {
  size(200,200);
  frameRate(30);
  for (int i = 0; i < movers.length; i++)
    movers[i] = new Mover();
}

void draw() {
  background(175);
  for (int i = 0; i < movers.length; i++) {
    movers[i].update();
    movers[i].display();
  }
}

class Mover {
  
  PVector location;
  PVector velocity;
  float topspeed;
  
  Mover() {
    location = new PVector(random(0,width),random(0,height));
    velocity = new PVector(0,0);
    topspeed = 4; // extremely important
  }
  
  void update() {
    // calculate acceleration
    PVector acceleration = PVector.sub(mouse(), location);
    acceleration.setMag(0.5);
    
    // trickle-down effect
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
