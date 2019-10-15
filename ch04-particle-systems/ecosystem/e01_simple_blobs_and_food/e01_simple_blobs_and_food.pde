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
  int N_PIECES = 50;
  
  FoodSystem() {
    _fillArray();
  }
  
  void display() {
    for (FoodPiece fp: foodPieces)
      fp.display();
  }
  
  void update() {
    _fillArray();
  }
  
  Iterator<FoodPiece> iterator() {
    return foodPieces.iterator();
  }
  
  void _fillArray() {
    while (foodPieces.size() < N_PIECES) {
      foodPieces.add(new Speck());
    }
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
    rotate(radians(45));
    fill(0);
    noStroke();
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
    creatures.add(new Blob());
    creatures.add(new Blob());
    creatures.add(new Blob());
    creatures.add(new Blob());
    creatures.add(new Blob());
    creatures.add(new Blob());
    creatures.add(new Blob());
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

boolean circleContains(PVector center, float radius, PVector point) {
  return PVector.sub(point,center).mag() <= radius;
}
