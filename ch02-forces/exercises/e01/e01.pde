PVector BALLOON_UPTHRUST = new PVector(0,-0.01);
PVector CEILING_FORCE = new PVector(0,1);
float WIND_STRENGTH = 0.1; // wind max strength
float WIND_STEP = 0.01; // wind steps through the noise space


Mover mover;
int frame;

void setup() {
  size(200,200);
  mover = new Mover();
}

void draw() {
  background(175);
  mover.update();
  mover.display();
  frame++;
}

class Mover {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  
  Mover() {
    location = new PVector(width/2,height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    topspeed = 3;
  }
  
  void update() {
    // calculate acceleration
    acceleration = new PVector(0,0);
    acceleration.add(BALLOON_UPTHRUST);
    acceleration.add(getWindForce());
    if (location.y < 8) acceleration.add(CEILING_FORCE);
    
    // trickle down
    velocity.add(acceleration);
    velocity.limit(topspeed);
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
  }
}

PVector getWindForce() {
  float r = noise(frame*WIND_STEP);
  return new PVector(map(r,0,1,-WIND_STRENGTH,WIND_STRENGTH),0);
}
