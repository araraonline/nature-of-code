class Walls {
  
  Wall wallT, wallR, wallB, wallL; // top, right, bottom, left
  float W = 10; // width
  
  Walls() {
    _initializeT();
    _initializeR();
    _initializeB();
    _initializeL();
  }
  
  void _initializeT() {
    Vec2 center = new Vec2(width/2,W/2);
    Vec2 dimensions = new Vec2(width,W);
    
    wallT = new Wall(center,dimensions);
  }
  
  void _initializeR() {
    Vec2 center = new Vec2(width-W/2,height/2);
    Vec2 dimensions = new Vec2(W,height);
    
    wallR = new Wall(center,dimensions); 
  }
  
  void _initializeB() {
    Vec2 center = new Vec2(width/2,height-W/2);
    Vec2 dimensions = new Vec2(width,W);
    
    wallB = new Wall(center,dimensions);
  }
  
  void _initializeL() {
    Vec2 center = new Vec2(W/2,height/2);
    Vec2 dimensions = new Vec2(W,height);
    
    wallL = new Wall(center,dimensions);
  }
  
  void display() {
    wallT.display();
    wallR.display();
    wallB.display();
    wallL.display();
  }
}
