float G = 2e-1;

Pendulum pendulum;

void setup() {
  size(200,200);
  pendulum = new Pendulum();
}

void draw() {
  background(175);
  pendulum.swing();
  pendulum.display();
}

class Pendulum {
  
  PVector location;
  
  float armLength;
  
  float aVelocity;
  float angle; // clockwise relative to arm
  
  Pendulum() {
    location = new PVector(width/2,0);
    
    armLength = 100;
    
    aVelocity = 0;
    angle = PI/4;
  }
  
  void swing() {
    float aAcceleration = (-1 * G * sin(angle)) / armLength;
    aVelocity += aAcceleration;
    aVelocity *= 0.992; // damping
    angle += aVelocity;
  }
  
  void display() {
    _displayArm();
    _displayBob();
  }
  
  void _displayArm() {
    pushMatrix();
    translate(location.x,location.y);
    rotate(angle);
    line(0,0,0,armLength);
    popMatrix();
  }
  
  void _displayBob() {
    pushMatrix();
    translate(location.x,location.y);
    rotate(angle);
    translate(0,armLength);
    ellipse(0,0,16,16);
    popMatrix();
  }
}
