
int LOD = 4;
float FALLOFF = 0.75;
float INCR = 0.002;
float TIME_INCR = 0.02;

float time = 0.0;

color getColor(float r) {
  colorMode(HSB,1.0);
  return color(r,1.0,10);
}

void setup() {
  size(640,640);
  noiseDetail(LOD,FALLOFF);
}

void draw() {
  int x, y;
  float xoff, yoff;
  loadPixels();
  yoff = 0;
  for (y=0; y<height; y++) {
    xoff = 0;
    for (x=0; x<width; x++) {
      pixels[y*width+x] = getColor(noise(xoff,yoff,time));
      xoff += INCR;
    }
    yoff += INCR;
  }
  updatePixels();

  time += TIME_INCR;
}
