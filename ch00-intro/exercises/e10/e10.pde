int WIDTH = 20;
int DEPTH = 10;
float SCALE_AT_MIN_DEPTH = 0.95;
float SCALE_AT_MAX_DEPTH = 0.75;
float NOISE_INC = 0.05;
int OPACITY = 205;

void setup() {
  size(320,320);
  background(255);
  noiseSeed(1);
  new NoiseLandscape(WIDTH,DEPTH).draw();
}

class NoiseLandscape {
  
  int lwidth, ldepth;
  LPoint[] points;
  
  NoiseLandscape(int _width, int _depth) {
    lwidth = _width;
    ldepth = _depth;
    generatePoints();
  }
  
  void generatePoints() {
    points = new LPoint[lwidth*ldepth];
    for (int depth = 0; depth < ldepth; depth++) {
      for (int x = 0; x < lwidth; x++) {
        float elev = noise(x*NOISE_INC,depth*NOISE_INC);
        points[depth*lwidth+x] = new LPoint(x,depth,elev);
      }
    }
  }
  
  void draw() {
    // we want to draw closer shapes last
    for (int depth = ldepth-1; depth >= 1; depth--) {
      for (int x = 0; x < lwidth-1; x++) {
        LPoint p0 = points[depth*lwidth+x];
        LPoint p1 = points[depth*lwidth+x+1];
        LPoint p2 = points[depth*lwidth+x+1-lwidth];
        LPoint p3 = points[depth*lwidth+x+1-lwidth-1];
        
        stroke(0);
        fill(175,OPACITY);
        quad(
          p0.screenX, p0.screenY,
          p1.screenX, p1.screenY,
          p2.screenX, p2.screenY,
          p3.screenX, p3.screenY
        );
      }
    }
  }

}

class LPoint {
  
  float screenX, screenY;
  
  LPoint(int x, int depth, float elev) {
    BBox bbox = new BBox(depth);
    screenX = map(x,0,WIDTH-1,bbox.left,bbox.right);
    screenY = map(elev,0,1,bbox.bottom,bbox.top);
  }
}

class BBox {
  
  int depth;
  float scale;
  float left, right, bottom, top;
  
  BBox(int _depth) {
    depth = _depth;
    calculateScale();
    calculateWidthCoords();
    calculateHeightCoords();
  }
  
  void calculateScale() {
    float depthRatio = (float) depth / (float) (DEPTH-1);
    scale = map(depthRatio,1,0,SCALE_AT_MAX_DEPTH,SCALE_AT_MIN_DEPTH);
  }
  
  void calculateWidthCoords() {
    float scaledWidth = scale*width;
    float marginSize = (width-scaledWidth)/2;
    left = marginSize;
    right = left+scaledWidth;
  }
  
  void calculateHeightCoords() {
    float scaledHeight = scale*height;
    top = height-scaledHeight;
    bottom = height;
  }
}
