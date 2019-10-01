float G = 3e-2;
float K = 1.5e-3;

SpringyPendulum pendulum;

void setup() {
  size(200,200);
  pendulum = new SpringyPendulum(width/2,0,25,75);
}

void draw() {
  background(255);
  
  PVector[] fs = new PVector[1];
  fs[0] = new PVector(0,G*pendulum.bob.mass); // gravity
  
  pendulum.update(fs);
  pendulum.display();
}

class SpringyPendulum {
  
  Anchor anchor;
  Spring spring;
  Bob bob;
  
  SpringyPendulum(float anchorX, float anchorY, float bobX, float bobY) {
    anchor = new Anchor(anchorX, anchorY);
    bob = new Bob(bobX, bobY);
    spring = new Spring(anchor,bob);
  }
  
  void update(PVector[] externalForces) {
    PVector totalForce = new PVector(0,0);
    totalForce.add(spring.calculateForceOnBob());
    for (int i = 0; i < externalForces.length; i++)
      totalForce.add(externalForces[i]);
    
    PVector acceleration = PVector.div(totalForce,bob.mass);
    bob.velocity.add(acceleration);
    bob.velocity.mult(0.9975);
    bob.location.add(bob.velocity);
  }
  
  void display() {
    spring.display();
    bob.display();
    anchor.display();
  }
}

class Anchor {
  
  PVector location;
  
  Anchor(float x, float y) {
    location = new PVector(x,y);
  }
  
  void display() {
    rectMode(CENTER);
    noStroke();
    fill(75);
    ellipse(location.x,location.y,8,8);
  }
}

class Spring {
  
  float size; // length var is taken
  float constant;
  
  Anchor anchor;
  Bob bob;
  
  Spring(Anchor a, Bob b) {
    size = 75;
    constant = K;
    anchor = a;
    bob = b;
  }
  
  void display() {
    stroke(0);
    line(anchor.location.x,anchor.location.y,bob.location.x,bob.location.y);
  }
  
  PVector calculateForceOnBob() {
    PVector displacement = PVector.sub(bob.location,_getRestLocation());
    //println(bob.location,_getRestLocation(),displacement);
    return PVector.mult(displacement,-constant);
  }
  
  PVector _getRestLocation() {
    PVector result = PVector.sub(bob.location,anchor.location);
    result.setMag(size);
    result.add(anchor.location);
    return result;
  }
}

class Bob {
  
  PVector location;
  PVector velocity;
  
  float mass;
  
  Bob(float x, float y) {
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    mass = 1;
  }
  
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x,location.y,16,16);
  }
}
