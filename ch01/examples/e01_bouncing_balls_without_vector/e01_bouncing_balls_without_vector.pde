float x = 100;
float y = 100;
float speedx = 1;
float speedy = 3.3;

void setup() {
  size(200,200);
  // sketches are smooth by default
  background(255);
}

void draw() {
  background(255);
  
  // move
  x += speedx;
  y += speedy;
  
  // bounce
  if (x < 0 || x > width) {
    speedx = speedx * -1;
  }
  if (y < 0 || y > height) {
    speedy = speedy * -1;
  }
  
  // draw circle
  stroke(0);
  fill(175);
  ellipse(x,y,16,16);
}
