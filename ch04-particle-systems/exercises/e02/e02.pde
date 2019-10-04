Particle particle;

void setup() {
  size(200,200);
  particle = new Particle();
}

void draw() {
  background(255);
  particle.display();
  
  if (particle.isDead())
    println("dead");
  
  PVector gravity = new PVector(0,0.05);
  particle.applyForce(gravity);
  particle.update();
}

class Particle {
  
  PVector location = new PVector(width/2,50);
  PVector velocity = new PVector(-0.8,-1);
  PVector acceleration = new PVector(0,0);
  
  float angle = radians(45);
  float aVelocity = 0.9;
  
  float lifespan = 255;
  
  void display() {
    pushMatrix();
    translate(location.x,location.y);
    rotate(angle);
    rectMode(CENTER);
    stroke(125,lifespan);
    strokeWeight(20); // oh yeh
    fill(150,lifespan);
    rect(0,0,22,13);
    popMatrix();
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration = new PVector(0,0);
    
    angle += aVelocity;
    
    lifespan -= 2;
  }
  
  boolean isDead() {
    return lifespan < 0;
  }
}
