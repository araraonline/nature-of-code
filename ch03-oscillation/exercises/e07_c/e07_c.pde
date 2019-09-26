Oscillator[] oscillators;

/* Oh Jesus motherfucker, what did I create? */

void setup() {
  size(200,200);
  
  oscillators = new Oscillator[100];
  float phaseY = 0;
  for (int i = 0; i < oscillators.length; i++) {
    float phaseX = map(i,0,oscillators.length-1,0,TWO_PI);
    oscillators[i] = new Oscillator(phaseX,phaseY,75,50,0.025,0.125);
    phaseY += PI/14;
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
    //line(0,0,x,y);
    ellipse(x,y,16,16);
    popMatrix();
  }
}
