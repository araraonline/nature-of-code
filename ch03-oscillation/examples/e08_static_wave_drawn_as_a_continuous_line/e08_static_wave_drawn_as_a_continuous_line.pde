void setup() {
  size(200,200);
  
  background(255);
  stroke(0);
  noFill();
  
  beginShape();
  float angle = 0;
  for (int x = 0; x <= width; x += 2) {
    float y = map(sin(angle),-1,1,0,height);
    vertex(x,y);
    angle += 0.15;
  }
  endShape();
}
