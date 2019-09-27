Wave wave1, wave2;

void setup() {
  size(600,200);
  wave1 = new Wave(50,100,50,25,0.1,0.05);
  wave2 = new Wave(200,400,100,25,0.25,0.1);
}

void draw() {
  background(255);
  
  wave1.display();
  wave2.display();
  
  wave1.update();
  wave2.update();
}

class Wave {
  
  float startX, endX;
  float startY, amp;
  float pointOffset; // distance between each point when calculating sine (radians)
  float timeOffset; // angle distance between points across subsequent frames (radians)
  
  float _startAngle = 0;
  
  Wave(float startX_, float endX_, float startY_, float amp_, float pointOffset_, float timeOffset_) {
    startX = startX_;
    endX = endX_;
    startY = startY_;
    amp = amp_;
    pointOffset = pointOffset_;
    timeOffset = timeOffset_;
  }
  
  void display() {
    float angle = _startAngle;
    for (float x = startX; x <= endX; x += 6) {
      float g = map(sin(angle),-1,1,0,255);
      noStroke(); fill(g);
      rect(x,startY-amp,6,2*amp);
      
      angle += pointOffset;
    }
  }
  
  void update() {
    _startAngle += timeOffset;
  }
}
