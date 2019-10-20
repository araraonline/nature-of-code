import org.jbox2d.dynamics.joints.DistanceJointDef;
import org.jbox2d.dynamics.joints.Joint;

class Pair {
  
  Box boxA, boxB;
  Joint joint;
  
  Pair(float x, float y) {
    boxA = new Box(x+random(-12,12),y+random(-12,12));
    boxB = new Box(x+random(-12,12),y+random(-12,12));
    
    DistanceJointDef djd = new DistanceJointDef();
    djd.collideConnected = true;
    djd.bodyA = boxA.body;
    djd.bodyB = boxB.body;
    djd.length = world.pixelDistanceToWorldDistance(20);
    
    joint = world.createJoint(djd);
  }
  
  void display() {
    Vec2 locA = world.worldLocationToPixelLocation(boxA.body.getPosition());
    Vec2 locB = world.worldLocationToPixelLocation(boxB.body.getPosition());
    stroke(0);
    line(locA.x,locA.y,locB.x,locB.y);
    
    boxA.display();
    boxB.display();
  }
}
