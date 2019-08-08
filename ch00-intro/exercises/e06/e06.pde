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
    float stepsize = montecarlo()*10;
    
    float stepx = random(-stepsize,stepsize);
    float stepy = random(-stepsize,stepsize);
    
    x += stepx;
    y += stepy;
  }
}

void setup() {
  size(640,360);
  background(255);
  w = new Walker();
}

void draw() {
  w.step();
  w.display();
}

float montecarlo() {
  while (true) {
    float r1 = random(1);
    float prob = r1*r1;
    float r2 = random(1);
    if (r2 < prob) {
      return r1;
    }
  }
}
