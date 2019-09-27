Wave w1, w2, w3;
float startAngle = 0;

void setup() {
  size(200,200);
  w1 = new Wave(1);
  w2 = new Wave(2);
  w3 = new Wave(3);
}

void draw() {
  background(255);
  
  stroke(0);
  fill(175,175);
  
  float angle = startAngle;
  for (int x = 0; x <= width; x += 6) {
    float value = w1.calc(angle) + w2.calc(angle) + w3.calc(angle);
    float y = map(value,-3,3,0.8*height,0.2*height);
    ellipse(x,y,48,48);
    angle += 0.1;
  }
  startAngle += 0.03;
}

class Wave {
  
  float frequency;
  
  Wave(float frequency_) {
    frequency = frequency_;
  }
  
  float calc(float angle) {
    return sin(frequency*angle);
  }
}
