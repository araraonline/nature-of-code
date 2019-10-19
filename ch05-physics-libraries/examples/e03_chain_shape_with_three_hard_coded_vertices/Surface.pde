import org.jbox2d.collision.shapes.ChainShape;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;

class Surface {
  
  Vec2[] points = new Vec2[]{
    new Vec2(0,       height/2+50),
    new Vec2(width/2, height/2+50),
    new Vec2(width,   height/2),
    new Vec2(width,   height),
    new Vec2(0,       height),
  };
  
  Surface() {
    BodyDef bd = _createBodyDef();
    Shape shape = _createShape();
    
    Body body = world.createBody(bd);
    body.createFixture(shape,1);
  }
  
  BodyDef _createBodyDef() {
    return new BodyDef();
  }
  
  Shape _createShape() {
    Vec2[] worldVertices = new Vec2[points.length];
    for (int i = 0; i < points.length; i++)
      worldVertices[i] = world.pixelLocationToWorldLocation(points[i]);
    
    ChainShape shape = new ChainShape();
    shape.createChain(worldVertices,points.length-2); // do not use last two points (bottom of the window)
    return shape;
  }
  
  void display() {
    fill(50);
    noStroke();
    beginShape();
    for (Vec2 p: points)
      vertex(p.x,p.y);
    endShape();
  }
}
