PVector location = new PVector(100,100,0);
PVector speed = new PVector(1,3.3,2.2);

void setup() {
  size(200,200,P3D);
  sphereDetail(10);
  background(175);
}

void draw() {
  background(175);
  
  // move
  location.add(speed);
  
  // bounce
  if (location.x < 0 || location.x > width) {
    speed.x = speed.x * -1;
  }
  if (location.y < 0 || location.y > height) {
    speed.y = speed.y * -1;
  }
  if (location.z < -75 || location.z > 75) {
    speed.z = speed.z * -1;
  }
  
  // draw box
  stroke(0);
  noFill();
  translate(100,100,0);
  box(width,height,150);
  translate(-100,-100,0);

  // draw sphere
  fill(175);
  translate(location.x,location.y,location.z);
  sphere(20);
}
