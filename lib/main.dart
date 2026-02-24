void main() async {
  /*List<String> fruits = ['apple', 'banana', 'orange', 'grapes', 'mango'];
  print(longestString(fruits));
  List<int> numbers = [1, 2, 3, 2, 4, 5, 3, 6];
  int squared(int num) => num * num;
  print(sumOfSquares(numbers, squared));
  Person p = Person.fromNameAndAge('Daniel', 20);
  print(p.toString());
  print(sum());
  print(sum(numbers));
  Map<String, int> students = {
    'Alice': 80,
    'Bob': 100,
    'Charlie': 70,
    'Diana': 64,
  };
  mapFilter(students);
  listFilter(numbers);
  print(calculateArea(length: 4, width: 4));
  reduceList(numbers);
  print(division(5, 0));
  List<String> input = ["hello", "world", "dart", "flutter"];
  print(transformList(input));
  List<int> input = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  print(filterNumbers(input));
  await for(int prime in streamExample()){
    print(prime);
  }
  await for (var numbers in streamTransformExample()) {
    print(numbers);
  }*/
  makeCars();
}

String longestString(List<String> list) {
  String longest = '';
  list.forEach((word) {
    if (word.length > longest.length) {
      longest = word;
    }
  });
  return longest;
}

int sumOfSquares(List<int> numbers, int Function(int n) operation) {
  int sum = 0;
  numbers.forEach((num) {
    sum += operation(num);
  });
  return sum;
}

class Person {
  String _name;
  int _age;

  Person.fromNameAndAge(this._name, this._age);

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  @override
  String toString() {
    return 'Name: $_name \nAge: $_age';
  }
}

int sum([List<int>? numbers]) {
  int sum = 0;
  numbers?.forEach((number) {
    sum += number;
  });
  return sum;
}

void mapFilter(Map<String, int>? data) {
  data?.forEach((name, grade) {
    if (grade > 80) {
      print(name);
    }
  });
}

class Car {
  //needed help
  String _brand = '';
  int _year = 0;

  Car(this._brand, this._year);

  factory Car.fromMap(Map<String, dynamic> data) {
    return Car(data["brand"] as String, data["year"] as int);
  }

  int get year => _year;

  set year(int value) {
    _year = value;
  }

  String get brand => _brand;

  set brand(String value) {
    _brand = value;
  }
}

void listFilter(List<int>? numbers) {
  print(numbers?.where((num) => num % 2 == 0).toList());
}

double calculateArea({required double length, required double width}) {
  return length * width;
}

void reduceList(List<int>? numbers) {
  print(numbers?.reduce((total, num) => total + num));
}

double? division(int numerator, int denominator) {
  try {
    return numerator / denominator;
  } catch (e) {
    print('Cannot divide by zero!');
    return null;
  }
}

List<String> transformList(List<String> words) {
  List<String> newList = [];
  for (var word in words) {
    for (int i = 0; i < word.length; i++) {
      if (i % 2 == 0) {
        newList.add(word[i].toUpperCase());
      } else {
        newList.add(word[i]);
      }
    }
  }
  return newList;
}

List<int> filterNumbers(List<int> numbers) {
  List<int> newList = [];
  for (var number in numbers) {
    if (number % 3 != 0) {
      if (number % 2 == 0) {
        number = number ~/ 2;
        newList.add(number);
      } else {
        number = number * number * number;
        newList.add(number);
      }
    }
  }
  return newList;
}

//needed help
bool _isPrime(int number) {
  if (number < 2) {
    return false;
  }
  for (int i = 2; i * i <= number; i++) {
    if (number % i == 0) {
      return false;
    }
  }
  return true;
}

Stream<int> streamExample() async* {
  for (int i = 1; i <= 100; i++) {
    await Future.delayed(Duration(milliseconds: 1000));
    if (_isPrime(i)) {
      yield i;
    }
  }
}

Stream<int> streamTransformExample() async* {
  for (int i = 1; i <= 100; i++) {
    await Future.delayed(Duration(milliseconds: 800));
    //ANONYMOUS FUNCTION
    int Function(int value) {
      return (value % 2 == 0) ? value * value : value * 2;
    }

    yield (i);
  }
}

class Cars {
  final String model;
  final String make;
  final int year;
  final String? color;
  final String? engineType;

  Cars( //THIS IS THE PRIMARY CONSTRUCTOR
    this.model, //positional
    this.make, //positional
      {
    required this.year, //named and required
    this.color, //named and optional
    this.engineType, //named and optional
  });

  Cars.withColor(this.color/*<--this one is required*/, [this.engineType]/*<-- this is an optional parameter*/)
    : //<--this tells this is an initializer list where we are initializing attributes that aren't in the arguments, basically giving them a default value
        make = 'Toyota',
      model = 'Corolla',
      year = 2008;

  @override
  String toString() {
    return 'Model: $model \nMake: $make \nYear: $year \nColor: ${color ?? 'N/A'} \nEngine Type: ${engineType ?? 'N/A'}';
  }
}

void makeCars() {
  var car1 = Cars('Toyota', 'Camry', year: 2023);
  print(car1);
  var car2 = Cars(
    'Honda',
    'Accord',
    year: 2024,
    color: 'Blue',
    engineType: 'V6',
  );
  print(car2);
  var car3 = Cars.withColor('Red');
  print(car3);
  var car4 = Cars.withColor('Black', 'Electric');
  print(car4);
}
