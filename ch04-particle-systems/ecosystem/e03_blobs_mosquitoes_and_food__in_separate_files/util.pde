boolean circleContains(PVector center, float radius, PVector point) {
  return PVector.sub(center,point).mag() <= radius;
}

PVector sumVectors(PVector[] vs) {
  PVector result = new PVector(0,0);
  for (PVector v: vs)
    result.add(v);
  return result;
}
