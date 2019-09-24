Oscillator[] oscillators;

void setup() {
  size(200,200);
  oscillators = new Oscillator[10];
  for (int i = 0; i < oscillators.length; i++)
    oscillators[i] = new Oscillator();
}

void draw() {
  background(255);
  for (int i = 0; i < oscillators.length; i++) {
    oscillators[i].update();
    oscillators[i].display();
  }
}

class Oscillator {
  
  PVector angle;
  PVector aVelocity;
  PVector amplitude;
  
  Oscillator() {
    angle = new PVector(0,0);
    aVelocity = new PVector(random(-0.05,0.05),random(-0.05,0.05));
    amplitude = new PVector(random(width/2),random(height/2));
  }
  
  void update() {
    angle.x += aVelocity.x;
    angle.y += aVelocity.y;
  }
  
  void display() {
    pushMatrix();
    translate(width/2,height/2);
    float x = amplitude.x * sin(angle.x);
    float y = amplitude.y * sin(angle.y);
    stroke(0); fill(175);
    line(0,0,x,y);
    ellipse(x,y,16,16);
    popMatrix();
  }
}
