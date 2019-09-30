float G = 0.1;
float MU = 0.1;

Slope slope;
Box box;

void setup() {
  size(200,300);
  slope = new Slope(radians(20));
  box = new Box(0,height-slope.getHeight(),slope.angle);
}

void draw() {
  background(255);
  
  box.update();
  
  slope.display();
  box.display();
}

class Slope {
  
  // Slope falling down to the right of the screen
  
  float angle;
  
  Slope(float angle_) {
    angle = angle_;
  }
  
  void display() {
    stroke(0);
    fill(175);
    float h = getHeight();
    triangle(0,height-h,width,height,0,height);
  }
  
  float getHeight() {
    return width * tan(angle);
  }
}

class Box {
  
  PVector location; // location of bottom-left corner
  PVector velocity;
  float angle;
  
  Box(float x, float y, float angle_) {
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    angle = angle_;
  }
  
  void display() {
    pushMatrix();
    translate(location.x,location.y);
    rotate(angle);
    rect(0,-20,20,20);
    popMatrix();
  }
  
  void update() {
    // calculate acceleration (assuming mass = 1)
    PVector acceleration = new PVector(0,0);
    acceleration.add(_gravityForceX());
    acceleration.add(_frictionForce());
    
    // trickle-down into location
    velocity.add(acceleration);
    location.add(velocity);
  }
  
  PVector _gravityForceX() {
    PVector g = PVector.fromAngle(slope.angle);
    g.mult(G*sin(slope.angle));
    return g;
  }
  
  PVector _frictionForce() {
    PVector f = PVector.fromAngle(slope.angle+PI);
    f.mult(MU*G*cos(slope.angle));
    f.limit(_gravityForceX().mag()); // friction cannot be stronger than gravity (oherwise we move upwards!)
    return f;
  }
}
