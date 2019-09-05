float G = 0.5;

Attractor[] attractors;
Mover[] movers;

void setup() {
  size(200,200);
  background(255);
  attractors = new Attractor[5];
  for (int i = 0; i < attractors.length; i++)
    attractors[i] = new Attractor(random(5,20),random(0,width),random(0,height));
  movers = new Mover[5];
  for (int i = 0; i < movers.length; i++)
    movers[i] = new Mover(random(0.1,2),random(0,width),random(0,height));
}

void draw() {
  //background(255);
  
  for (int i = 0; i < attractors.length; i++)
    attractors[i].display();
  
  Mover mover = null;
  for (int i = 0; i < movers.length; i++) {
    mover = movers[i];
    
    PVector attraction = new PVector(0,0);
    for (int j = 0; j < attractors.length; j++)
      attraction.add(attractors[j].attract(mover));
    PVector[] forces = new PVector[]{attraction};
    
    mover.update(forces);
    mover.display();
  }
  
}

class Attractor {
  
  PVector location;
  float mass;
  
  Attractor(float m, float x, float y) {
    location = new PVector(x,y);
    mass = m;
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
    //ellipse(location.x,location.y,mass*2,mass*2);
  }
}

class Mover {
  
  PVector location;
  PVector velocity;
  float mass;
  
  Mover(float m, float x, float y) {
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    mass = m;
  }
  
  void update(PVector[] forces) {
    PVector acceleration = PVector.div(sumVectors(forces),mass);
    velocity.add(acceleration);
    location.add(velocity);
  }
  
  void display() {
    stroke(0);
    fill(175);
    //ellipse(location.x,location.y,16*mass,16*mass);
    point(location.x,location.y);
  }
}

PVector sumVectors(PVector[] vectors) {
  PVector result = new PVector(0,0);
  for (int i = 0; i < vectors.length; i++)
    result.add(vectors[i]);
  return result;
}
