import org.jbox2d.common.Vec2;
import org.jbox2d.collision.shapes.ChainShape;
import org.jbox2d.collision.shapes.CircleShape;
import org.jbox2d.collision.shapes.PolygonShape;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;
import org.jbox2d.dynamics.BodyType;

class WeirdBox {
  
  Body body;
  
  WeirdBox(float x, float y) {
    BodyDef bd = _createBodyDef(x,y);
    Shape[] shapes = _createShapes();
    
    body = world.createBody(bd);
    for (Shape s: shapes)
      body.createFixture(s,1);
  }
  
  BodyDef _createBodyDef(float x, float y) {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    Vec2 loc = world.pixelLocationToWorldLocation(new Vec2(x,y));
    bd.position.set(loc.x,loc.y);
    return bd;
  }
  
  Shape[] _createShapes() {
    return new Shape[]{
      _createHeadShape(),
      _createLeftEarShape(),
      _createRightEarShape(),
      _createAntennaLineShape(),
      _createAntennaCircleShape(),
    };
  }
  
  Shape _createHeadShape() {
    Vec2[] vertices = ellipseToVertices(HEAD_X,HEAD_Y,HEAD_W,HEAD_H,8); // AssertionError when N >= 9 (see b2_maxPolygonVertices)
    
    Vec2[] verticesW = new Vec2[vertices.length];
    for (int i = 0; i < vertices.length; i++)
      verticesW[i] = world.pixelLocationToWorldLocation(vertices[i]);
      
    PolygonShape shape = new PolygonShape();
    shape.set(verticesW,verticesW.length);
    return shape;
  }
  
  Shape _createLeftEarShape() {
    Vec2 loc = world.pixelLocationToWorldLocation(new Vec2(LEFT_EAR_X,LEFT_EAR_Y));
    float radius = world.pixelDistanceToWorldDistance(LEFT_EAR_RADIUS);
    
    CircleShape shape = new CircleShape();
    shape.m_p.set(loc.x,loc.y);
    shape.m_radius = radius;
    return shape;
  }
  
  Shape _createRightEarShape() {
    Vec2 loc = world.pixelLocationToWorldLocation(new Vec2(RIGHT_EAR_X,RIGHT_EAR_Y));
    float radius = world.pixelDistanceToWorldDistance(RIGHT_EAR_RADIUS);
    
    CircleShape shape = new CircleShape();
    shape.m_p.set(loc.x,loc.y);
    shape.m_radius = radius;
    return shape;
  }
  
  Shape _createAntennaLineShape() {
    Vec2[] vertices = new Vec2[]{
      new Vec2(ANTENNA_LINE_X0,ANTENNA_LINE_Y0),
      new Vec2(ANTENNA_LINE_X1,ANTENNA_LINE_Y1),
      new Vec2(ANTENNA_LINE_X2,ANTENNA_LINE_Y2),
    };
    
    Vec2[] verticesW = new Vec2[vertices.length];
    for (int i = 0; i < vertices.length; i++)
      verticesW[i] = world.pixelLocationToWorldLocation(vertices[i]);
      
    ChainShape shape = new ChainShape();
    shape.createChain(verticesW,verticesW.length);
    return shape;
  }
  
  Shape _createAntennaCircleShape() {
    Vec2 loc = world.pixelLocationToWorldLocation(new Vec2(ANTENNA_CIRCLE_X,ANTENNA_CIRCLE_Y));
    float radius = world.pixelDistanceToWorldDistance(ANTENNA_CIRCLE_RADIUS);
    
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
    
    strokeWeight(2);
    
    _displayEars();
    _displayHeadOval();
    _displayEyes();
    _displayMouth();
    _displayAntennaLines();
    _displayAntennaCircle();
    
    popMatrix();
  }
  
  void _displayEars() {
    noFill();
    stroke(0);
    ellipse(LEFT_EAR_X,LEFT_EAR_Y,LEFT_EAR_RADIUS*2,LEFT_EAR_RADIUS*2);
    ellipse(RIGHT_EAR_X,RIGHT_EAR_Y,RIGHT_EAR_RADIUS*2,RIGHT_EAR_RADIUS*2);
  }
  
  void _displayHeadOval() {
    fill(255);
    stroke(0);
    ellipse(HEAD_X,HEAD_Y,HEAD_W,HEAD_H);
  }
  
  void _displayEyes() {
    fill(255,69,0);
    noStroke();
    ellipse(LEFT_EYE_X,LEFT_EYE_Y,LEFT_EYE_RADIUS*2,LEFT_EYE_RADIUS*2);
    ellipse(RIGHT_EYE_X,RIGHT_EYE_Y,RIGHT_EYE_RADIUS*2,RIGHT_EYE_RADIUS*2);
  }
  
  void _displayMouth() {
    noFill();
    stroke(0);
    arc(MOUTH_X,MOUTH_Y,MOUTH_RADIUS*2,MOUTH_RADIUS*2,MOUTH_START_ANGLE,MOUTH_STOP_ANGLE);
  }
  
  void _displayAntennaLines() {
    stroke(0);
    line(ANTENNA_LINE_X0,ANTENNA_LINE_Y0,ANTENNA_LINE_X1,ANTENNA_LINE_Y1);
    line(ANTENNA_LINE_X1,ANTENNA_LINE_Y1,ANTENNA_LINE_X2,ANTENNA_LINE_Y2);
  }
  
  void _displayAntennaCircle() {
    noFill();
    stroke(0);
    ellipse(ANTENNA_CIRCLE_X,ANTENNA_CIRCLE_Y,ANTENNA_CIRCLE_RADIUS*2,ANTENNA_CIRCLE_RADIUS*2);
  }
}
