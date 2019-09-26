Oscillator[] oscillators;

void setup() {
  size(200,200);
  background(255);
  oscillators = new Oscillator[10];
  for (int i = 0; i < oscillators.length; i++)
    oscillators[i] = new Oscillator();
}

void draw() {
  //background(255);
  for (int i = 0; i < oscillators.length; i++) {
    oscillators[i].update();
    oscillators[i].display();
  }
}

class Oscillator {
  
  PVector angle = new PVector(0,0);
  PVector velocity = new PVector(0,0);
  PVector amplitude = new PVector(random(width/2),random(height/2));
  
  void update() {
    PVector aAcceleration = _calcAcceleration();

    velocity.add(aAcceleration);
    velocity.limit(0.1);
    angle.add(velocity);
  }
  
  PVector _calcAcceleration() {
    return new PVector(1e-4,2e-4);
  }
  
  void display() {
    pushMatrix();
    translate(width/2,height/2);
    float x = amplitude.x * sin(angle.x);
    float y = amplitude.y * sin(angle.y);
    stroke(0); fill(175);
    //line(0,0,x,y);
    //ellipse(x,y,16,16);
    point(x,y);
    popMatrix();
  }
}
