class Wall implements Collidable {
  
  Body body;
  
  Vec2 center;
  Vec2 dimensions;
  
  Wall(Vec2 center, Vec2 dimensions) {
    this.center = center;
    this.dimensions = dimensions;
    
    _createBody();
    _attachShapeToBody();
  }
  
  void _createBody() {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(world.pixelLocationToWorldLocation(center));
    bd.userData = this;
    body = world.createBody(bd);
  }
  
  void _attachShapeToBody() {
    PolygonShape shape = new PolygonShape();
    shape.setAsBox(
      world.pixelDistanceToWorldDistance(dimensions.x)/2,
      world.pixelDistanceToWorldDistance(dimensions.y)/2
    );
    body.createFixture(shape,100);
  }
  
  void collide(Collidable other) {
    // NOOP
  }
  
  void display() {
    noStroke();
    fill(50);
    
    rectMode(CENTER);
    rect(center.x,center.y,dimensions.x,dimensions.y);
  }
}
