import org.jbox2d.collision.shapes.CircleShape;
import org.jbox2d.collision.shapes.PolygonShape;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;
import org.jbox2d.dynamics.BodyType;
import org.jbox2d.dynamics.joints.RevoluteJointDef;

class Car {
  
  Chassis chassis;
  Wheel lwheel, rwheel;
  
  float x = 20;
  float y = height/2+37.5;
  float w = 25;
  float h = 15;
  
  Car() {
    chassis = new Chassis(x,y,w,h);
    lwheel = new Wheel(x-w/4,y+h/2);
    rwheel = new Wheel(x+w/4,y+h/2);
    
    _attachWheels();
  }
  
  void _attachWheels() {
    _attachLeftWheel();
    _attachRightWheel();
  }
  
  void _attachLeftWheel() {
    RevoluteJointDef rjd = new RevoluteJointDef();
    rjd.initialize(
      chassis.body,
      lwheel.body,
      world.pixelLocationToWorldLocation(new Vec2(x-w/4,y+h/2))
    );
    rjd.enableMotor = true;
    rjd.motorSpeed = world.pixelAngleToWorldAngle(TWO_PI);
    rjd.maxMotorTorque = 1000;
    world.createJoint(rjd);
  }
  
  void _attachRightWheel() {
    RevoluteJointDef rjd = new RevoluteJointDef();
    rjd.initialize(
      chassis.body,
      rwheel.body,
      world.pixelLocationToWorldLocation(new Vec2(x+w/4,y+h/2))
    );
    rjd.enableMotor = true;
    rjd.motorSpeed = world.pixelAngleToWorldAngle(TWO_PI);
    rjd.maxMotorTorque = 1000;
    world.createJoint(rjd);
  }
  
  void display() {
    chassis.display();
    lwheel.display();
    rwheel.display();
  }
}

class Chassis {
  
  float x, y, w, h;
  Body body;
  
  Chassis(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
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

class Wheel {
  
  Body body;
  
  float x, y;
  float radius = 4;
  
  Wheel(float x, float y) {
    this.x = x;
    this.y = y;
    
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
    CircleShape shape = new CircleShape();
    shape.m_radius = world.pixelDistanceToWorldDistance(radius);
    body.createFixture(shape,0.1);
  }
  
  void display() {
    Vec2 loc = getPixelLocation();
    float angle = getPixelAngle();
    
    pushMatrix();
    
    translate(loc.x,loc.y);
    rotate(angle);
    
    fill(255);
    stroke(0);
    
    rectMode(CENTER);
    ellipse(0,0,2*radius,2*radius);
    line(0,0,radius,0);
    
    popMatrix();
  }
  
  Vec2 getPixelLocation() {
    return world.worldLocationToPixelLocation(body.getPosition()); 
  }
  
  float getPixelAngle() {
    return world.worldAngleToPixelAngle(body.getAngle());
  }
}
