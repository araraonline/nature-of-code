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
    
    // add children
    for (Creature child: children)
      creatures.add(child);
  }
}
