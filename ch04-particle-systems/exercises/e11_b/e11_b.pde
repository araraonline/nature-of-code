import java.util.Iterator;
import java.util.Random;

// Base

Random generator;
ParticleSystem ps;
TextureGenerator tg;

void setup() {
  size(200,200,P2D);
  
  generator = new Random();
  ps = new ParticleSystem(width/2,height*3/4);
  tg = new TextureGenerator();
}

void draw() {
  blendMode(ADD);
  background(25);
  
  ForceGenerator[] fgs = {new FireForce(-0.08)};
  ps.run(fgs);
}

class ParticleSystem {
  
  ArrayList<Particle> particles;
  
  PVector location;
  
  ParticleSystem(float x, float y) {
    particles = new ArrayList<Particle>();
    location = new PVector(x,y);
  }
  
  void run(ForceGenerator[] fGenerators) {
    _addParticle();
    _updateParticles(fGenerators);
  }
  
  void _addParticle() {
    particles.add(new Particle(location));
  }

  void _updateParticles(ForceGenerator[] outerFGenerators) {
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      if (p.isAlive()) {
        ForceGenerator[] innerFGenerators = _getOtherParticles(p);
        ForceGenerator[] fGenerators = (ForceGenerator[]) concat(outerFGenerators,innerFGenerators);
        p.update(fGenerators);
        p.display();
      } else {
        it.remove();
      }
    }
  }
  
  Particle[] _getOtherParticles(Particle p) {
    Particle[] result = new Particle[particles.size()-1];
    int i = 0;
    for (Particle other: particles) {
      if (p != other) {
        result[i] = other;
        i++;
      }
    }
    return result;
  }
}

class Particle implements ForceGenerator {
  
  PVector location;
  PVector velocity = new PVector(0,0.05*gaussian());
  
  float lifespan = 255;
  
  PImage texture = tg.generate();
  
  Particle(PVector location_) {
    location = location_.copy();
  }
  
  PVector forceOn(Particle other) {
    // attract the other particle
    PVector displacement = PVector.sub(location,other.location);
    float distance = displacement.mag();
    distance = constrain(distance,100,500);
    
    PVector result = displacement.copy();
    result.setMag(3/(distance*distance));
    return result;
  }
  
  void display() {
    tint(255,127,20,lifespan);
    imageMode(CENTER);
    image(texture,location.x,location.y);
  }
  
  void update(ForceGenerator[] fGenerators) {
    PVector acceleration = new PVector(0,0);
    for (ForceGenerator fgen: fGenerators)
      acceleration.add(fgen.forceOn(this)); // assume mass = 1
    
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 5.7;
  }
  
  boolean isAlive() {
    return lifespan > 0;
  }
}


interface ForceGenerator {
  PVector forceOn(Particle particle);
}

class FireForce implements ForceGenerator {
  
  float G;
  
  FireForce(float G_) {
    G = G_;
  }
  
  PVector forceOn(Particle particle) {
    return new PVector(0,G);
  }
}

class TextureGenerator {
  
  PImage base;
  
  TextureGenerator() {
    base = loadImage("base.png");
    base.loadPixels();
  }
  
  PImage generate() {
    // generate a texture based on Perlin noise
    
    noiseSeed(int(random(1000)));
    
    int[] baseMask = _loadBaseMask();
    int[] noiseMask = _generateNoiseMask();
    int[] combined = _combineMasks(baseMask,noiseMask);
    
    return _createTextureFromAlphaLayer(combined);
  }
  
  int[] _loadBaseMask() {
    int[] result = new int[base.pixels.length];
    for (int i = 0; i < base.pixels.length; i++)
      result[i] = (base.pixels[i] >> 24) & 0xFF; // extract alpha from color
    return result;
  }
  
  int[] _generateNoiseMask() {
    int[] result = new int[base.pixels.length];
    float xoff = 0;
    for (int x = 0; x < base.width; x++) {
      float yoff = 0;
      for (int y = 0; y < base.height; y++) {
        result[x+base.width*y] = int(map(noise(xoff,yoff),0,1,0,256));
        yoff += 0.15;
      }
      xoff += 0.15;
    }
    return result;
  }
  
  int[] _combineMasks(int[] mask1, int[] mask2) {
    int[] result = new int[mask1.length];
    for (int i = 0; i < mask1.length; i++) {
      float v1 = map(mask1[i],0,255,0,1);
      float v2 = map(mask2[i],0,255,0,1);
      result[i] = int(map(v1*v2,0,1,0,256));
    }
    return result;
  }
  
  PGraphics _createTextureFromAlphaLayer(int[] alpha) {
    PGraphics pg;
    
    pg = createGraphics(base.width,base.height);
    pg.beginDraw();
    pg.background(255);
    pg.mask(alpha);
    pg.endDraw();
    
    return pg;
  }
}

float gaussian() {
  return (float) generator.nextGaussian();
}
