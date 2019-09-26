void setup() {
  size(200,200);
  
  background(255);
  stroke(0);
  fill(175,255/2);
  
  float angle = 0;
  for (int x = 0; x <= width; x += 24) {
    float y = map(sin(angle),-1,1,0,height);
    ellipse(x,y,48,48);
    angle += 0.4;
  }
}
