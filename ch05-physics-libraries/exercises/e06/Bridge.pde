class Bridge {
  
  ArrayList<BridgeComponent> components;
  ArrayList<BridgeJoint> joints;
  
  Bridge() {
    _initializeComponents();
    _initializeJoints();
  }
  
  void _initializeComponents() {
    int N = N_COMPONENTS;
    components = new ArrayList<BridgeComponent>();
    for (int i = 0; i < N; i++) {
      float x = map(i,0,N-1,0,width); // x-location on the screen
      if (i == 0 || i == N - 1)
        components.add(new BridgeComponent(x,BRIDGE_HEIGHT,true));
      else
        components.add(new BridgeComponent(x,BRIDGE_HEIGHT,false));
    }
  }
  
  void _initializeJoints() {
    joints = new ArrayList<BridgeJoint>();
    for (int i = 0; i < components.size() - 1; i++) {
      BridgeComponent a = components.get(i);
      BridgeComponent b = components.get(i+1);
      joints.add(new BridgeJoint(a,b));
    }
  }
  
  void display() {
    _displayJoints();
    _displayComponents(); // components go on top of joints
  }
  
  void _displayJoints() {
    for (BridgeJoint j: joints)
      j.display();
  }
  
  void _displayComponents() {
    for (BridgeComponent c: components)
      c.display();
  }
}
