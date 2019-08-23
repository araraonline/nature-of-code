Mover mover;

void setup() {
  size(200,200);
  mover = new Mover();
}

void draw() {
  background(255);
  mover.update();
  mover.display();
}

class Mover {
  
  PVector location;
  PVector speed;
  
  Mover() {
    location = new PVector(random(0,width),random(0,height));
    speed = PVector.random2D().mult(random(0,2));
  }
 
  void update() {
    location.add(speed);
    _wrap();
  }
  
  void display() {
    ellipse(location.x,location.y,16,16);
  }
  
  void _wrap() {
    // wrap horizontaly
    if (location.x < 0) location.x = width;
    if (location.x > width) location.x = 0;
    
    // wrap vertically
    if (location.y < 0) location.y = height;
    if (location.y > height) location.y = 0;
  }
}
