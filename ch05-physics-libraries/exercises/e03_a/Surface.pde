import org.jbox2d.collision.shapes.ChainShape;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;

class Surface {
  
  ArrayList<Vec2> points;
  
  Surface() {
    _initializePoints();
    _initializeBody();
  }
  
  void _initializePoints() {
    points = new ArrayList<Vec2>();
    for (int x = 0; x <= width; x += 5) {
      points.add(new Vec2(x,_height(x)));
    } 
  }
  
  float _height(float x) {
    return map(sin(x/40-1),-1,1,height-20,0.66*height);
  }
  
  void _initializeBody() {
    BodyDef bd = _createBodyDef();
    Shape shape = _createShape();
    
    Body body = world.createBody(bd);
    body.createFixture(shape,1);
  }
  
  BodyDef _createBodyDef() {
    return new BodyDef();
  }
  
  Shape _createShape() {
    Vec2[] worldVertices = new Vec2[points.size()];
    for (int i = 0; i < points.size(); i++)
      worldVertices[i] = world.pixelLocationToWorldLocation(points.get(i));
    
    ChainShape shape = new ChainShape();
    shape.createChain(worldVertices,worldVertices.length);
    return shape;
  }
  
  void display() {
    noFill();
    stroke(0);
    beginShape();
    for (Vec2 p: points)
      vertex(p.x,p.y);
    endShape();
  }
}
