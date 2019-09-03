float MIN_FRICTION = -0.05;
float MAX_FRICTION = 0.05;


Pocket[] pockets;
Mover[] movers;

void setup() {
  size(200,200);
  background(255);
  
  pockets = new Pocket[10];
  for (int i = 0; i < pockets.length; i++)
    pockets[i] = new Pocket(random(MIN_FRICTION,MAX_FRICTION),random(0,width),random(0,height),random(20,50),random(20,50));
  
  movers = new Mover[5];
  for (int i = 0; i < movers.length; i++)
    movers[i] = new Mover(random(0.1,5),0,0);
}

void draw() {
  background(255);
  
  PVector wind = new PVector(0.002,0);
  PVector gravity = new PVector(0,0.1);
  PVector friction = null;
  PVector[] forces = new PVector[]{wind,gravity,friction};
  
  for (int i = 0; i < pockets.length; i++)
    pockets[i].display();

  for (int i = 0; i < movers.length; i++) {
    
    // calculate gravity
    gravity.y = 0.1*movers[i].mass;
    
    // calculate friction
    friction = new PVector(0,0);
    for (int j = 0; j < pockets.length; j++) {
      if (pockets[j].contains(movers[i])) {
        friction.add(pockets[j].calculateFrictionOn(movers[i]));
      }
    }
    forces[2] = friction;
    
    movers[i].update(forces);
    movers[i].display();
  }
}

class Pocket {
  
  float x,y;
  float w,h;
  float coef;
  
  Pocket(float coef_, float x_, float y_, float w_, float h_) {
    coef = coef_;
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }
  
  void display() {
    stroke(0);
    fill(map(coef,0,MAX_FRICTION,255,0), 255/2);
    rect(x,y,w,h);
  }
  
  boolean contains(Mover mover) {
    return (
      mover.location.x >= x && mover.location.x <= x + w &&
      mover.location.y >= y && mover.location.y <= y + h
    );
  }
  
  PVector calculateFrictionOn(Mover mover) {
    PVector result;
    result = mover.velocity.copy();
    result.rotate(PI);
    result.setMag(coef); // ignore normal force
    return result;
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
