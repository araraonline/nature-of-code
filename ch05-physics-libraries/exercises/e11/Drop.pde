class Drop implements Collidable {
  
  Body body;
  float x, y;
  float radius = 3;
  boolean broken = false; // drops "break" when they collide against anything other than a drop
  
  Drop(float x, float y) {
    this.x = x;
    this.y = y;
    _createBody();
    _attachShape();
  }
  
  void _createBody() {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(world.pixelLocationToWorldLocation(new Vec2(x,y)));
    bd.userData = this;
    body = world.createBody(bd);
  }
  
  void _attachShape() {
    CircleShape shape = new CircleShape();
    shape.m_radius = world.pixelDistanceToWorldDistance(radius);
    body.createFixture(shape,1);
  }
  
  void collide(Collidable other) {
    if (other.getClass() != Drop.class) {
      broken = true;
    }
  }
  
  void display() {
    Vec2 loc = getPixelLocation();
    float angle = getPixelAngle();
    
    pushMatrix();
    
    translate(loc.x,loc.y);
    rotate(angle);
    
    fill(0,0,255,127);
    stroke(0);
    
    rectMode(CENTER);
    ellipse(0,0,2*radius,2*radius);
    line(0,0,radius,0);
    
    popMatrix();
  }
  
  Vec2 getPixelLocation() {
    return world.worldLocationToPixelLocation(body.getPosition()); 
  }
  
  float getPixelAngle() {
    return world.worldAngleToPixelAngle(body.getAngle());
  }
}
