import 'package:async_sync/main.dart'; //import the class explicitly

void main() {
  /*A a1 = A();
  a1.name = 'Name';
  a1.ssn = 123; //calling the getter and setter
  print('${a1.name} : ${a1.ssn}');
  var add = (int x, int y) => x + y; //lambda / arrow function
  print(add(10, 40));*/

  var list = ['apple', 'orange', 'peach'];
  list.forEach((String fruit) {
    //using the foreach stream, this is an example of an anonymous function
    print('$fruit has a length of ${fruit.length}'); //using string literals
  });

  //passing functions as arguments
  int r1 = apply(3, inc);
  int r2 = apply(4, dec);
}

int apply(int n, Function f) { //possible by the function obj
  return f(n);
}

int inc(int x) => ++x;

int dec(int x) => --x;
