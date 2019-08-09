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
    noStroke();
    fill(200);
    float stepsize = noise(t)*20;
    square(x,y,stepsize);
    
    stroke(0);
    point(x,y);
  }
  
  void step() {
    float stepsize = noise(t)*20;
    float stepx = random(-stepsize,stepsize);
    float stepy = random(-stepsize,stepsize);
    
    x += stepx;
    y += stepy;
    t += 0.02;
  }
}

void setup() {
  size(640,360);
  w = new Walker();
  background(255);
  frameRate(10);
  rectMode(CENTER);
}

void draw() {
  background(255);
  w.display();
  w.step();
}
