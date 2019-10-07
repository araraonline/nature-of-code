import java.util.Iterator;

ArrayList<Particle> particles;

void setup() {
  size(200,200);
  particles = new ArrayList<Particle>();
}

void draw() {
  background(255);
  
  Iterator<Particle> it = particles.iterator();
  Particle p;
  while (it.hasNext()) {
    p = it.next();
    p.display();
    p.update();
    if (p.isDead())
      it.remove();
  }
  
  particles.add(new Particle());
}

class Particle {
  
  PVector location = new PVector(width/2,50);
  PVector velocity = new PVector(random(-1,1),random(-2,-0.5));
  PVector acceleration = new PVector(0,0.05);
  
  float lifespan = 255;
  
  void display() {
    stroke(0,lifespan);
    fill(175,lifespan);
    ellipse(location.x,location.y,16,16);
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
