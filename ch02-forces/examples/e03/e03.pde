Mover[] movers;

void setup() {
  size(200,200);
  background(255);
  movers = new Mover[100];
  for (int i = 0; i < movers.length; i++)
    movers[i] = new Mover(random(0.1,5),0,0);
}

void draw() {
  background(255);
  
  PVector wind = new PVector(0.01,0);
  PVector gravity = new PVector(0,0.1);
  PVector[] forces = new PVector[]{wind,gravity};
  
  for (int i = 0; i < movers.length; i++) {
    gravity.y = 0.1*movers[i].mass;
    movers[i].update(forces);
    movers[i].display();
  }
}

class Mover {
  
  PVector location;
  PVector velocity;
  float mass;
  
  Mover(float m, float x, float y) {
    mass = m;
    location = new PVector(x,y);
    velocity = new PVector(0,0);
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
