Plane plane;

void setup() {
  size(200,200);
  background(255);
  plane = new Plane(0,height);
}

void draw() {
  background(255);
  
  PVector gravity = new PVector(0,0.1);
  PVector wind = new PVector(0.08,0);
  PVector drag = null;
  PVector lift = null;
  PVector[] forces = new PVector[]{gravity,wind,drag,lift};
  
  float speed = plane.velocity.mag();
  
  // calculate drag
  drag = plane.velocity.copy();
  drag.rotate(PI);
  drag.setMag(0.01*speed*speed);
  forces[2] = drag;
  
  // calculate lift
  lift = plane.velocity.copy();
  lift.rotate(-HALF_PI);
  lift.setMag(0.02*speed*speed);
  forces[3] = lift;
  
  plane.update(forces);
  plane.display();
}

class Plane {
  
  PVector location;
  PVector velocity;
  
  Plane(float x, float y) {
    location = new PVector(x,y);
    velocity = new PVector(0,0);
  }
  
  void update(PVector[] forces) {
    PVector acceleration = sumVectors(forces);
    velocity.add(acceleration);
    location.add(velocity);
    
    _checkEdges();
  }
  
  void display() {
    rectMode(CENTER);
    stroke(0);
    fill(175);
    rect(location.x,location.y,20,10);
  }
  
  void _checkEdges() {

    // horizontal
    if (location.x < 0) {
      location.x = width;
    } else if (location.x > width) {
      location.x = 0;
    }
    
    // vertical
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
