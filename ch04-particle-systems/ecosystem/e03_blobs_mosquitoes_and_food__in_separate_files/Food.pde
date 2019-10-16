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
