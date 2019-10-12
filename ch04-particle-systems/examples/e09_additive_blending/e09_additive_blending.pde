import java.util.Iterator;
import java.util.Random;

Random generator;

ParticleSystem ps;
PImage img;

void setup() {
  size(200,200,P2D);
  
  generator = new Random();
  
  ps = new ParticleSystem(width/2,50);
  img = loadImage("texture.png");
}

void draw() {
  blendMode(ADD);
  background(0);
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
  PVector velocity = new PVector(0.3*gaussian(),0.3*gaussian()-1);
  PVector acceleration = new PVector(0,0.05);
  
  float lifespan = 255;
  
  Particle(PVector location_) {
    location = location_.copy();
  }
  
  void display() {
    tint(255,lifespan);
    imageMode(CENTER);
    image(img,location.x,location.y);
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

float gaussian() {
  return (float) generator.nextGaussian();
}
