import org.jbox2d.callbacks.ContactImpulse;
import org.jbox2d.callbacks.ContactListener;
import org.jbox2d.collision.Manifold;
import org.jbox2d.dynamics.contacts.Contact;

class ParticleContactListener implements ContactListener {
  
  void beginContact(Contact c) {
    Particle p1 = (Particle) c.getFixtureA().getBody().getUserData();
    Particle p2 = (Particle) c.getFixtureB().getBody().getUserData();
    
    p1.collide(p2);
    p2.collide(p1);
  };
  
  void endContact(Contact c) { };
  void preSolve(Contact c, Manifold m) { };
  void postSolve(Contact c, ContactImpulse ci) { };
}
