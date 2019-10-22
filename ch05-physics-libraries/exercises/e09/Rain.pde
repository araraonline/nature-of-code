class Rain {
  
  ArrayList<Drop> drops;
  
  Rain() {
    drops = new ArrayList<Drop>();
  }
  
  void addDrop() {
    drops.add(new Drop(mouseX,mouseY));
  }
  
  void display() {
    for (Drop d: drops)
      d.display();
  }
}
