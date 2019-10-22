class Rain {
  
  ArrayList<Drop> drops;
  
  Rain() {
    drops = new ArrayList<Drop>();
  }
  
  void addDrop() {
    drops.add(new Drop(mouseX,mouseY));
  }
  
  void removeBrokenDrops() {
    Iterator<Drop> it = drops.iterator();
    while (it.hasNext()) {
      Drop d = it.next();
      if (d.broken) {
        world.destroyBody(d.body);
        it.remove();
      }
    }
  }
  
  void display() {
    for (Drop d: drops)
      d.display();
  }
}
