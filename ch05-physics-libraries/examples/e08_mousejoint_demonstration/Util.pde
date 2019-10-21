Vec2 getMousePixelLocation() {
  return new Vec2(mouseX,mouseY);
}

Vec2 getMouseWorldLocation() {
  return world.pixelLocationToWorldLocation(getMousePixelLocation());
}
