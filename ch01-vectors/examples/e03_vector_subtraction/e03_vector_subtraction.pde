void draw() {
  PVector center = new PVector(width/2,height/2);
  PVector mouse = new PVector(mouseX,mouseY);
  
  mouse.sub(center); // mouse got a new CRF (coord. ref. system)
  
  background(255);
  translate(center.x,center.y);
  line(0,0,mouse.x,mouse.y);
}
