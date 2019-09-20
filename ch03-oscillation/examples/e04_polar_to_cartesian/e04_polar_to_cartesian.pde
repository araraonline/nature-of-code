float r = 50;
float theta = 0;

void setup() {
  size(200,200);
}

void draw() {
  background(175);
  
  float x, y;
  x = r * cos(theta);
  y = r * sin(theta);
  
  translate(width/2,height/2);
  ellipse(x,y,16,16);
  
  theta += 0.03;
}
