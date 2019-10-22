class Mover implements Collidable {
  
  Body body;
  float x = random(0,width);
  float y = random(0,height);
  float radius = 20;
  float time = random(1e4);
  float blueness = 0;
  
  Mover() {
    _createBody();
    _attachShape();
  }
  
  void _createBody() {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.KINEMATIC;
    bd.position.set(world.pixelLocationToWorldLocation(new Vec2(x,y)));
    bd.userData = this;
    body = world.createBody(bd);
  }
  
  void _attachShape() {
    CircleShape shape = new CircleShape();
    shape.m_radius = world.pixelDistanceToWorldDistance(radius);
    body.createFixture(shape,1);
  }
  
  void update() {
    blueness = constrain(blueness-0.25,0,255);
    time += 0.01;
    _updateVelocity();
  }
  
  void _updateVelocity() {
    // calculate direction
    Vec2 loc = getWorldLocation();
    Vec2 target = getWorldTargetLocation();
    Vec2 diff = target.sub(loc);
    
    // calculate speed
    float SPEED_MULTIPLIER = 20;
    float MAX_SPEED = 15;
    float speed = constrain(diff.length()*diff.length() * SPEED_MULTIPLIER,0,MAX_SPEED);
    
    // set to body
    Vec2 velocity = diff.clone();
    velocity.normalize();
    velocity.mulLocal(speed);
    body.setLinearVelocity(velocity);
  }
  
  void collide(Collidable other) {
    if (other.getClass() == Drop.class) {
      blueness = constrain(blueness+2,0,255);
    }
  }
  
  void display() {
    _drawCircle();
    _drawTarget();
  }
  
  void _drawCircle() {
    Vec2 loc = getPixelLocation();
    float angle = getPixelAngle();
    
    pushMatrix();
    
    translate(loc.x,loc.y);
    rotate(angle);
    
    fill(0,0,255,blueness);
    stroke(0);
    
    rectMode(CENTER);
    ellipse(0,0,2*radius,2*radius);
    
    popMatrix();
  }
  
  void _drawTarget() {
    stroke(0);
    Vec2 loc = getPixelLocation();
    Vec2 t = getPixelTargetLocation();
    line(loc.x,loc.y,t.x,t.y);
  }
  
  Vec2 getPixelLocation() {
    return world.worldLocationToPixelLocation(getWorldLocation()); 
  }
  
  Vec2 getWorldLocation() {
    return body.getPosition(); 
  }
  
  float getPixelAngle() {
    return world.worldAngleToPixelAngle(getWorldAngle());
  }
  
  float getWorldAngle() {
    return body.getAngle();
  }
  
  Vec2 getPixelTargetLocation() {
    float x = map(noise(time),     0,1,0,width);
    float y = map(noise(time+1000),0,1,0,height);
    return new Vec2(x,y);
  }
  
  Vec2 getWorldTargetLocation() {
    return world.pixelLocationToWorldLocation(getPixelTargetLocation());
  }
  
  boolean containsPixelLocation(Vec2 loc) {
    return containsWorldLocation(world.pixelLocationToWorldLocation(loc));
  }
  
  boolean containsWorldLocation(Vec2 loc) {
    return body.getFixtureList().testPoint(loc); // Fixture is implemented as a linked list
                                                 // getFixtureList() returns the Fixture most recently added to the object
  }
}
