void setup() {
  size(200,200);
}

void draw() {
  PVector center = new PVector(width/2,height/2);
  PVector mouse = new PVector(mouseX,mouseY);
  
  mouse.sub(center); // mouse got a new CRF (coord. ref. system)
  float m = mouse.mag();
  
  background(255);
  
  // draw magnitude-sized bar
  fill(0);
  rect(0,0,m,10);
  
  // draw line
  translate(center.x,center.y);
  line(0,0,mouse.x,mouse.y);
}
