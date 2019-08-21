void setup() {
  size(100,100,P3D);
  background(0);
  sphereDetail(10);
  frameRate(10);
}

int depth = 0;
int speed = 1;

void draw() {
  background(0);
  
  // update depth
  if (depth == 20) speed = -1;
  if (depth == -20) speed = 1;
  depth += speed;
  
  // draw
  translate(50,50,depth);
  sphere(20); 
  
  // print
  println(depth);
}
