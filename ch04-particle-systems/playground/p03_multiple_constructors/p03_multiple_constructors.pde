// Experiment :
// Java automatically matches constructors based on param types

class MultipleConstructors {
  
  MultipleConstructors() {
    println("no args");
  }
  
  MultipleConstructors(int a) {
    println("int",a);
  }
  
  // comment this one
  MultipleConstructors(float b) {
    println("float",b);
  }
}

new MultipleConstructors();
new MultipleConstructors(1);
new MultipleConstructors(1.0);
