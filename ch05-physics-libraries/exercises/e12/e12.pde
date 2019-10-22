import java.util.Iterator;
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
  ps.removeBrokenParticles(); // particles "break" when they collide with one another
  ps.applyForces();
  
  background(255);
  ps.display();
  
  world.step();
}
