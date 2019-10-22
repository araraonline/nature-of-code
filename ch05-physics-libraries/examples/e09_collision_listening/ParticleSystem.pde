class ParticleSystem {
  
  Particle[] particles;
  int N = 12;
  
  ParticleSystem() {
    particles = new Particle[N];
    for (int i = 0; i < N; i++)
      particles[i] = new Particle(randomPixelLocation());
  }
  
  void applyForces() {
    for (int i = 0; i < N; i++) {
      Particle p0 = particles[i];
      for (int j = 0; j < N; j++) {
        if (i != j) {
          Particle p1 = particles[j];
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
