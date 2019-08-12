
int LOD = 4;
float FALLOFF = 0.75;
float INCR = 0.002;

color getColor(float r) {
  return color(r,1.0,1.0);
}

void setup() {
  size(640,640);
  //noiseSeed(0);
  noiseDetail(LOD,FALLOFF);
  colorMode(HSB,1.0);
  
  // paint the screen
  loadPixels(); // for 'pixels' usage
  int x, y;
  float xoff, yoff;
  yoff = 0;
  for (y=0; y<height; y++) {
    xoff = 0;
    for (x=0; x<width; x++) {
      pixels[y*width+x] = getColor(noise(xoff,yoff));
      xoff += INCR;
    }
    yoff += INCR;
  }
  updatePixels();
}
