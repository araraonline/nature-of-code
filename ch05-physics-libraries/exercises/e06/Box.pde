import org.jbox2d.collision.shapes.PolygonShape;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;
import org.jbox2d.dynamics.BodyType;

class Box {
  
  Body body;
  float side;
  
  Box(float pixelX, float pixelY) {
    side = random(BOX_SIDE_MIN,BOX_SIDE_MAX);
    
    _createBody(pixelX,pixelY);
    _attachShape();
  }
  
  void _createBody(float pixelX, float pixelY) {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(world.pixelLocationToWorldLocation(new Vec2(pixelX,pixelY)));
    
    body = world.createBody(bd);
  }
  
  void _attachShape() {
    PolygonShape shape = new PolygonShape();
    float sideW = world.pixelDistanceToWorldDistance(side);
    shape.setAsBox(sideW/2,sideW/2);
    
    body.createFixture(shape,1);
  }
  
  void display() {
    Vec2 loc = getPixelLocation();
    float angle = getPixelAngle();
    
    pushMatrix();
    
    translate(loc.x,loc.y);
    rotate(angle);
    
    fill(175);
    stroke(0);
    
    rectMode(CENTER);
    rect(0,0,side,side);
    
    popMatrix();
  }
  
  Vec2 getPixelLocation() {
    return world.worldLocationToPixelLocation(body.getPosition()); 
  }
  
  float getPixelAngle() {
    return world.worldAngleToPixelAngle(body.getAngle());
  }
}
