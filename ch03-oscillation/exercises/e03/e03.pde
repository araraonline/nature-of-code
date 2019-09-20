Car car;
Controller controller;

void setup() {
  size(200,200);
  car = new Car();
  controller = new Controller();
}

void draw() {
  background(175);
  car.update();
  car.display();
}

class Car {
  
  PVector location = new PVector(width/2,height/2);
  PVector velocity = new PVector(0.1,0);
  
  void update() {
    PVector acceleration = _calculateAcceleration();
    
    velocity.add(acceleration);
    velocity.limit(5);
    location.add(velocity);
    _wrap();
  }
  
  void display() {
    float angle = velocity.heading();
    
    pushMatrix();
    
    translate(location.x,location.y);
    rotate(angle);
    
    rectMode(CORNER);
    
    stroke(0);
    fill(255);
    rect(-15,-5,25,10);
    
    stroke(0);
    fill(0);
    rect(10,-5,5,10);
    
    popMatrix();
  }
  
  PVector _calculateAcceleration() {
    PVector acceleration = new PVector(0,0);
    
    if (controller.up)    acceleration.y -= 0.1;
    if (controller.down)  acceleration.y += 0.1;
    if (controller.left)  acceleration.x -= 0.1;
    if (controller.right) acceleration.x += 0.1;

    return acceleration;
  }
  
  void _wrap() {
    if (location.x > width) location.x = 0;
    if (location.x < 0) location.x = width;
    if (location.y > height) location.y = 0;
    if (location.y < 0) location.y = 0;
  }
}

// controller

class Controller {
  boolean up, down, left, right;
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP)    controller.up    = true;
    if (keyCode == DOWN)  controller.down  = true;
    if (keyCode == LEFT)  controller.left  = true;
    if (keyCode == RIGHT) controller.right = true;
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP)    controller.up    = false;
    if (keyCode == DOWN)  controller.down  = false;
    if (keyCode == LEFT)  controller.left  = false;
    if (keyCode == RIGHT) controller.right = false;
  }
}
