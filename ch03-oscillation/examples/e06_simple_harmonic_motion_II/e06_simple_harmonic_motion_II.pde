float angle = 0;
float aVelocity = 0.05;

void setup() {
  size(200,200);
}

void draw() {
  float x = 100 * cos(angle);
  angle += aVelocity;
  
  background(255);

  translate(width/2,height/2);
  stroke(0);
  fill(175);
  line(0,0,x,0);
  ellipse(x,0,16,16);
}
