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
