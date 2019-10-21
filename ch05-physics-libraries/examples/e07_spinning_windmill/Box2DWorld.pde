import org.jbox2d.common.Vec2;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;
import org.jbox2d.dynamics.joints.Joint;
import org.jbox2d.dynamics.joints.JointDef;
import org.jbox2d.dynamics.World;

class Box2DWorld {
  
  World world;
  
  float TIME_STEP_IN_SECONDS = 1.0 / 60.0;
  float PIXELS_PER_METER = 25;
  
  Box2DWorld() {
    Vec2 gravity = new Vec2(0,-10);
    world = new World(gravity);
  }
  
  Body createBody(BodyDef bd) {
    return world.createBody(bd);
  }
  
  Joint createJoint(JointDef jd) {
    return world.createJoint(jd);
  }
  
  void step() {
    // 8 velocity iterations
    // 3 position iterations
    //   (as suggested by Box2D documentation)
    world.step(TIME_STEP_IN_SECONDS,8,3);
  }
  
  Vec2 pixelLocationToWorldLocation(Vec2 pixelLocation) {
    return new Vec2(pixelLocation.x/PIXELS_PER_METER,-pixelLocation.y/PIXELS_PER_METER);
  }
  
  Vec2 worldLocationToPixelLocation(Vec2 worldLocation) {
    return new Vec2(worldLocation.x*PIXELS_PER_METER,-worldLocation.y*PIXELS_PER_METER);
  }
  
  float pixelDistanceToWorldDistance(float pixelDistance) {
    return pixelDistance / PIXELS_PER_METER;
  }
  
  float worldDistanceToPixelDistance(float worldDistance) {
    return worldDistance * PIXELS_PER_METER;
  }
  
  float pixelAngleToWorldAngle(float pixelAngle) {
    return -pixelAngle;
  }
  
  float worldAngleToPixelAngle(float worldAngle) {
    return -worldAngle;
  }
}
