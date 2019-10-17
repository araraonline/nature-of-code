class ParticleSystem {
  
  Particle[] particles;
  PVector location;
  
  ParticleSystem(float x, float y, float mult) {
    particles = new Particle[N_PARTICLES];
    for (int i = 0; i < particles.length; i++) {
      float angle = TWO_PI / particles.length * i;
      particles[i] = new Particle(angle,mult*angle);
    }
    
    location = new PVector(x,y);
  }
  
  void display() {
    pushMatrix();
    translate(location.x,location.y);
    for (Particle p: particles)
      p.display();
    popMatrix();
  }
  
  void update() {
    for (Particle p: particles)
      p.update();
  }
}
