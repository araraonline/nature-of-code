import org.jbox2d.collision.shapes.PolygonShape;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;
import org.jbox2d.dynamics.BodyType;

class Box {
  
  Body body;
  
  float x = random(0,width);
  float y = random(0,height);
  float side = 25;
  
  Box() {
    x = width/2;
    y = height/2;
    _createBody();
    _attachShape();
  }
  
  void _createBody() {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(world.pixelLocationToWorldLocation(new Vec2(x,y)));
    
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
  
  boolean containsPixelLocation(Vec2 loc) {
    return containsWorldLocation(world.pixelLocationToWorldLocation(loc));
  }
  
  boolean containsWorldLocation(Vec2 loc) {
    return body.getFixtureList().testPoint(loc); // Fixture is implemented as a linked list
                                                 // getFixtureList() returns the Fixture most recently added to the object
  }
}
