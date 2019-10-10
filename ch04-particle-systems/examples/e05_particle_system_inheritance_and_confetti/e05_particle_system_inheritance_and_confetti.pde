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
    if (random(0,1) < 0.5)
      particles.add(new Particle(location));
    else
      particles.add(new Confetti(location));
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
    ellipse(location.x,location.y,8,8);
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

class Confetti extends Particle {
  
  Confetti(PVector location_) {
    super(location_);
  }
  
  void display() {
    float theta = map(location.x,0,width,0,4*PI);
    
    pushMatrix();
    translate(location.x,location.y);
    rotate(theta);
    rectMode(CENTER);
    stroke(0,lifespan);
    fill(175,lifespan);
    rect(0,0,8,8);
    popMatrix();
  }
}
