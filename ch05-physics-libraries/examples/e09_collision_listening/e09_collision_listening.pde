import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.*;

Box2DWorld world;
ParticleSystem ps;

void setup() {
  size(200,200);
  world = new Box2DWorld();
  ps = new ParticleSystem();
}

void draw() {
  ps.applyForces();
  
  background(255);
  ps.display();
  
  world.step();
}
