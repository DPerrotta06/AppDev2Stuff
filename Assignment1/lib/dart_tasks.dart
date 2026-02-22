
Future<void> main() async {
  List<String> fruits = ['apple', 'banana', 'orange', 'grapes', 'mango'];
  print(longestString(fruits));
  List<int> nums = [1, 2, 3, 4, 5];
  int squared(int num) => num * num;
  print(sumOfSquares(nums, squared));
  Person p = new Person.fromNameAndAge("Daniel", 20);
  print(p._name);
  print(p._age);
  print(sum(nums));
  print(calculateArea(5));
  print('Hello ');
  await for (var msg in delayedPrint('there ', 5000));
  print('world!');
  BankAccount ba = new BankAccount.named(1, "Daniel", 5000);
  ba.deposit(2000);
  print(ba.balance);
  ba.withdraw(10000);
  List<int> numbers = [1, 2, 3, 2, 4, 5, 3, 6];
  print(findUniqueElements(numbers));
  print(isPalindrome('racecar'));
  Map<String, int> salaries = { "Alice": 48000, "Bob": 52000, "Charlie": 76000, "Diana": 70000, "Evan": 60000 };
  salaryFilter(salaries);
}

String longestString(List<String> str) {
  String longest = '';
  str.forEach((word) {
    if (word.length > longest.length) {
      longest = word;
    }
  });
  return longest;
}

int sumOfSquares(List<int> numbers, int Function(int n) f) {
  int total = 0;
  for (var num in numbers) {
    total += f(num);
  }
  return total;
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
}

int sum([List<int>? nums]) {
  int total = 0;
  nums?.forEach((number) {
    total += number;
  });
  return total;
}

int calculateArea([int? length, int? width]) {
  if (length != null && width != null) {
    return length * width;
  } else if (length != null) {
    return length * length;
  } else {
    return 0;
  }
}

Stream<void> delayedPrint(String message, int delayMillis) async* {
  await Future.delayed(Duration(milliseconds: delayMillis));
  print(message);
}

class BankAccount {
  int _accountNumber;
  String _accountHolderName;
  double _balance;

  BankAccount(this._accountNumber, this._accountHolderName, this._balance);

  BankAccount.named(
    this._accountNumber,
    this._accountHolderName,
    this._balance,
  );

  double get balance => _balance;

  set balance(double value) {
    _balance = value;
  }

  String get accountHolderName => _accountHolderName;

  set accountHolderName(String value) {
    _accountHolderName = value;
  }

  int get accountNumber => _accountNumber;

  set accountNumber(int value) {
    _accountNumber = value;
  }

  void deposit(double amount) {
    if (amount > 0) {
      balance += amount;
    } else {
      print('Amount cannot be negative!');
    }
  }

  void withdraw(double amount) {
    if (amount < 0) {
      print('Amount cannot be negative!');
    } else if (amount > balance) {
      print('Insufficient funds!');
    } else {
      balance -= amount;
    }
  }
}

List<int>? findUniqueElements(List<int>? numbers) {
  return numbers?.toSet().toList();
}

bool isPalindrome(String word) {
  //maybe
  word = word.toLowerCase();
  if (word[0] != word[word.length - 1]) {
    return false;
  }
  for (int i = 0; i < word.length; i++) {
    for (int j = i + 1; j < word[i].length; j++) {
      if (word[i] != word[j]) {
        return false;
      }
    }
  }
  return true;
}

void salaryFilter(Map<String, int> salaries) {
  salaries.forEach((name, salary) {
    if (salary >= 50000 && salary <= 75000) {
      print(name);
    }
  });
}
