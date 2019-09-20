float r = 0;
float theta = 0;

void setup() {
  size(200,200);
}

void draw() {
  float x, y;
  x = r * cos(theta);
  y = r * sin(theta);
  
  translate(width/2,height/2);
  noStroke();
  fill(0);
  ellipse(x,y,4,4);
  
  r += 0.1;
  theta += 0.03;
}
