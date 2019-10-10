// Experiment #1
// Java will not supply the param-less constructor when there's one
// already specified

class NoConstructor {
  
  // uncomment this
  //NoConstructor(int a) {
  //}
}

new NoConstructor();


// Experiment #2
// Super and subclass without explicit constructor

class Parent {
}

class Child extends Parent {
}

new Child();


// Experiment #3
// Subclass without explicit constructor (calls the parent constructor automatically)

class Parent2 {
  Parent2() {
    println("parent2");
  }
}

class Child2 extends Parent2 {
}

new Child2();


// Experiment #5
// Superclass without default constructor
//
// Java inserts a call to the parent constructor when super() is not
// directly used. This is the same as prepending a `super()` to the top
// of the child constructor code.
//
// However, in this case, there is no default constructor in the superclass.
// So java requires that you call another constructor of the superclass. This is
// a pain in the ass.

class Parent5 {
  
  // uncomment here to break things
  //Parent5(int a) {
  //  println("parent5",a);
  //}
}

class Child5 extends Parent5 {
  
  // you can even comment here and it won't work
  Child5(int a) {
    println("child5",a);
  }
}

new Child5(5);


// Experiment #4
// Both super and sub classes with explicit constructor
// (with no args)

class Parent3 {
  Parent3() {
    println("parent3");
  }
}

class Child3 extends Parent3 {
  Child3() {
    println("child3");
  }
}

new Child3();
