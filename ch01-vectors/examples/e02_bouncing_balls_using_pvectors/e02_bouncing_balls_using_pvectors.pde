PVector location = new PVector(100,100);
PVector speed = new PVector(1,3.3);

void setup() {
  size(200,200);
  // sketches are smooth by default
  background(255);
}

void draw() {
  background(255);
  
  // erase previous circle
  stroke(255);
  fill(255);
  ellipse(location.x,location.y,20,20);
  
  // move
  location.add(speed);
  
  // bounce
  if (location.x < 0 || location.x > width) {
    speed.x = speed.x * -1;
  }
  if (location.y < 0 || location.y > height) {
    speed.y = speed.y * -1;
  }
  
  // draw circle
  stroke(0);
  fill(175);
  ellipse(location.x,location.y,16,16);
}
