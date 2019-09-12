float angle = 0;
float W = 50;
float R = 1;

void setup() {
  size(200,200);
}

void draw() {
  background(175);
  
  translate(width/2,height/2);
  rotate(angle);
  line(-W/2,0,W/2,0);
  ellipse(-W/2-R,0,2*R,2*R);
  ellipse(W/2+R,0,2*R,2*R);
  
  angle = (angle + 0.03) % TWO_PI;
}
