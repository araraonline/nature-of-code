import java.util.Iterator;

ArrayList<ParticleSystem> systems;

void setup() {
  size(200,200);
  systems = new ArrayList<ParticleSystem>();
}

void draw() {
  background(255);
  
  Iterator<ParticleSystem> it = systems.iterator();
  while (it.hasNext()) {
    ParticleSystem system = it.next();
    system.run();
    if (system.isDead()) {
      it.remove();
    }
  }
  
}

void mouseClicked() {
  systems.add(new ParticleSystem(mouseX,mouseY));
}

class ParticleSystem {
  
  ArrayList<Particle> particles;
  int particlesLeft; // to create
  
  PVector location;
  
  ParticleSystem(float x, float y) {
    particles = new ArrayList<Particle>();
    particlesLeft  = 50;
    location = new PVector(x,y);
  }
  
  void run() {
    if (particlesLeft > 0) {
      _addParticle();
      particlesLeft--;
    }
    _updateParticles();
  }
  
  boolean isDead() {
    return (particles.size() == 0 && particlesLeft == 0);
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
