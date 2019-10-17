Particle[] particles;

float sign(float num) {
  if (num >= 0) return 1;
  else return -1;
}

void setup() {
  size(200,200);
  
  particles = new Particle[50];
  float time = 0;
  for (int i = 0; i < particles.length; i++) {
    float angle = TWO_PI / particles.length * i;
    time = -time + 0.2; // alternate 0 and 0.2
    particles[i] = new Particle(angle,time);
  }
}

void draw() {
  background(255);
  blendMode(DARKEST);
  
  for (Particle p: particles)
    p.display();
    
  for (Particle p: particles)
    p.update();
}

class Particle {
  
  float angle;
  float time;
  
  Particle(float angle_, float time_) {
    angle = angle_;
    time = time_;
  }
  
  void display() {
    pushMatrix();
    translate(width/2,height/2);
    rotate(angle);
    point(100*sin(time),0);
    popMatrix();
  }
  
  void update() {
    time += 0.015;
  }
}
