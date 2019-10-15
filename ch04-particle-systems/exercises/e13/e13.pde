import java.util.Iterator;
import java.util.Random;

Random generator;

ParticleSystem ps;
PImage img;

void setup() {
  size(200,200,P2D);
  colorMode(HSB);
  
  generator = new Random();
  
  ps = new ParticleSystem(0,height);
  img = loadImage("texture.png"); img.resize(6,6);
}

void draw() {
  blendMode(BLEND); // it is not additive blending, nor the colors of the rainbow, but it's okay
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
  PVector velocity;
  PVector acceleration = new PVector(0,0.0049);
  
  float lifespan = 255;
  
  Particle(PVector location_) {
    location = location_.copy();
    velocity = PVector.fromAngle(radians(-42));
  }
  
  void display() {
    tint(lifespan,255,255);
    imageMode(CENTER);
    image(img,location.x,location.y);
    //fill(lifespan,255,255,127);
    //noStroke();
    //ellipse(location.x,location.y,16,16);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 0.9;
  }
  
  boolean isDead() {
    return lifespan < 0;
  }
}

float gaussian() {
  return (float) generator.nextGaussian();
}
