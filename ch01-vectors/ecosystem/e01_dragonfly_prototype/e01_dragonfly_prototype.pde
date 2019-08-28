float DRAGONFLY_MOVE_CHANCE = 0.1;
float DRAGONFLY_STOP_CHANCE = 0.0333;
float DRAGONFLY_SPEED = 2.5;

Dragonfly df;

void setup() {
  size(200,200);
  df = new Dragonfly();
}

void draw() {
  background(175);
  df.update();
  df.display();
}

class Dragonfly {
  
  PVector location;
  PVector velocity;
  boolean moving;
  
  Dragonfly() {
    location = randomPoint();
    velocity = nullVector();
  }
  
  void update() {
    // calculate velocity
    if (_moving()) {
      if (random(1) < DRAGONFLY_STOP_CHANCE) {
        velocity = nullVector();
      }
    } else {
      if (random(1) < DRAGONFLY_STOP_CHANCE) {
        velocity = PVector.random2D();
        velocity.mult(DRAGONFLY_SPEED);
      };
    }
    
    location.add(velocity);
    _checkEdges();
  }
  
  void display() {
    ellipse(location.x,location.y,16,16);
  }
  
  void _checkEdges() {
    // horizontal
    if (location.x < 0) location.x = width;
    if (location.x > width) location.x = 0;
    
    // vertical
    if (location.y < 0) location.y = height;
    if (location.y > height) location.y = 0;
  }
  
  boolean _moving() {
    return velocity.mag() > 0;
  }
}

PVector randomPoint() {
  return new PVector(random(0,width),random(0,height));
}

PVector nullVector() {
  return new PVector(0,0);
}
