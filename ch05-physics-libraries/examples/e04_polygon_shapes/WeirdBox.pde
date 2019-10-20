import org.jbox2d.common.Vec2;
import org.jbox2d.collision.shapes.PolygonShape;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;
import org.jbox2d.dynamics.BodyType;

class WeirdBox {
  
  Body body;
  Vec2[] vertices = new Vec2[]{
    new Vec2(-10,-10),
    new Vec2(-15,+25),
    new Vec2(+10,+5),
    new Vec2(+15,-0),
    new Vec2(+20,-15)
  };
  
  WeirdBox(float x, float y) {
    BodyDef bd = _createBodyDef(x,y);
    Shape shape = _createShape();
    
    body = world.createBody(bd);
    body.createFixture(shape,1);
  }
  
  BodyDef _createBodyDef(float x, float y) {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    Vec2 loc = world.pixelLocationToWorldLocation(new Vec2(x,y));
    bd.position.set(loc.x,loc.y);
    return bd;
  }
  
  Shape _createShape() {
    PolygonShape shape = new PolygonShape();
    Vec2[] verticesW = new Vec2[vertices.length];
    for (int i = 0; i < vertices.length; i++)
      verticesW[i] = world.pixelLocationToWorldLocation(vertices[i]);
    shape.set(verticesW,verticesW.length);
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
    
    beginShape();
    for (Vec2 v: vertices)
      vertex(v.x,v.y);
    endShape(CLOSE);
    
    popMatrix();
  }
}
