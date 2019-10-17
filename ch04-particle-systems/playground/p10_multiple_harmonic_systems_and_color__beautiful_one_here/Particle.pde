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
    colorMode(HSB,1);
    fill((0*angle+time)%TWO_PI/TWO_PI,1,1);
    noStroke();
    ellipse(PARTICLE_AMPLITUDE*sin(time),0,3,3);
    popMatrix();
  }
  
  void update() {
    time += PARTICLE_SPEED;
  }
}
