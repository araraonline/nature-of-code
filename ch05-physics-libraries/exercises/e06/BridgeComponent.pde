import org.jbox2d.collision.shapes.CircleShape;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;
import org.jbox2d.dynamics.BodyType;

class BridgeComponent {
  
  Body body;
  boolean pinned;
  
  BridgeComponent(float pixelX, float pixelY, boolean pinned_) {
    pinned = pinned_;
    _createBody(pixelX,pixelY);
    _attachShape();
  }
  
  void _createBody(float pixelX, float pixelY) {
    BodyDef bd = new BodyDef();
    bd.type = pinned ? BodyType.STATIC : BodyType.DYNAMIC;
    bd.position.set(world.pixelLocationToWorldLocation(new Vec2(pixelX,pixelY)));
    body = world.createBody(bd);
  };
  
  void _attachShape() {
    CircleShape shape = new CircleShape();
    shape.m_radius = world.pixelDistanceToWorldDistance(COMPONENT_RADIUS);
    body.createFixture(shape,50);
  }
  
  void display() {

    Vec2 loc = getPixelLocation();
    float angle = getPixelAngle();
    
    pushMatrix();
    
    translate(loc.x,loc.y);
    rotate(angle);
    
    fill(175);
    stroke(0);
    
    ellipse(0,0,COMPONENT_RADIUS*2,COMPONENT_RADIUS*2);
    line(0,0,COMPONENT_RADIUS,0);
    
    popMatrix();
  }
  
  Body getBody() {
    return body;
  }
  
  Vec2 getPixelLocation() {
    return world.worldLocationToPixelLocation(body.getPosition()); 
  }
  
  float getPixelAngle() {
    return world.worldAngleToPixelAngle(body.getAngle());
  }
}
