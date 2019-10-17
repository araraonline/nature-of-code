class Particle {
  
  float angle;
  float time;
  
  Particle(float angle_, float time_) {
    angle = angle_;
    time = time_;
  }
  
  void display() {
    pushMatrix();
    rotate(angle);
    point(PARTICLE_AMPLITUDE*sin(time),0);
    popMatrix();
  }
  
  void update() {
    time += PARTICLE_SPEED;
  }
}
