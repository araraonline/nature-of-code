void setup() {
  size(200,200);
}

void draw() {
  PVector center = new PVector(width/2,height/2);
  PVector mouse = new PVector(mouseX,mouseY);
  
  mouse.sub(center); // mouse got a new CRF (coord. ref. system)
  mouse.normalize(); // mouse is now a unit vector
  mouse.mult(50); // ||mouse|| == 50
  
  background(255);
  translate(center.x,center.y);
  line(0,0,mouse.x,mouse.y);
}
