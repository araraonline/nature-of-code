Mover mover;

void setup() {
  size(200,200);
  background(255);
  mover = new Mover();
}

void draw() {
  background(255);
  
  PVector wind = new PVector(0.01,0);
  PVector gravity = new PVector(0,0.1);
  PVector[] forces = new PVector[]{wind,gravity};
  
  mover.update(forces);
  mover.display();
}

class Mover {
  
  PVector location;
  PVector velocity;
  float mass;
  
  Mover() {
    location = new PVector(30,30);
    velocity = new PVector(0,0);
    mass = 1;
  }
  
  void update(PVector[] forces) {
    PVector acceleration = PVector.div(sumVectors(forces),mass);
    velocity.add(acceleration);
    location.add(velocity);
    
    _checkEdges();
  }
  
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x,location.y,16*mass,16*mass);
  }
  
  void _checkEdges() {
    // walls
    if (location.x < 0) {
      location.x = 0;
      velocity.x = abs(velocity.x);
    } else if (location.x > width) {
      location.x = width;
      velocity.x = -abs(velocity.x);
    }
    
    // floor
    if (location.y > height) {
      location.y = height;
      velocity.y = -abs(velocity.y);
    }
  }
}

PVector sumVectors(PVector[] vectors) {
  PVector result = new PVector(0,0);
  for (int i = 0; i < vectors.length; i++)
    result.add(vectors[i]);
  return result;
}
