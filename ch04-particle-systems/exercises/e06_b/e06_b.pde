Glass[] glasses;

void setup() {
  size(200,200);
  glasses = new Glass[9];
  for (int i = 0; i < glasses.length; i++)
    glasses[i] = new Glass();
}

void draw() {
  background(255);
  for (int i = 0; i < glasses.length; i++)
    glasses[i].run();
}

void mouseClicked() {
  PVector location = new PVector(mouseX,mouseY);
  for (int i = 0; i < glasses.length; i++)
    if (glasses[i].contains(location))
      glasses[i].shatter();
}

class Glass {
  
  Shards shards; // not used until glass is broken
  
  PVector center = new PVector(random(0,width),random(0,height));
  float radius = random(18,27);
  
  boolean broken = false;
  
  Glass() {
    shards = new Shards(center,radius);
  }
  
  void run() {
    if (!broken) {
      _displayGlass();
    } else {
      _displayShards();
      _updateShards();
    }
  }
  
  void shatter() { // `break` is taken
    broken = true;
  }
  
  boolean contains(PVector point) {
    return PVector.sub(point,center).mag() <= radius;
  }
  
  void _updateShards() {
    shards.update();
  }
  
  void _displayGlass() {
    stroke(0);
    fill(255);
    ellipse(center.x,center.y,2*radius,2*radius);
  }
  
  void _displayShards() {
    shards.display();
  }
}

class Shards {
  
  Particle[] particles;
  
  PVector center;
  float radius;
  
  Shards(PVector center_, float radius_) {
    center = center_;
    radius = radius_;
    _initializeParticles();
  }
  
  void _initializeParticles() {
    particles = new Particle[int(0.4*radius*radius)]; // number of particles proportional to the area
    
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
