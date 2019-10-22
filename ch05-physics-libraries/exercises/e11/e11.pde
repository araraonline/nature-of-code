import java.util.Iterator;

import org.jbox2d.common.Vec2;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;

Box2DWorld world;
Walls walls;
Rain rain;
Mover m1, m2, m3;

void setup() {
  size(400,400);
  
  world = new Box2DWorld();
  
  walls = new Walls();
  rain = new Rain();
  m1 = new Mover();
  m2 = new Mover();
  m3 = new Mover();
}

void draw() {
  rain.removeBrokenDrops(); // drops "break" when they collide against anything other than a drop
  if (mousePressed)
    rain.addDrop();
  
  m1.update(); // update mover target, blueness and velocity before displaying it
  m2.update(); //   and calculating the next step
  m3.update();
  
  background(255);
  walls.display();
  m1.display();
  m2.display();
  m3.display();
  rain.display();
  
  world.step();
}
