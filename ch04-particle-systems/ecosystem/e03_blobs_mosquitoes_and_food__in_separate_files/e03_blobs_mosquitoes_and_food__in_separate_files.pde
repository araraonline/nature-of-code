import java.util.Iterator;

FoodSystem fs;
CreatureSystem cs;

void setup() {
  size(200,200);
  fs = new FoodSystem();
  cs = new CreatureSystem();
}

void draw() {
  background(255);
  
  fs.display();
  cs.display();
  
  fs.update();
  cs.update();
}
