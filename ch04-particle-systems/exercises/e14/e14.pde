import java.util.Iterator;
import java.util.Random;

Random generator;

ParticleSystem ps;
PImage img;
color[] bg;

void setup() {
  size(200,200);
  blendMode(BLEND); // replace mode here
  
  generator = new Random();
  
  ps = new ParticleSystem(width/2,50);
  img = loadImage("texture.png");;
  
  // generate background
  bg = new color[width*height];
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      bg[x+width*y] = color(random(256));
    }
  }
}

void draw() {
  _noisyBackground();
  ps.run();
}

void _noisyBackground() {
  loadPixels();
  for (int i = 0; i < bg.length; i++)
    pixels[i] = bg[i];
  updatePixels();
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
    tint(100,lifespan);
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
