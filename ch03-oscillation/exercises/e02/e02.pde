Cannon cannon;
Cannonball cannonball;


void setup() {
  size(400,200);
  frameRate(60);
  cannon = new Cannon();
  cannonball = new Cannonball();
}

void draw() {
  if (frameCount%(2*60) == 0) {
    // shoot every 2 seconds
    cannonball.shoot();
  } else {
    // update cannonball position
    cannonball.update();
  }
  
  background(255);
  cannonball.display();
  cannon.display();
}

class Cannon {
  
  PVector location = new PVector(20, height);
  PVector size = new PVector(40,10);
  float angle = -radians(45);
  
  void display() {
    pushMatrix();
    stroke(0);
    fill(255);
    translate(location.x, location.y);
    rotate(angle);
    rectMode(CORNER);
    rect(0,-size.y,size.x,size.y);
    popMatrix();
  }
}

class Cannonball {
  
  PVector location;
  PVector velocity;
  
  float angle;
  float aVelocity;
  
  float mass = 1.15;
  
  Cannonball() {
    shoot();
  }
  
  void shoot() {
    location = cannon.location.copy();
    location.y -= cannon.size.y/2;
    velocity = new PVector(0,0);
    
    angle = cannon.angle;
  }
  
  void update() {
    PVector force = new PVector(0,0);
    force.add(_calculateCannonForce());
    force.add(_calculateGravityForce());
    
    PVector acceleration = PVector.div(force,mass);
    velocity.add(acceleration);
    location.add(velocity);
    
    float desiredAngle = velocity.heading();
    float aAcceleration = constrain(desiredAngle-angle,-0.01,0.01);
    aVelocity += aAcceleration;
    angle += aVelocity;
  }
  
  void display() {
    pushMatrix();
    translate(location.x,location.y);
    rotate(angle);
    stroke(0);
    fill(0);
    rectMode(CENTER);
    rect(0,0,10,5);
    popMatrix();
  }
  
  PVector _calculateCannonForce() {
    if (PVector.sub(location,cannon.location).mag() <= 20) {
      return PVector.mult(PVector.fromAngle(cannon.angle),1);
    } else {
      return new PVector(0,0);
    }
  }
  
  PVector _calculateGravityForce() {
    if (PVector.sub(location,cannon.location).mag() > 20) {
      return new PVector(0,0.05*mass);
    } else {
      return new PVector(0,0);
    }
  }
}
