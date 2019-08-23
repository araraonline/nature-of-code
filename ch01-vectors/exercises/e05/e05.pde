Car mover;

void setup() {
  size(200,200);
  mover = new Car();
}

void draw() {
  background(175);
  mover.update();
  mover.display();
}

class Car {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  
  Car() {
    location = new PVector(0,height);
    velocity = new PVector(0,0);
    topspeed = 10;
  }
  
  void update() {
    _calcAcceleration();
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    _checkEdges();
  }
  
  void display() {
    fill(0);
    rect(location.x,location.y-20,40,20);
  }
  
  void _calcAcceleration() {
    if (keyPressed && keyCode == UP) {
      // 0.125 to avoid floating point approximations
      acceleration = new PVector(0.125,0);
    } else if (keyPressed && keyCode == DOWN) {
      acceleration = new PVector(0,0);
      acceleration.sub(velocity);
      acceleration.setMag(0.125);
    } else {
      acceleration = new PVector(0,0);
    }
  }
  
  void _checkEdges() {
    if (location.x < 0) location.x = width;
    if (location.x > width) location.x = 0;
  }
}
