import org.jbox2d.collision.shapes.PolygonShape;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;
import org.jbox2d.dynamics.BodyType;
import org.jbox2d.dynamics.FixtureDef;

class Box {
  
  Body body;
  
  float SIDE = 8;
  
  Box(float x, float y) {
    BodyDef bd = _createBodyDef(x,y);
    FixtureDef fd = _createFixtureDef();
    
    body = world.createBody(bd);
    body.createFixture(fd);
  }
  
  BodyDef _createBodyDef(float x, float y) {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    Vec2 loc = world.pixelLocationToWorldLocation(new Vec2(x,y));
    bd.position.set(loc.x,loc.y);
    return bd;
  }
  
  FixtureDef _createFixtureDef() {
    FixtureDef fd = new FixtureDef();
    fd.shape = _createShape();
    fd.density = 1;
    fd.friction = 0.3; // copied from solution
    fd.restitution = 0.5; // copied from solution
    return fd;
  }
  
  Shape _createShape() {
    PolygonShape shape = new PolygonShape();
    float side = world.pixelDistanceToWorldDistance(SIDE);
    shape.setAsBox(side/2,side/2);
    return shape;
  }
  
  void display() {
    Vec2 loc = world.worldLocationToPixelLocation(body.getPosition());
    float angle = world.worldAngleToPixelAngle(body.getAngle());
    pushMatrix();
    translate(loc.x,loc.y);
    rotate(angle);
    fill(175);
    stroke(0);
    rectMode(CENTER);
    rect(0,0,SIDE,SIDE);
    popMatrix();
  }
}
