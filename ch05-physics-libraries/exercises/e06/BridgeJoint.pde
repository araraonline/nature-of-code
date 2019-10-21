import org.jbox2d.dynamics.joints.DistanceJointDef;

class BridgeJoint {
  
  BridgeComponent a, b;
  
  BridgeJoint(BridgeComponent a, BridgeComponent b) {
    this.a = a;
    this.b = b;
    _createJoint();
  }
  
  void _createJoint() {
    DistanceJointDef djd = new DistanceJointDef();
    djd.bodyA = a.getBody();
    djd.bodyB = b.getBody();
    djd.length = world.pixelDistanceToWorldDistance(JOINT_LENGTH);
    world.createJoint(djd);
  }
  
  void display() {
    Vec2 locA = a.getPixelLocation();
    Vec2 locB = b.getPixelLocation();
    
    stroke(0);
    line(locA.x,locA.y,locB.x,locB.y);
  }
}
