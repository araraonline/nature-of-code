Shards s;

void setup() {
  size(200,200);
  s = new Shards();
}

void draw() {
  background(255);
  
  if (frameCount < 2*60) {
    stroke(0);
    fill(255);
    ellipse(width/2,height/2,100,100);
  } else {
    s.update();
    s.display();
  }
}

class Shards {
  
  Particle[] particles = new Particle[1000];
  
  PVector center = new PVector(width/2,height/2);
  float radius = 50;
  
  Shards() {
    _initializeParticles();
  }
  
  void _initializeParticles() {
    PVector location;
    float lifespan;
    float lifespeed;
    
    for (int i = 0; i < particles.length; i++) {
      location = _randomLocation();
      lifespan = random(0,255);
      lifespeed = random(3,12);
      particles[i] = new Particle(location,lifespan,lifespeed);
    }
  }
   
  PVector _randomLocation() {
    PVector choice;
    do {
      choice = new PVector(
        random(center.x-radius,center.x+radius),
        random(center.y-radius,center.y+radius)
      );
    } while (PVector.sub(choice,center).mag() > radius);
    return choice;
  }
  
  void update() {
    for (Particle p: particles)
      p.update();
  }
  
  void display() {
    for (Particle p: particles)
      p.display();
  }
}

class Particle {
  
  PVector location;
  float lifespan;
  float lifespeed;
  
  Particle(PVector location_, float lifespan_, float lifespeed_) {
    location = location_;
    lifespan = lifespan_;
    lifespeed = lifespeed_;
  }
  
  void update() {
    lifespan -= lifespeed;
  }
  
  void display() {
    noStroke();
    fill(175,lifespan);
    ellipse(location.x,location.y,6,6);
  }
}
