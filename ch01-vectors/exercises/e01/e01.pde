void setup() {
  size(640,640);
  
  PVector location = new PVector(0,0);
  PVector offset = new PVector(0,0);
  
  loadPixels();
  while (location.y < height) {
    
    // single line
    location.x = 0;
    offset.x = 0;
    while (location.x < width) {
      float r = noise(offset.x,offset.y);
      pixels[int(location.x+width*location.y)] = color(map(r,0,1,0,256));
      location.x += 1;
      offset.x += 0.01;
    }

    location.y += 1;
    offset.y += 0.01;
  }
  updatePixels();
}
