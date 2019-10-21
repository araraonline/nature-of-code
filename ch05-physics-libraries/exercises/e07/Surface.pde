import org.jbox2d.collision.shapes.ChainShape;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;

class Surface {
  
  Body body;
  
  Vec2[] vertices = new Vec2[]{
    new Vec2(0,       height/2+50),
    new Vec2(width/2, height/2+50),
    new Vec2(width,   height/2+45),
    new Vec2(width,   height),
    new Vec2(0,       height),
  };
  
  Surface() {
    _createBody();
    _attachShape();
  }
  
  void _createBody() {
    BodyDef bd = new BodyDef();
    body = world.createBody(bd);
  }
  
  void _attachShape() {
    Vec2[] verticesW = new Vec2[vertices.length-2]; // do not use last two points (bottom of the window)
    for (int i = 0; i < vertices.length-2; i++)
      verticesW[i] = world.pixelLocationToWorldLocation(vertices[i]);
    
    ChainShape shape = new ChainShape();
    shape.createChain(verticesW,verticesW.length);
    body.createFixture(shape,1);
  }
  
  void display() {
    fill(50);
    noStroke();
    
    beginShape();
    for (Vec2 v: vertices)
      vertex(v.x,v.y);
    endShape();
  }
}
