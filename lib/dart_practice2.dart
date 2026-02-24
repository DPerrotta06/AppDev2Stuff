void main() async {
  List<String> words = ["Flutter", "Dart", "is", "Awesome"];
  print(analyzeWords(words));
}

Map<String, int> analyzeWords(List<String> words) {
  Map<String, int> wordMap = {};
  words
      .where((word) => word.length >= 4)
      .map((word) => word.toLowerCase())
      .forEach((word) {
        int vowelCount = 0;
        for (int i = 0; i < word.length; i++) {
          if ("aieouy".contains(word[i])) {
            vowelCount++;
          }
        }
        wordMap[word] = vowelCount;
      });
  return wordMap;
}

Stream<int> advancedStreamExample() async* {
  for (int i = 1; i <= 100; i++) {
    await Future.delayed(Duration(milliseconds: 500));
    if (i % 5 == 0 || i % 2 != 0) {
      int Function(int value) {
        return (value > 100) ? value -= 50 : value *= 3;
      }
    }
    yield (i);
  }
}

Stream<int> errorHandlingStream() async* {
  for (int i = 1; i <= 50; i++) {
    if (i == 25) {
      throw Exception('Error');
    }
  }
}

List<String> modifyWords(List<String> words) {
  List<String> newList = [];
  for (var word in words) {
    if (word.contains("a")) {
      continue;
    }
    var transform = (String str) =>
        (str.length % 2 == 0) ? str.toUpperCase() : str.toLowerCase();
    newList.add(transform(word));
  }
  return newList;
}

List<int> processNumbers(List<int> numbers) {
  List<int> newList = [];
  for (var number in numbers) {
    if (number % 4 == 0) {
      continue;
    }
    var transform = (int number) => (number <= 10) ? number * 2 : number - 5;
    newList.add(transform(number));
  }
  return newList;
}

Stream<int> filteredStream() async* {
  for (int i = 1; i <= 30; i++) {
    await Future.delayed(Duration(milliseconds: 300));
    if (i % 3 == 0) {
      continue;
    }
    var number = (int number) => (number % 2 == 0) ? number ~/ 2 : number * 5;
    yield number(i);
  }
}

class Student {
  final String name;
  final int age;
  final double gpa;
  final String? major;

  Student(this.name, this.age, {required this.gpa, this.major});

  Student.honor(this.name, this.age) : gpa = 4.0, major = "Honors";

  factory Student.toMap(Map<String, dynamic> data) {
    return Student.honor(data['name'], data['age']);
  }

  String status(double gpa) {
    if (gpa >= 3.5) {
      return "Excellent";
    } else if (gpa >= 2.0 && gpa <= 3.49) {
      return "Good";
    } else {
      return "Probation";
    }
  }

  @override
  String toString() {
    return 'Name: $name\nAge: $age\nGpa: $gpa\nMajor: $major';
  }
}

Stream<String> numberStream() async* {
  for (int i = 1; i <= 40; i++) {
    await Future.delayed(Duration(milliseconds: 200));
    if (i == 30) {
      break;
    }
    if (i % 5 == 0) {
      continue;
    }
    var transform = (int number) =>
        (number % 2 == 0) ? 'Even: $number' : 'Odd: $number';
    yield transform(i);
  }
}

bool _isPrime(int num) {
  if (num < 2) {
    return false;
  }
  for (int i = 0; i * i <= num; i++) {
    if (num % i == 0) {
      return false;
    }
  }
  return true;
}

Stream<String> complexNumberStream() async* {
  for (int i = 1; i <= 60; i++) {
    await Future.delayed(Duration(milliseconds: 150));
    if (i > 45) {
      break;
    }
    if (i % 4 == 0 || i < 5) {
      continue;
    }
    var transform = (int number) =>
        (number % 2 == 0) ? 'Even: $number' : 'Odd: $number';
    String output = transform(i);
    if (_isPrime(i)) {
      output += "-Prime";
    }
    yield output;
  }
}

class Vehicle {
  final String brand;
  final int year;

  Vehicle(this.brand, this.year);

  String info() {
    return 'Vehicle:\nBrand: $brand\nYear: $year';
  }

  bool isClassic() {
    return (year > 2000) ? true : false;
  }
}

class Car extends Vehicle {
  final int doors;

  Car(String brand, int year, this.doors) : super(brand, year);

  @override
  String info() {
    return '${super.info()}\nNumber of doors: $doors';
  }
}

class ElectricCar extends Car {
  final int batteryCapacity;

  ElectricCar(String brand, int year, int doors, this.batteryCapacity)
    : super(brand, year, doors);

  @override
  String info() {
    return '${super.info()}\nBattery Capacity: $batteryCapacity';
  }
}
