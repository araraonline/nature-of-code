class Particle {
  
  Body body;
  boolean collided = false;
  
  float radius = 4;
  
  Particle(Vec2 pixelLocation) {
    _createBody(pixelLocation);
    _attachShape();
  }
  
  void _createBody(Vec2 pixelLocation) {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(world.pixelLocationToWorldLocation(pixelLocation));
    bd.userData = this;
    body = world.createBody(bd);
  }
  
  void _attachShape() {
    CircleShape shape = new CircleShape();
    shape.m_radius = world.pixelDistanceToWorldDistance(radius);
    body.createFixture(shape,1);
  }
  
  void applyForce(Vec2 force) {
    body.applyForceToCenter(force);
  }
  
  void collide(Particle other) {
    this.collided = true;
  }
  
  void display() {
    Vec2 loc = getPixelLocation();
    float angle = getPixelAngle();
    
    pushMatrix();
    
    translate(loc.x,loc.y);
    rotate(angle);
    
    fill(collided ? color(255,0,0) : color(255));
    stroke(0);
    
    rectMode(CENTER);
    ellipse(0,0,2*radius,2*radius);
    line(0,0,radius,0);
    
    popMatrix();
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
  
  Vec2 attractedTo(Particle other) {
    // location of centers of mass
    Vec2 loc1 = this.body.getWorldCenter();
    Vec2 loc2 = other.body.getWorldCenter();
    
    Vec2 force = loc2.sub(loc1);
    float distance = force.length();
    
    force.normalize();
    force.mulLocal((world.G*this.body.getMass()*other.body.getMass())/(distance*distance));
    
    return force;
  }
}
