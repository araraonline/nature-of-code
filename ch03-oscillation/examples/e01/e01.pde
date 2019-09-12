float W = 50;
float R = 1;
float MAX_SPEED = 1;

float angle;
float aVelocity;
float aAcceleration;

void setup() {
  size(200,200);
  
  angle = 0;
  aVelocity = 0;
  aAcceleration = 0.0015;
}

void draw() {
  background(175);
  
  translate(width/2,height/2);
  rotate(angle);
  line(-W/2,0,W/2,0);
  ellipse(-W/2-R,0,2*R,2*R);
  ellipse(W/2+R,0,2*R,2*R);
  
  aVelocity += aAcceleration;
  aVelocity = constrain(aVelocity,0,MAX_SPEED);
  angle += aVelocity;
}
