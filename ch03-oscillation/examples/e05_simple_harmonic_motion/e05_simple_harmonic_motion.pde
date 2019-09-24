void setup() {
  size(200,200);
}

void draw() {
  float period = 120;
  float amplitude = 100;
  
  float x = amplitude * cos(TWO_PI * frameCount / period);
  
  background(255);
  
  translate(width/2,height/2);
  stroke(0);
  fill(175);
  line(0,0,x,0);
  ellipse(x,0,16,16);
}
