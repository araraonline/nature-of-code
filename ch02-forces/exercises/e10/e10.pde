float G = 5; // gravity constant (repulsion)
float M = 0.002; // mouse attraction constant
float F = 0.02; // friction constant

Mover[] movers;

void setup() {
  size(200,200);
  background(255);
  movers = new Mover[27];
  for (int i = 0; i < movers.length; i++)
    movers[i] = new Mover(random(0,width),random(0,height));
}

void draw() {
  background(255);

  for (int i = 0; i < movers.length; i++) {
    
    PVector repulsion = new PVector(0,0);
    for (int j = 0; j < movers.length; j++)
      if (i != j)
        repulsion.add(movers[j].attract(movers[i]));
    repulsion.mult(-1); // repel
    
    PVector friction = calculateFriction(movers[i]); // friction allows moment to cease (then we enter in a static equilibrium)
    PVector attraction = mouseAttract(movers[i]);
        
    PVector[] forces = new PVector[]{repulsion,friction,attraction};
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
    float distance = constrain(displacement.mag(),10,50);
    
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

PVector mouseAttract(Mover mover) {
  PVector result;
  
  PVector displacement = PVector.sub(mouse(),mover.location);
  float distance = displacement.mag();
  
  result = displacement.copy();
  result.normalize();
  result.mult(M*distance);
  
  return result;
}

PVector calculateFriction(Mover mover) {
  PVector result;
  
  result = mover.velocity.copy();
  result.rotate(PI);
  result.normalize();
  result.mult(F);
  
  return result;
}

PVector mouse() {
  return new PVector(mouseX, mouseY);
}
