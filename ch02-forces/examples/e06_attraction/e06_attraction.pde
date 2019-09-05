float G = 0.5;

Attractor attractor;
Mover mover;

void setup() {
  size(200,200);
  background(255);
  attractor = new Attractor();
  mover = new Mover();
}

void draw() {
  PVector attraction = attractor.attract(mover);
  PVector[] forces = new PVector[]{attraction};
  
  mover.update(forces);
  
  background(255);
  attractor.display();
  mover.display();
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
  
  PVector location;
  PVector velocity;
  float mass;
  
  Mover() {
    location = new PVector(100,25);
    velocity = new PVector(0,0);
    mass = 1;
  }
  
  void update(PVector[] forces) {
    PVector acceleration = PVector.div(sumVectors(forces),mass);
    velocity.add(acceleration);
    location.add(velocity);
  }
  
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x,location.y,16*mass,16*mass);
  }
}

PVector sumVectors(PVector[] vectors) {
  PVector result = new PVector(0,0);
  for (int i = 0; i < vectors.length; i++)
    result.add(vectors[i]);
  return result;
}
