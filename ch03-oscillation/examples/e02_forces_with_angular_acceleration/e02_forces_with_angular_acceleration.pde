float G = 0.5;

Attractor attractor;
Mover[] movers;

void setup() {
  size(200,200);
  background(255);
  attractor = new Attractor();
  movers = new Mover[20];
  for (int i = 0; i < movers.length; i++)
    movers[i] = new Mover(random(0.1,2),random(0,width),random(0,height));
}

void draw() {
  background(255);
  attractor.display();
  
  Mover mover = null;
  for (int i = 0; i < movers.length; i++) {
    mover = movers[i];
    
    PVector attraction = attractor.attract(mover);
    PVector[] forces = new PVector[]{attraction};
    
    mover.update(forces);
    mover.display();
  }
  
}

class Attractor {
  
  PVector location;
  float mass;
  
  Attractor() {
    location = new PVector(width/2,height/2);
    mass = 20;
  }
  
  PVector attract(Mover mover) {
    PVector result;
    
    PVector displacement = PVector.sub(location,mover.location);
    float distance = constrain(displacement.mag(),5,25);
    
    result = displacement.copy();
    result.normalize();
    float strength = (G * mass * mover.mass) / (distance * distance);
    result.mult(strength);
    
    return result;
  }
  
  void display() {
    stroke(0);
    fill(175,255/4);
    ellipse(location.x,location.y,mass*2,mass*2);
  }
}

class Mover {
  
  float mass;

  PVector location;
  PVector velocity;
  
  float angle;
  float aVelocity;
  
  Mover(float m, float x, float y) {
    mass = m;
    
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    
    angle = 0;
    aVelocity = 0;
  }
  
  void update(PVector[] forces) {
    PVector acceleration = PVector.div(sumVectors(forces),mass);
    velocity.add(acceleration);
    location.add(velocity);
    
    float aAcceleration = acceleration.x;
    aVelocity += aAcceleration;
    aVelocity = constrain(aVelocity,-0.1,0.1);
    angle += aVelocity;
  }
  
  void display() {
    rectMode(CENTER);
    
    pushMatrix();
    
    translate(location.x,location.y);
    rotate(angle);
    
    stroke(0);
    fill(175);
    rect(0,0,16*mass,16*mass);
    
    popMatrix();
  }
}

PVector sumVectors(PVector[] vectors) {
  PVector result = new PVector(0,0);
  for (int i = 0; i < vectors.length; i++)
    result.add(vectors[i]);
  return result;
}
