void setup() {
  size(200,200);
}

void draw() {
  PVector center = new PVector(width/2,height/2);
  PVector mouse = new PVector(mouseX,mouseY);
  
  mouse.sub(center); // mouse got a new CRF (coord. ref. system)
  mouse.mult(0.5); // the length of the line is now half of its original size
  
  background(255);
  translate(center.x,center.y);
  line(0,0,mouse.x,mouse.y);
}
