TextureGenerator generator;

void setup() {
  size(200,200);
  frameRate(10);
  generator = new PointsGenerator();
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

class PointsGenerator implements TextureGenerator {
  PImage generate() {
    PGraphics pg = createGraphics(30,30);
    pg.beginDraw();
    
    int i = 0;
    while (i < 10) {
      float x = random(0,pg.width);
      float y = random(0,pg.height);
      if (PVector.sub(new PVector(x,y),new PVector(pg.width/2,pg.height/2)).mag() <= 15) {
        pg.point(x,y);
        i++;
      }
    }
    
    pg.endDraw();
    return pg;
  }
}
