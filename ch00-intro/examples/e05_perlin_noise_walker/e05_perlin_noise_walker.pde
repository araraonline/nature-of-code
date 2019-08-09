Walker w;

class Walker {
  float x;
  float y;
  float t;
  
  Walker() {
    x = width/2;
    y = height/2;
  }
  
  void display() {
    stroke(0);
    noFill();
    ellipse(x,y,32,32);
  }
  
  void step() {
    x = map(noise(t,0),0,1,0,width);
    y = map(noise(t,10000),0,1,0,height);
    t += 0.005;
  }
}

void setup() {
  size(640,360);
  w = new Walker();
}

void draw() {
  background(175);
  w.step();
  w.display();
}
