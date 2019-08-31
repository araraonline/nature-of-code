float EDGE_FORCE_STRENGTH = 10;
float EDGE_FORCE_LIMIT = 0.2;

Mover[] movers;

void setup() {
  size(200,200);
  background(255);
  movers = new Mover[50];
  for (int i = 0; i < movers.length; i++)
    movers[i] = new Mover(random(0.1,5),0,0);
}

void draw() {
  background(255);
  
  PVector wind = new PVector(0.01,0);
  PVector gravity = new PVector(0,0.1);
  PVector edgeForce = new PVector(0,0);
  PVector[] forces = new PVector[]{wind,gravity,edgeForce};
  
  for (int i = 0; i < movers.length; i++) {
    
    // calculate edge force (repels ball back into screen)
    float dist;
    if (movers[i].location.x >= 0 && movers[i].location.x <= width) {
      edgeForce.x = 0;
    } else if (movers[i].location.x < 0) {
      // left of screen
      dist = -movers[i].location.x;
      edgeForce.x = EDGE_FORCE_STRENGTH/dist;
    } else {
      // right of screen
      dist = movers[i].location.x-width;
      edgeForce.x = -EDGE_FORCE_STRENGTH/dist;
    }
    edgeForce.limit(EDGE_FORCE_LIMIT);
    
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
