// controls movement
float DRAGONFLY_ACCELERATE_FORCE = 0.4;
float DRAGONFLY_BRAKE_FORCE = 0.4;
float DRAGONFLY_MAX_SPEED = 4;

// controls state changes
float DRAGONFLY_ACCELERATE_CHANCE = 0.04;
float DRAGONFLY_BRAKE_CHANCE = 0.03;
float DRAGONFLY_STOP_SPEED = DRAGONFLY_BRAKE_FORCE * 1.1;


Dragonfly df;
enum DragonflyState { STOPPED, ACCELERATING, BRAKING }

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
  PVector acceleration;
  DragonflyState state;
  
  Dragonfly() {
    location = randomPoint();
    velocity = nullVector();
    acceleration = nullVector();
    state = DragonflyState.STOPPED;
  }
  
  void update() {
    switch (state) {
      case ACCELERATING:
        _accelerate();
        _maybeBrake();
        break;
      case BRAKING:
        _brake();
        _maybeStop();
        break;
      case STOPPED:
        _maybeAccelerate();
        break;
    }
    _checkEdges();
  }
  
  void _accelerate() {
    velocity.add(acceleration);
    velocity.limit(DRAGONFLY_MAX_SPEED);
    location.add(velocity);
  }
  
  void _maybeBrake() {
    if (random(1) < DRAGONFLY_BRAKE_CHANCE) {
      acceleration.rotate(PI);
      acceleration.setMag(DRAGONFLY_BRAKE_FORCE);
      state = DragonflyState.BRAKING;
    }
  }
  
  void _brake() {
    velocity.add(acceleration); // let`s hope that the accleration is opposite to the velocity =D
    location.add(velocity);
  }
  
  void _maybeStop() {
    // stop if speed is too low
    if (velocity.mag() < DRAGONFLY_STOP_SPEED) {
      acceleration = nullVector();
      state = DragonflyState.STOPPED;
    }
  }
  
  void _maybeAccelerate() {
    if (random(1) < DRAGONFLY_ACCELERATE_CHANCE) {
      acceleration = PVector.random2D();
      acceleration.mult(DRAGONFLY_ACCELERATE_FORCE);
      state = DragonflyState.ACCELERATING;
    }
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
}

PVector randomPoint() {
  return new PVector(random(0,width),random(0,height));
}

PVector nullVector() {
  return new PVector(0,0);
}
