Vec2[] ellipseToVertices(float x, float y, float w, float h, int N) {
  Vec2[] result = new Vec2[N];
  for (int i = 0; i < N; i++) {
    float angle = map(i,0,N,0,-TWO_PI); // counter-clockwise winding
    result[i] = new Vec2(cos(angle)*w/2.0+x,sin(angle)*h/2.0+y);
  }
  return result;
}
