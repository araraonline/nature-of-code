Oscillator[] oscillators;

void setup() {
  size(200,200);
  
  oscillators = new Oscillator[8];

  // longer legs (ampY=80)
  oscillators[0] = new Oscillator( 0,      0,50,80,0.082,0.08);
  oscillators[1] = new Oscillator(PI,      0,50,80,0.082,0.08); // xreflection
  oscillators[2] = new Oscillator( 0,HALF_PI,50,80,0.082,0.08);
  oscillators[3] = new Oscillator(PI,HALF_PI,50,80,0.082,0.08); // xreflection
  
  // shorter legs (ampY=80)
  oscillators[4] = new Oscillator( 0,      0,50,30,0.082,0.08);
  oscillators[5] = new Oscillator(PI,      0,50,30,0.082,0.08); // xreflection
  oscillators[6] = new Oscillator( 0,HALF_PI,50,30,0.082,0.08);
  oscillators[7] = new Oscillator(PI,HALF_PI,50,30,0.082,0.08); // xreflection
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
  
  Oscillator(float angleX, float angleY, float ampX, float ampY, float aVelX, float aVelY) {
    angle = new PVector(angleX,angleY);
    amplitude = new PVector(ampX,ampY);
    aVelocity = new PVector(aVelX,aVelY);
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
