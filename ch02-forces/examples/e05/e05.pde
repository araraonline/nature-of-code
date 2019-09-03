Fluid fluid;
Mover[] movers;

void setup() {
  size(200,200);
  background(255);
  
  fluid = new Fluid(0,height/2,width,height/2,0.1);
  
  movers = new Mover[5];
  for (int i = 0; i < movers.length; i++)
    movers[i] = new Mover(random(1,5),random(0,width),0);
}

void draw() {
  background(255);
  
  fluid.display();
  
  PVector wind = new PVector(0.002,0);
  PVector gravity = new PVector(0,0.1);
  PVector drag = null;
  PVector[] forces = new PVector[]{wind,gravity,drag};

  for (int i = 0; i < movers.length; i++) {
    
    // calculate gravity
    gravity.y = 0.1*movers[i].mass;
    
    // calculate drag force (of the fluid)
    if (movers[i].isInside(fluid)) {
      drag = movers[i].calculateDrag(fluid);
    } else {
      drag = new PVector(0,0);
    }
    forces[2] = drag;
    
    movers[i].update(forces);
    movers[i].display();
  }
}

class Fluid {
  
  float x,y;
  float w,h;
  float coef;
  
  Fluid(float x_, float y_, float w_, float h_, float coef_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    coef = coef_;
  }
  
  void display() {
    noStroke();
    fill(175);
    rect(x,y,w,h);
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
  
  boolean isInside(Fluid fluid) {
    return (
      location.x >= fluid.x && location.x <= fluid.x + fluid.w &&
      location.y >= fluid.y && location.y <= fluid.y + fluid.h
    );
  }
  
  PVector calculateDrag(Fluid fluid) {
    PVector result;
    result = velocity.copy();
    result.normalize();
    float speed = velocity.mag();
    result.mult(-fluid.coef*speed*speed);
    return result;
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
