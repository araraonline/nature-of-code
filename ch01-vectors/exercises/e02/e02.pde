class Walker {
  
  PVector location = new PVector(); // Hmmm
  
  Walker() {
    location.x = width/2;
    location.y = height/2;
  }
  
  void display() {
    stroke(0);
    point(location.x,location.y);
  }
  
  void step() {
    int choice = int(random(4));
    if (choice == 0) {
      location.x++;
    } else if (choice == 1) {
      location.x--;
    } else if (choice == 2) {
      location.y++;
    } else {
      location.y--;
    }
  }
}


// ---- Code

Walker w;

void setup() {
  size(640,360);
  w = new Walker();
  background(255);
}

void draw() {
  w.step();
  w.display();
}
