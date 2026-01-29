import 'dart:math' as math;

abstract class Shape {
  perimeter();
  area();
}

class Circle extends Shape {
  var radius = 4;

  @override
  area() {
    var result = math.pi * radius * radius;
    print(result);
  }

  @override
  perimeter() {
    var result = 2 * math.pi * radius;
    print(result);
  }
}

class Square extends Shape {
  var side = 3;

  @override
  area() {
    var result = side * side;
    print(result);
  }

  @override
  perimeter() {
    var result = 4 * side;
    print(result);
  }
}

void main() {
  Shape c = Circle();
  c.area();
  c.perimeter();
  c = Square();
  c.area();
  c.perimeter();

  // what is dynamic polymorphism
}