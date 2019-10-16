interface Creature {
  void display();
  void update();
  Creature[] reproduce(); // for each frame - return empty array if no children
  boolean isAlive();
}

class Blob implements Creature {
  
  float tick = int(random(0,1e4));
  float health = 200;
  
  void display() {
    stroke(145);
    fill(175);
    ellipse(_getX(),_getY(),_getSize(),_getSize());
  }
  
  void update() {
    tick++;
    health--;
    _eat();
  }
  
  Blob[] reproduce() {
    if (random(1) < 0.005)
      return new Blob[]{new Blob()};
    else
      return new Blob[0];
  }
  
  boolean isAlive() {
    return health > 0;
  }
  
  void _eat() {
    // eat food pieces I'm standing above
    Iterator<FoodPiece> it = fs.iterator();
    while (it.hasNext()) {
      FoodPiece fp = it.next();
      if (circleContains(_getLocation(),_getSize()/2,fp.getLocation())) {
        health++;
        it.remove();
      }
    }
  }
  
  PVector _getLocation() {
    return new PVector(_getX(),_getY());
  }
  
  float _getX() {
    return map(noise(tick*0.02),0,1,0,width);
  }
  
  float _getY() {
    return map(noise(1e4+tick*0.02),0,1,0,height);
  }
  
  float _getSize() {
    float min = 20;
    float max = 33;
    return map(sin(tick*0.04),-1,1,min,max);
  }
}

class Mosquito implements Creature {
  
  PVector location;
  PVector velocity;
  
  int health = 100;
  
  Mosquito() {
    location = new PVector(random(0,width),random(0,height));
    velocity = new PVector(random(-1,1),random(-1,1));
  }
  
  Mosquito(PVector location_) {
    location = location_;
    velocity = new PVector(random(-1,1),random(-1,1));
  }
  
  void display() {
    rectMode(CENTER);
    noStroke();
    fill(0);
    rect(location.x,location.y,3,3);
  }
  
  void update() {
    _move();
    _eat();
    _getOlder();
  }
  
  void _move() {
    PVector acceleration = _calculateTotalForce(); // assuming mass = 1
    velocity.add(acceleration);
    location.add(velocity);
    _bounceOnEdges();
  }
  
  PVector _calculateTotalForce() {
    PVector randomForce = PVector.random2D();
    randomForce.mult(0.4);
    
    float speed = velocity.mag();
    PVector airResistance = velocity.copy();
    airResistance.setMag(-0.02*speed*speed);
    
    PVector[] forces = new PVector[]{randomForce,airResistance};
    return sumVectors(forces);
  }
  
  void _bounceOnEdges() {
    // vertical
    if (location.y < 0) {
      location.y = 0;
      velocity.y = abs(velocity.y);
    } else if (location.y > height) {
      location.y = height;
      velocity.y = -abs(velocity.y);
    }
    
    // horizontal
    if (location.x < 0) {
      location.x = 0;
      velocity.x = abs(velocity.x);
    } else if (location.x > width) {
      location.x = width;
      velocity.x = -abs(velocity.x);
    }
  }
  
  void _eat() {
    Iterator<FoodPiece> it = fs.iterator();
    while (it.hasNext()) {
      FoodPiece fp = it.next();
      if (circleContains(location,1.5,fp.getLocation())) {
        health++;
        it.remove();
      }
    }
  }
  
  void _getOlder() {
    health--;
  }
  
  Mosquito[] reproduce() {
    if (random(1) < 0.99*0.01/5.0) {
      Mosquito[] children = new Mosquito[5];
      for (int i = 0; i < children.length; i++) {
        PVector location = this.location.copy();
        PVector diff = PVector.random2D();
        diff.mult(10);
        location.add(diff);
        
        children[i] = new Mosquito(location);
      }
      return children;
    } else {
      return new Mosquito[]{};
    }
  }
  
  boolean isAlive() {
    return health > 0;
  }
}
