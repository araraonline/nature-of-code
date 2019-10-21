import org.jbox2d.dynamics.joints.RevoluteJointDef;

class WindmillJoint {
  
  Box a, b;
  float x, y;
  
  WindmillJoint(Box boxA, Box boxB, float anchorX, float anchorY) {
    a = boxA;
    b = boxB;
    x = anchorX;
    y = anchorY;
    
    _createJoint();
  }
  
  void _createJoint() {
    RevoluteJointDef rjd = new RevoluteJointDef();
    
    rjd.initialize(a.body,b.body,world.pixelLocationToWorldLocation(new Vec2(x,y)));
    
    rjd.enableMotor = true;
    rjd.motorSpeed = world.pixelAngleToWorldAngle(HALF_PI);
    rjd.maxMotorTorque = 1000;
    
    world.createJoint(rjd);
  }
  
  void display() {
    fill(25);
    noStroke();
    ellipse(x,y,4,4);
  }
}
