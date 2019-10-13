import java.util.Iterator;
import java.util.Random;

// Base

Random generator;
ParticleSystem ps;
TextureGenerator tg;

void setup() {
  size(220,200,P2D);
  
  generator = new Random();
  ps = new ParticleSystem(width/2,height-20);
  tg = new TextureGenerator();
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
  PVector velocity = new PVector(0.3*gaussian(),0.2*gaussian());
  PVector acceleration = new PVector(0,-0.08);
  
  float lifespan = 255;
  
  PImage texture = tg.generate();
  
  Particle(PVector location_) {
    location = location_.copy();
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
