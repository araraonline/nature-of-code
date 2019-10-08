import java.util.Iterator;

ParticleSystem ps;

void setup() {
  size(200,200);
  ps = new ParticleSystem(width/2,50);
}

void draw() {
  background(255);
  ps.run();
}

class ParticleSystem {
  
  ArrayList<Particle> particles;
  
  PVector location;
  PVector velocity;
  
  ParticleSystem(float x, float y) {
    particles = new ArrayList<Particle>();
    location = new PVector(x,y);
    velocity = new PVector(0,0);
  }
  
  void run() {
    _addParticle();
    _updateParticles();
    _updateOrigin();
  }
  
  void _addParticle() {
    particles.add(new Particle(location));
  }
  
  void _updateParticles() {
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.display();
      p.update();
      if (p.isDead())
        it.remove();
    }
  }
  
  void _updateOrigin() {
    PVector acceleration = _randomAcceleration();
    
    velocity.add(acceleration);
    velocity.limit(1.8);
    location.add(velocity);
    
    _bounceOrigin();
  }
  
  PVector _randomAcceleration() {
    PVector result = PVector.random2D();
    result.mult(0.03);
    return result;
  }
  
  void _bounceOrigin() {
    if (location.y < 0)      velocity.y =  abs(velocity.y);
    if (location.y > height) velocity.y = -abs(velocity.y);
    if (location.x < 0)      velocity.x =  abs(velocity.x);
    if (location.x > width)  velocity.x = -abs(velocity.x);
  }
}

class Particle {
  
  PVector location;
  PVector velocity = new PVector(random(-1,1),random(-2,-0.5));
  PVector acceleration = new PVector(0,0.05);
  
  float lifespan = 255;
  
  Particle(PVector location_) {
    location = location_.copy();
  }
  
  void display() {
    stroke(0,lifespan);
    fill(175,lifespan);
    ellipse(location.x,location.y,16,16);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2;
  }
  
  boolean isDead() {
    return lifespan < 0;
  }
}
