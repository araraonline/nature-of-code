import org.jbox2d.collision.shapes.PolygonShape;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;
import org.jbox2d.dynamics.BodyType;
import org.jbox2d.dynamics.FixtureDef;

class Boundary {
  
  Body body;
  
  float x, y;
  float w, h;
  
  Boundary(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    
    BodyDef bd = _createBodyDef();
    FixtureDef fd = _createFixtureDef();
    
    body = world.createBody(bd);
    body.createFixture(fd);
  }
  
  BodyDef _createBodyDef() {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
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
    float worldW = world.pixelDistanceToWorldDistance(w);
    float worldH = world.pixelDistanceToWorldDistance(h);
    shape.setAsBox(worldW/2,worldH/2);
    return shape;
  }
  
  void display() {
    pushMatrix();
    translate(x,y);
    fill(50);
    stroke(0);
    rectMode(CENTER);
    rect(0,0,w,h);
    popMatrix();
  }
}
