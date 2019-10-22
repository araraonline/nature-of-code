import org.jbox2d.callbacks.ContactImpulse;
import org.jbox2d.callbacks.ContactListener;
import org.jbox2d.collision.Manifold;
import org.jbox2d.dynamics.contacts.Contact;

class Box2DContactListener implements ContactListener {
  
  void beginContact(Contact c) {
    Collidable p1 = (Collidable) c.getFixtureA().getBody().getUserData();
    Collidable p2 = (Collidable) c.getFixtureB().getBody().getUserData();
    
    p1.collide(p2);
    p2.collide(p1);
  };
  
  void endContact(Contact c) { };
  void preSolve(Contact c, Manifold m) { };
  void postSolve(Contact c, ContactImpulse ci) { };
}
