Mosquito[] mosquitoes;
Blob[] blobs;

void setup() {
  size(200,200);
  
  mosquitoes = new Mosquito[9];
  for (int i = 0; i < mosquitoes.length; i++)
    mosquitoes[i] = new Mosquito();
    
  blobs = new Blob[2];
  for (int i = 0; i < blobs.length; i++)
    blobs[i] = new Blob();
}

void draw() {
  background(255);
  
  // Mosquitoes
  
  PVector randomForce = new PVector(0,0);
  PVector airResistance = new PVector(0,0);
  PVector repulsionFromOtherMosquitoes = new PVector(0,0);
  PVector[] forces = new PVector[]{randomForce,repulsionFromOtherMosquitoes,airResistance};
  
  for (int i = 0; i < mosquitoes.length; i++) {
    
    randomForce.x = random(-0.5,0.5);
    randomForce.y = random(-0.5,0.5);
    
    repulsionFromOtherMosquitoes = new PVector(0,0);
    for (int j = 0; j < mosquitoes.length; j++) {
      if (i != j) {
          PVector dislocation = PVector.sub(mosquitoes[j].location,mosquitoes[i].location); // from i to j
          float dist = dislocation.mag();
          if (dist < 8) {
            PVector repulsion = dislocation.copy();
            repulsion.normalize();
            repulsion.mult(-0.5);
            repulsionFromOtherMosquitoes.add(repulsion);
          }
      }
    }
    forces[1] = repulsionFromOtherMosquitoes;
    
    float speed = mosquitoes[i].velocity.mag();
    airResistance = mosquitoes[i].velocity.copy();
    airResistance.normalize();
    airResistance.mult(-0.02*speed*speed);
    forces[2] = airResistance;
    
    mosquitoes[i].update(forces);
    mosquitoes[i].display();
  }
  
  // Blobs
  
  for (int i = 0; i < blobs.length; i++) {
    blobs[i].update();
    blobs[i].display();
  }
}

class Mosquito {
  
  PVector location;
  PVector velocity;
  
  Mosquito() {
    location = new PVector(random(0,width),random(0,height));
    velocity = new PVector(random(-1,1),random(-1,1));
  }
  
  void update(PVector[] forces) {
    // calculate acceleration
    PVector totalForce = sumForces(forces);
    PVector acceleration = totalForce;
    
    // trickle-down effect
    velocity.add(acceleration);
    location.add(velocity);
    
    // bounce
    _bounceOnEdges();
  }
  
  void display() {
    rectMode(CENTER);
    noStroke();
    fill(0);
    rect(location.x,location.y,5,5);
  }
  
  void _bounceOnEdges() {
    // vertical
    if (location.y < 0) {
      location.y = 0;
      velocity.y = abs(velocity.y);
    } else if (location.y > height) {
      location.y = height;
      velocity.y = -abs(velocity.y);
    }
    
    // horizontal
    if (location.x < 0) {
      location.x = 0;
      velocity.x = abs(velocity.x);
    } else if (location.x > width) {
      location.x = width;
      velocity.x = -abs(velocity.x);
    }
  }
}

class Blob {
  
  float tick = random(0,1e5);
  
  void update() {
    tick++;
  }
  
  void display() {
    stroke(10,200);
    fill(155,200);
    ellipse(_getX(),_getY(),_getSize(),_getSize());
  }
  
  float _getX() {
    return map(noise(tick*0.005),0,1,0,width);
  }
  
  float _getY() {
    return map(noise(1e4+tick*0.005),0,1,0,height);
  }
  
  float _getSize() {
    float min = 30.0*9/12;
    float max = 50.0*9/12;
    return map(sin(tick*0.05),-1,1,min,max);
  }
}

PVector sumForces(PVector[] forces) {
  PVector result = new PVector(0,0);
  for (int i = 0; i < forces.length; i++)
    result.add(forces[i]);
  return result;
}
