Ship spaceship;
Controller controller;

void setup() {
  size(200,200);
  spaceship = new Ship();
  controller = new Controller();
}

void draw() {
  background(255);
  spaceship.update();
  spaceship.display();
}

class Ship {
  
  float angle = -HALF_PI; // pointing upwards
  
  PVector location = new PVector(width/2,height/2);
  PVector velocity = new PVector(0,0);
  
  void update() {
    // thrust
    if (controller.z) {
      PVector acceleration = PVector.fromAngle(angle);
      acceleration.setMag(0.1);
      velocity.add(acceleration);
      velocity.limit(5);
    }
    
    // rotation
    if (controller.left) angle -= 0.1;
    if (controller.right) angle += 0.1;
    
    // update location
    location.add(velocity);
    
    _wrap();
  }
  
  void _wrap() {
    if (location.x > width) location.x = 0;
    if (location.x < 0) location.x = width;
    if (location.y > height) location.y = 0;
    if (location.y < 0) location.y = height;
  }
  
  void display() {
    pushMatrix();
    translate(location.x,location.y);
    rotate(angle);
    _displayThrusters();
    _displayBody();
    popMatrix();
  }
  
  void _displayBody() {
    float s = 16; // size
    float h = sqrt(3) * s / 2;
    
    stroke(0);
    fill(175);
    triangle(-h/3,-s/2,2*h/3,0,-h/3,s/2);
  }
  
  void _displayThrusters() {
    float s = 16; // size of body
    float h = sqrt(3) * s / 2; // height of body
    
    stroke(0);
    fill(175);
    rectMode(CENTER);
    rect(-h/3,-0.22*s,0.26*h,s/4);
    rect(-h/3,0.22*s,0.26*h,s/4);
  }
}

// controller

class Controller {
  boolean left, right, z;
}

void keyPressed() {
  if (key == 'z') {
    controller.z = true;
  } else if (key == CODED) {
    if (keyCode == LEFT)  controller.left  = true;
    if (keyCode == RIGHT) controller.right = true;
  }
}

void keyReleased() {
  if (key == 'z') {
    controller.z = false;
  } else if (key == CODED) {
    if (keyCode == LEFT)  controller.left  = false;
    if (keyCode == RIGHT) controller.right = false;
  }
}
