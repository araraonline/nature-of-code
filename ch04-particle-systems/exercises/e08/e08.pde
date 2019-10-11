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
  
  ParticleSystem(float x, float y) {
    particles = new ArrayList<Particle>();
    location = new PVector(x,y);
  }
  
  void run() {
    _addParticle();
    _updateParticles();
  }
  
  void _addParticle() {
    float r = random(0,1);
    if (r < 0.85) particles.add(new Orbiter(location));
    if (r < 0.2) particles.add(new FallingHair(location));
    if (r < 0.4) particles.add(new Bullet(location));
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
}

interface Particle {
  void display();
  void update();
  boolean isDead();
}

class Orbiter implements Particle {
  
  PVector center;
  float radius = 0;
  float angle = 0;
  
  float lifespan = 255;
  
  Orbiter(PVector center_) {
    center = center_;
  }
  
  void display() {
    PVector location = _getLocation();
    
    fill(175,lifespan);
    stroke(0,lifespan);
    rectMode(CENTER);
    rect(location.x,location.y,9,9);
  }
  
  void update() {
    radius += 0.2;
    radius = constrain(radius,0,25);
    
    angle -= 0.2; // counter clockwise
    
    lifespan -= 1;
  }
  
  boolean isDead() {
    return lifespan < 0;
  }
  
  PVector _getLocation() {
    PVector result = PVector.fromAngle(angle);
    result.mult(radius);
    result.add(center);
    return result;
  }
}

abstract class FallingParticle implements Particle {
  
  // a particle that falls and dies
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float lifespan = 255;
  
  FallingParticle(PVector location_, PVector velocity_, PVector acceleration_) {
    location = location_.copy();
    velocity = velocity_.copy();
    acceleration = acceleration_.copy();
  }
  
  abstract void display();
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 1;
  }
  
  boolean isDead() {
    return lifespan < 0;
  }
}

class FallingHair extends FallingParticle {
  
  FallingHair(PVector location_) {
    super(
      location_,
      new PVector(random(-1.5,1.5),random(-2,-0.5)),
      new PVector(0,0.03)
    );
  }
  
  void display() {
    // side and height of equilateral triangle
    float s = 9;
    float h = sqrt(3) * s / 2;
    
    pushMatrix();
    translate(location.x, location.y);
    fill(175,lifespan);
    stroke(0,lifespan);
    triangle(-s/2,h/3,0,-2*h/3,s/2,h/3);
    popMatrix();
  }
}

class Bullet extends FallingParticle {
  
  Bullet(PVector location_) {
    super(
      location_,
      new PVector(random(3.5,4.0)*randomSign(),random(-4.0,-0.3)),
      new PVector(0,0.005)
    );
  }
  
  int _randomDirection() {
    if (random(0,1) < 0.5)
      return -1;
    else
      return 1;
  }
  
  void display() {
    float gray = map(lifespan,0,255,-160,255); // "disappear" earlier
    fill(175,gray);
    stroke(0,gray);
    ellipse(location.x,location.y,9,9);
  }
}

int randomSign() {
  if (random(0,1) < 0.5)
    return -1;
  else
    return 1;
}
