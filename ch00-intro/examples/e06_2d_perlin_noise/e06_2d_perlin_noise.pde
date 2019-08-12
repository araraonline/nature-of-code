void setup() {
  size(640,640);
  
  // paint the screen
  loadPixels(); // for 'pixels' usage
  int x, y;
  float xoff, yoff;
  yoff = 0;
  for (y=0; y<height; y++) {
    xoff = 0;
    for (x=0; x<width; x++) {
      int gray = int(map(noise(xoff,yoff),0,1,0,256));
      pixels[y*width+x] = color(gray);
      xoff += 0.01;
    }
    yoff += 0.01;
  }
  updatePixels();
}
