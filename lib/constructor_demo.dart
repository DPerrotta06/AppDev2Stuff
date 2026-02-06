class Student {
  Student() {
    // normal default constructor
    print('I am the first constructor');
  }

  Student.named(String name) {
    //named constructor and is also parameterized and overloaded
    print('Student name: ${name}');
  }
}

class Laptop {
  Laptop({var name, var color}) {
    print('Laptop constructor');
    print("$name");
    print("$color");
  }
}

class MacBook extends Laptop {
  MacBook({var name, var color}) : super(name: name, color: color) {
    print('MacBook constructor');
  }
}

void main() {
  /*Student s = new Student(); //this will just print whatever is in the constructor at runtime
  Student s1 = new Student.named("Tuts"); //you need to explicitly call the named constructor*/
  var macbook = MacBook(name: "MackBook Pro", color: "Silver");
}
