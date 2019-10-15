import java.util.Iterator;
import java.util.Random;

// Base

Random generator;
ParticleSystem ps;
TextureGenerator tg;

void setup() {
  size(220,200,P2D);
  
  generator = new Random();
  ps = new ParticleSystem(width/2,height/2);
  tg = new TextureGenerator();
}

void draw() {
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
  PVector acceleration = new PVector(0,0);
  
  float lifespan = 255;
  
  PImage texture = tg.generate();
  
  Particle(PVector location_) {
    location = location_.copy();
    velocity = PVector.random2D();
    velocity.mult(random(0,1));
  }
  
  void display() {
    imageMode(CENTER);
    image(texture,location.x,location.y);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 1;
  }
  
  boolean isDead() {
    return lifespan < 0;
  }
}

class TextureGenerator {
  PImage generate() {
    PGraphics pg = createGraphics(50,50);
    pg.beginDraw();
    
    int i = 0;
    while (i < 10) {
      float x = random(0,pg.width);
      float y = random(0,pg.height);
      if (PVector.sub(new PVector(x,y),new PVector(pg.width/2,pg.height/2)).mag() <= 25) {
        pg.stroke(255);
        pg.fill(255);
        pg.point(x,y);
        i++;
      }
    }
    
    pg.endDraw();
    return pg;
  }
}

float gaussian() {
  return (float) generator.nextGaussian();
}
