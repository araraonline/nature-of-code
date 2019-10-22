// Every Box2D body must be linked with a Collidable object via Body.getUserData()

interface Collidable {
  void collide(Collidable other);
}
