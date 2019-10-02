Anchor a0;
Bob    b0, b1, b2, b3, b4;
Spring s0, s1, s2, s3, s4;

void setup() {
  size(200,200);
  
  
  float w = width;
  float h = height;
  
  // anchors
  a0 = new Anchor(w/2,h/2);
  
  // bobs
  b0 = new Bob(w/2,h/2+30); // center
  b1 = new Bob(w/2+20,h/2-20); // right
  b2 = new Bob(w/2+40,h/2);
  b3 = new Bob(w/2-20,h/2-20); //left
  b4 = new Bob(w/2-40,h/2);
  
  // springs
  s0 = new Spring(9e-3,30,a0,b0);
  s1 = new Spring(1e-2,30,a0,b1);
  s2 = new Spring(1e-2,30,b1,b2);
  s3 = new Spring(1e-2,30,a0,b3);
  s4 = new Spring(1e-2,30,b3,b4);
}

void draw() {
  // accumulate forces for update
  
  s0.applyForceOnEdges();
  s1.applyForceOnEdges();
  s2.applyForceOnEdges();
  s3.applyForceOnEdges();
  s4.applyForceOnEdges();
  
  PVector g = new PVector(0,0.001);
  b0.applyForce(new PVector(0,0.085));
  b1.applyForce(g);
  b2.applyForce(g);
  b3.applyForce(g);
  b4.applyForce(g);
  
  PVector w = new PVector(-0.01,0);
  b0.applyForce(w);
  b1.applyForce(w);
  b2.applyForce(w);
  b3.applyForce(w);
  b4.applyForce(w);
  
  // update location and velocity based on previous step
  b0.update();
  b1.update();
  b2.update();
  b3.update();
  b4.update();
  
  // display things
  
  background(255);
  
  s0.display();
  s1.display();
  s2.display();
  s3.display();
  s4.display();
  
  a0.display();
  
  b0.display();
  b1.display();
  b2.display();
  b3.display();
  b4.display();
}

class Anchor implements SpringEdge {
  
  PVector location;
  
  Anchor(float x, float y) {
    location = new PVector(x,y);
  }
  
  PVector getLocation() {
    return location;
  }
  
  float getX() {
    return location.x;
  }
  
  float getY() {
    return location.y;
  }
  
  void applyForce(PVector force) {
    // NOOP
  }
  
  void display() {
    stroke(0);
    fill(75);
    ellipse(location.x,location.y,8,8);
  }
}

class Bob implements SpringEdge {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  Bob(float x, float y) {
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  PVector getLocation() {
    return location;
  }
  
  float getX() {
    return location.x;
  }
  
  float getY() {
    return location.y;
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);
  }
  
  void update() {
    velocity.add(acceleration);
    velocity.mult(0.997);
    location.add(velocity);
    
    acceleration = new PVector(0,0); // for next loop
  }
  
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x,location.y,16,16);
  }
}

class Spring {
  
  SpringEdge start;
  SpringEdge end;
  float k;
  float restLength;
  
  Spring(float k_, float restLength_, SpringEdge start_, SpringEdge end_) {
    start = start_;
    end = end_;
    k = k_;
    restLength = restLength_;
  }
  
  void applyForceOnEdges() {
    PVector f1 = PVector.sub(end.getLocation(),start.getLocation()); // from start to end
    float x = f1.mag() - restLength;
    f1.setMag(k*x);
    
    start.applyForce(f1);
    
    PVector f2 = PVector.mult(f1,-1);
    end.applyForce(f2);
  }
  
  void display() {
    stroke(0);
    line(start.getX(),start.getY(),end.getX(),end.getY());
  }
}

interface SpringEdge {
  
  PVector getLocation();
  float getX();
  float getY();
  
  void applyForce(PVector force);
}
