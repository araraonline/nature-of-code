float startPosition = 0;

void setup() {
  size(200,200);
}

void draw() {
  background(255);
  
  stroke(0);
  fill(175,255/2);
  
  float pos = startPosition;
  for (int x = 0; x <= width; x += 4) {
    float y = map(noise(pos),0,1,0,height);
    ellipse(x,y,4,4);
    pos += 0.04;
  }
  
  startPosition += 0.008;
}
