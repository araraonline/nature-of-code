import org.jbox2d.common.Vec2;
import org.jbox2d.collision.shapes.CircleShape;
import org.jbox2d.collision.shapes.PolygonShape;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;
import org.jbox2d.dynamics.BodyType;

class WeirdBox {
  
  Body body;
  float W = 8;
  float H = 16;
  float R = H/2;
  
  WeirdBox(float x, float y) {
    BodyDef bd = _createBodyDef(x,y);
    Shape rectangle = _createRectangle();
    Shape circle = _createCircle();
    
    body = world.createBody(bd);
    body.createFixture(rectangle,1);
    body.createFixture(circle,1);
  }
  
  BodyDef _createBodyDef(float x, float y) {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    Vec2 loc = world.pixelLocationToWorldLocation(new Vec2(x,y));
    bd.position.set(loc.x,loc.y);
    return bd;
  }
  
  Shape _createRectangle() {
    PolygonShape shape = new PolygonShape();
    shape.setAsBox(world.pixelDistanceToWorldDistance(W/2),world.pixelDistanceToWorldDistance(H/2));
    return shape;
  }
  
  Shape _createCircle() {
    Vec2 loc = world.pixelLocationToWorldLocation(new Vec2(0,-H/2));
    float radius = world.pixelDistanceToWorldDistance(R);
    
    CircleShape shape = new CircleShape();
    shape.m_p.set(loc.x,loc.y);
    shape.m_radius = radius;
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
    rect(0,0,W,H);
    
    ellipse(0,-H/2,2*R,2*R);
    
    popMatrix();
  }
}
