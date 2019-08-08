import java.util.Random;

Random generator;
Walker w;

class Walker {
  float x;
  float y;
  
  Walker() {
    x = width/2;
    y = height/2;
  }
  
  void display() {
    stroke(0);
    point(x,y);
  }
  
  void step() {
    float stepx = (float) generator.nextGaussian();
    float stepy = (float) generator.nextGaussian();
    x += stepx;
    y += stepy;
  }
}

void setup() {
  size(640,360);
  background(255);
  generator = new Random();
  w = new Walker();
}

void draw() {
  w.step();
  w.display();
}
