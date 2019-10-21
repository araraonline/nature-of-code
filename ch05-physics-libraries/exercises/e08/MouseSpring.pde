import org.jbox2d.dynamics.joints.MouseJoint;
import org.jbox2d.dynamics.joints.MouseJointDef;

class MouseSpring {
  
  Box box;
  MouseJoint mouseJoint;
  
  float time = 0;
  
  MouseSpring(Box box) {
    this.box = box;
  }
  
  void attachToBox() {
    _createMouseJoint();
  }
  
  void _createMouseJoint() {
    MouseJointDef mjd = new MouseJointDef();
    
    mjd.target.set(box.getWorldLocation());
    
    mjd.bodyA = world.groundBody;
    mjd.bodyB = box.body;
    
    mjd.maxForce = 5000;
    mjd.frequencyHz = 4;
    mjd.dampingRatio = 1;
    
    mouseJoint = (MouseJoint) world.createJoint(mjd);
  }
  
  void updateTarget() {
    if (mouseJoint != null) {
      float x = map(noise(time),0,1,0,width);
      float y = map(noise(time+1000),0,1,0,height);
      mouseJoint.setTarget(world.pixelLocationToWorldLocation(new Vec2(x,y)));
      time += 0.01;
    }
  }
  
  void display() {
    if (mouseJoint != null) {
      Vec2 loc0 = new Vec2(0,0);
      mouseJoint.getAnchorA(loc0); // saves anchorA to loc0
      loc0 = world.worldLocationToPixelLocation(loc0);
      
      Vec2 loc1 = new Vec2(0,0);
      mouseJoint.getAnchorB(loc1);
      loc1 = world.worldLocationToPixelLocation(loc1);
      
      stroke(0);
      line(loc0.x,loc0.y,loc1.x,loc1.y);
    }
  }
}
