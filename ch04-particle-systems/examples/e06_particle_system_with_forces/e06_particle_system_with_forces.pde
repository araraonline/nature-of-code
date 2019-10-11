import java.util.Iterator;

ParticleSystem ps;

void setup() {
  size(200,200);
  ps = new ParticleSystem(width/2,50);
}

void draw() {
  background(255);
  PVector[] forces = {
    new PVector(0,0.05) // gravity
  };
  ps.run(forces);
}

class ParticleSystem {
  
  ArrayList<Particle> particles;
  
  PVector location;
  
  ParticleSystem(float x, float y) {
    particles = new ArrayList<Particle>();
    location = new PVector(x,y);
  }
  
  void run(PVector[] forces) {
    _addParticle();
    _updateParticles(forces);
  }
  
  void _addParticle() {
    particles.add(new Particle(location));
  }
  
  void _updateParticles(PVector[] forces) {
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.display();
      p.update(forces);
      if (p.isDead())
        it.remove();
    }
  }
}

class Particle {
  
  PVector location;
  PVector velocity = new PVector(random(-1,1),random(-2,-0.5));
  
  float lifespan = 255;
  
  Particle(PVector location_) {
    location = location_.copy();
  }
  
  void display() {
    stroke(0,lifespan);
    fill(175,lifespan);
    ellipse(location.x,location.y,16,16);
  }
  
  void update(PVector[] forces) {
    velocity.add(addVectors(forces));
    location.add(velocity);
    lifespan -= 2;
  }
  
  boolean isDead() {
    return lifespan < 0;
  }
}

PVector addVectors(PVector[] vectors) {
  PVector result = new PVector(0,0);
  for (PVector vector: vectors)
    result.add(vector);
  return result;
}
