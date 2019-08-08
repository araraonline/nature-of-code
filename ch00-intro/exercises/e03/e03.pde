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
    float stepsize = random(1);
    float r = random(1);
    if (r < 0.5) {
      // move towards the mouse
      float dx = mouseX-x;
      float dy = mouseY-y;
      float dlength = sqrt(dx*dx+dy*dy);
      x += dx/dlength*stepsize;
      y += dy/dlength*stepsize;
    } else {
      // move in a random direction
      float angle = random(TWO_PI);
      x += cos(angle)*stepsize;
      y += sin(angle)*stepsize;
    }
  }
}

void setup() {
  size(640,360);
  w = new Walker();
  background(255);
}

void draw() {
  w.step();
  w.display();
}
