import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.*;

Box2DWorld world;
Rain rain;
Mover mover;

void setup() {
  size(200,200);
  world = new Box2DWorld();
  rain = new Rain();
  mover = new Mover();
}

void draw() {
  if (mousePressed)
    rain.addDrop();
  mover.update();
  
  background(255);
  rain.display();
  mover.display();
  
  world.step();
}
