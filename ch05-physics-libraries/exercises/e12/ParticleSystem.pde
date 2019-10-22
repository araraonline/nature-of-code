class ParticleSystem {
  
  ArrayList<Particle> particles;
  int N = 9;
  
  ParticleSystem() {
    particles = new ArrayList<Particle>();
    for (int i = 0; i < N; i++)
      particles.add(new Particle(randomPixelLocation()));
  }
  
  void removeBrokenParticles() {
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      if (p.broken) {
        world.destroyBody(p.body);
        it.remove();
      }
    }
  }
  
  void applyForces() {
    for (int i = 0; i < particles.size(); i++) {
      Particle p0 = particles.get(i);
      for (int j = 0; j < particles.size(); j++) {
        if (i != j) {
          Particle p1 = particles.get(j);
          p0.applyForce(p0.attractedTo(p1));
        }
      }
    }
  }
  
  void display() {
    for (Particle p: particles)
      p.display();
  }
}
