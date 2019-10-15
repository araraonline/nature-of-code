import java.util.Iterator;
import java.util.Random;

Random generator;

ParticleSystem ps;
PImage im1, im2, im3;

void setup() {
  size(200,200);
  
  generator = new Random();
  
  ps = new ParticleSystem(width/2,50);
  im1 = loadImage("text1.png"); im1.resize(30,30);
  im2 = loadImage("text2.png"); im2.resize(60,60);
  im3 = loadImage("text3.png"); im3.resize(16,16);
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
  
  PImage texture;

  float lifespan = 255;
  
  Particle(PVector location_) {
    location = location_.copy();
    texture = _randomTexture();
  }
  
  PImage _randomTexture() {
    float r = random(1);
    if (r < 0.333)
      return im1;
    else if (r < 0.666)
      return im2;
    else
      return im3;
  }
  
  void display() {
    tint(255,lifespan);
    imageMode(CENTER);
    image(texture,location.x,location.y);
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
