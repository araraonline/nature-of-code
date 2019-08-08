import java.util.Random;

Random generator;

void setup() {
  size(640,320);
  background(255);
  generator = new Random();
  splatter();
}

void splatter() {
  for (int i = 0; i < 2000; i++) {
    // choose location
    float x = width / 2 + (float) generator.nextGaussian() * 20;
    float y = height / 2 + (float) generator.nextGaussian() * 20;
    
    // choose color
    float gray = 140 + (float) generator.nextGaussian() * 25;
    
    // draw
    noStroke();
    fill(gray);
    ellipse(x,y,2,2);
  }
}
