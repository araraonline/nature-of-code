TextureGenerator generator;

void setup() {
  size(200,200);
  frameRate(10);
  generator = new BackgroundGenerator();
}

void draw() {
  background(255);
  PImage img = generator.generate();
  imageMode(CENTER);
  image(img,width/2,height/2);
}

interface TextureGenerator {
  PImage generate();
}

class BackgroundGenerator implements TextureGenerator {
  PImage generate() {
    PGraphics pg = createGraphics(30,30);
    pg.beginDraw();
    pg.background(0);
    pg.endDraw();
    return pg;
  }
}
