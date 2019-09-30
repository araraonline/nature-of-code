float G = 2e-1;

Pendulum p1, p2, p3, p4;

void setup() {
  size(200,400);
  
  p1 = new Pendulum(100);
  
  p2 = new Pendulum(50);
  p2.attachTo(p1);
  
  p3 = new Pendulum(25);
  p3.attachTo(p2);
  
  p4 = new Pendulum(12.5);
  p4.attachTo(p3);
}

void draw() {
  background(175);
  
  p1.update();
  p2.update();
  p3.update();
  p4.update();
  
  p1.display(false);
  p2.display(false);
  p3.display(false);
  p4.display(true);
}

class Pendulum {
  
  PVector location;
  
  float armLength;
  
  float aVelocity;
  float angle; // clockwise relative to arm
  
  Pendulum attachedTo;
  
  Pendulum(float armLength_) {
    location = new PVector(width/2,0);
    
    armLength = armLength_;
    
    aVelocity = 0;
    angle = PI/4;
  }
  
  void attachTo(Pendulum other) {
    // put this pendulum at the endpoint of 'other'
    attachedTo = other;
  }
  
  void update() {
    _updateLocation();
    _updateAngle();
  }
  
  void _updateLocation() {
    if (attachedTo != null) {
      location = attachedTo.getEndpointLocation();
    }
  }
  
  void _updateAngle() {
    float aAcceleration = (-1 * G * sin(angle)) / armLength;
    aVelocity += aAcceleration;
    aVelocity *= 0.995; // damping
    angle += aVelocity;
  }
  
  void display(boolean showBob) {
    _displayArm();
    if (showBob)
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
  
  PVector getEndpointLocation() {
    PVector arm = PVector.fromAngle(angle);
    arm.rotate(HALF_PI);
    arm.mult(armLength);
    
    return PVector.add(location,arm);
  }
}
