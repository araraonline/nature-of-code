void setup() {
  size(200,200);
}

void draw() {
  float x = width/2;
  float y = map(cos(TWO_PI*frameCount/120),-1,1,50,150);
  
  background(255);
  stroke(0);
  fill(175);
  line(x,0,x,y);
  ellipse(x,y,16,16);
}
