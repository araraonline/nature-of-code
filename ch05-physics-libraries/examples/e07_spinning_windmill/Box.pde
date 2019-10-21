import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;
import org.jbox2d.dynamics.BodyType;
import org.jbox2d.collision.shapes.PolygonShape;

class Box {
  
  float x, y, w, h;
  boolean fixed;
  
  Body body;
  
  Box(float x, float y, float w, float h, boolean fixed) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.fixed = fixed;
    
    _createBody();
    _attachShape();
  }
  
  void _createBody() {
    BodyDef bd = new BodyDef();
    bd.type = fixed ? BodyType.STATIC : BodyType.DYNAMIC;
    bd.position.set(world.pixelLocationToWorldLocation(new Vec2(x,y)));
    body = world.createBody(bd);
  }
  
  void _attachShape() {
    PolygonShape shape = new PolygonShape();
    shape.setAsBox(
      world.pixelDistanceToWorldDistance(w)/2,
      world.pixelDistanceToWorldDistance(h)/2
    );
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
    rect(0,0,w,h);
    
    popMatrix();
  }
  
  Vec2 getPixelLocation() {
    return world.worldLocationToPixelLocation(body.getPosition()); 
  }
  
  float getPixelAngle() {
    return world.worldAngleToPixelAngle(body.getAngle());
  }
}
