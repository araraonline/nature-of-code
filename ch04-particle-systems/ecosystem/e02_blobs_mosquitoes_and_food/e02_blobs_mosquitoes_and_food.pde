import java.util.Iterator;

Creature[] NO_CHILDREN = new Creature[0];

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
  cs.update(); // creatures can *eat*, modifying the food system
  fs.update();
}

class FoodSystem {
  
  ArrayList<FoodPiece> foodPieces = new ArrayList<FoodPiece>();
  
  FoodSystem() {
    while (foodPieces.size() < 100)
      foodPieces.add(new Speck());
  }
  
  void display() {
    for (FoodPiece fp: foodPieces)
      fp.display();
  }
  
  void update() {
    if (random(1) < 0.5 && foodPieces.size() < 200)
      foodPieces.add(new Speck());
  }
  
  Iterator<FoodPiece> iterator() {
    return foodPieces.iterator();
  }
}

interface FoodPiece {
  void display();
  PVector getLocation();
}

class Speck implements FoodPiece {
  
  PVector location;
  
  Speck() {
    location = new PVector(random(width),random(height));
  }
  
  void display() {
    pushMatrix();
    translate(location.x,location.y);
    fill(255,255,0);
    stroke(0);
    rect(0,0,4,4);
    popMatrix();
  }
  
  PVector getLocation() {
    return location.copy();
  }
}

class CreatureSystem {
  
  ArrayList<Creature> creatures = new ArrayList<Creature>();
  
  CreatureSystem() {
    for (int i = 0; i < 100; i++) {
      if (i < 10)
        creatures.add(new Blob());
      if (i < 50)
        creatures.add(new Mosquito());
    }
  }
  
  void display() {
    for (Creature c: creatures)
      c.display();
  }
  
  void update() {
    ArrayList<Creature> children = new ArrayList<Creature>();
    
    Iterator<Creature> it = creatures.iterator();
    while (it.hasNext()) {
      Creature c = it.next();
      if (c.isAlive()) {
        c.update();
        for (Creature child: c.reproduce()) // collect children
          children.add(child);
      } else {
        it.remove();
      }
    }
    
    for (Creature child: children)
      creatures.add(child);
  }
}

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
  
  void display() {
    rectMode(CENTER);
    noStroke();
    fill(0);
    rect(location.x,location.y,3,3);
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

PVector sumVectors(PVector[] vectors) {
  PVector result = new PVector(0,0);
  for (PVector v: vectors)
    result.add(v);
  return result;
}

boolean circleContains(PVector center, float radius, PVector point) {
  return PVector.sub(point,center).mag() <= radius;
}
