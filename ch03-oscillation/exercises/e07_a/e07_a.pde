Oscillator[] oscillators;

void setup() {
  size(200,200);
  
  float angleX = 0;
  float ampX = 0;
  float aVelX = 0.05;
  float angleY = 0;
  float ampY = 20;
  float aVelY = 0.02;
  
  oscillators = new Oscillator[16];
  for (int i = 0; i < oscillators.length; i++) {
    oscillators[i] = new Oscillator(angleX,angleY,ampX,aVelX,ampY,aVelY);
    ampX += width/2/oscillators.length;
    angleX += 0.15;
    angleY += 0.5;
  }
  
  
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
  
  Oscillator(float angleX, float angleY, float ampX, float aVelX, float ampY, float aVelY) {
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
    //line(0,0,x,y);
    ellipse(x,y,16,16);
    popMatrix();
  }
}
