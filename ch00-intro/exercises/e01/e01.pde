Walker w;

class Walker {
  int x;
  int y;
  
  Walker() {
    x = width/2;
    y = height/2;
  }
  
  void display() {
    stroke(0);
    point(x,y);
  }
  
  void step() {
    int choice = int(random(6));
    if (choice == 0) {
      x--;
    } else if (choice == 1) {
      y--;
    } else if (choice == 2 || choice == 3) {
      x++;
    } else {
      y++;
    }
  }
}

void setup() {
  size(640,360);
  w = new Walker();
  background(255);
}

void draw() {
  w.step();
  w.display();
}
