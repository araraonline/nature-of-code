class Animal {
  
  int age;
  
  Animal() {
    age = 0;
  }
  
  void eat() {
    println("Yum!");
  }
  
  void sleep() {
    println("Zzzzz");
  }
}

class Dog extends Animal {
  
  color haircolor;
  
  Dog() {
    super();
    haircolor = color(random(0,255));
  }
  
  void eat() {
    super.eat();
    println("Woof!!!");
    super.sleep();
  }
  
  void bark() {
    println("WOOF!");
  }
}

class Cat extends Animal {
  
  Cat() {
    super();
  }
  
  void meow() {
    println("MEOW!");
  }
}

new Dog().eat();
