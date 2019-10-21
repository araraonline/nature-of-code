class Windmill {
  
  Box base;
  Box blade;
  WindmillJoint joint;
  
  Windmill() {
    base = new Box(width/2,height*3/4,15,height/2,true);
    blade = new Box(width/2,height/2+10,85,10,false);
    joint = new WindmillJoint(base,blade,width/2,height/2+10);
  }
  
  void display() {
    base.display();
    blade.display();
    joint.display();
  }
}
