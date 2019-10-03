Blob blob;

void setup() {
  size(200,200);
  blob = new Blob();
}

void draw() {
  background(255);
  blob.update();
  blob.display();
}


class Blob {
  
  float tick = 0;
  
  void update() {
    tick++;
  }
  
  void display() {
    stroke(145);
    fill(175);
    ellipse(_getX(),_getY(),_getSize(),_getSize());
  }
  
  float _getX() {
    return map(noise(tick*0.02),0,1,0,width);
  }
  
  float _getY() {
    return map(noise(1e4+tick*0.02),0,1,0,height);
  }
  
  float _getSize() {
    float min = 20;
    float max = 33;
    return map(sin(tick*0.04),-1,1,min,max);
  }
}
