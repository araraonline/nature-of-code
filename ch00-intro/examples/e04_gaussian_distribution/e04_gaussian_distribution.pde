import java.util.Random;

Random generator;

void setup() {
  size(640,320);
  generator = new Random();
}

void draw() {
  float num = (float) generator.nextGaussian();
  float mean = 320;
  float sd = 60;
  float x = num * sd + mean;
  noStroke();
  fill(255,10);
  ellipse(x,180,16,16);
}
