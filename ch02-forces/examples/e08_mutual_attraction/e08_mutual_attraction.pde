float G = 0.5;

Mover[] movers;

void setup() {
  size(200,200);
  background(255);
  movers = new Mover[10];
  for (int i = 0; i < movers.length; i++)
    movers[i] = new Mover(random(0,width),random(0,height));
}

void draw() {
  background(255);

  for (int i = 0; i < movers.length; i++) {
    
    PVector attraction = new PVector(0,0);
    for (int j = 0; j < movers.length; j++)
      if (i != j)
        attraction.add(movers[j].attract(movers[i]));
        
    PVector[] forces = new PVector[]{attraction};
    movers[i].update(forces);
    movers[i].display();
    
  }
}

class Mover {
  
  PVector location;
  PVector velocity;
  float mass;
  
  Mover(float x, float y) {
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    mass = 1;
  }
  
  PVector attract(Mover mover) {
    PVector result;
    
    PVector displacement = PVector.sub(location,mover.location);
    float distance = constrain(displacement.mag(),5,50);
    
    result = displacement.copy();
    result.normalize();
    float strength = (G * mass * mover.mass) / (distance * distance);
    result.mult(strength);
    
    return result;
  }
  
  void update(PVector[] forces) {
    PVector acceleration = PVector.div(sumVectors(forces),mass);
    velocity.add(acceleration);
    location.add(velocity);
  }
  
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x,location.y,8*mass,8*mass);
  }
}

PVector sumVectors(PVector[] vectors) {
  PVector result = new PVector(0,0);
  for (int i = 0; i < vectors.length; i++)
    result.add(vectors[i]);
  return result;
}
