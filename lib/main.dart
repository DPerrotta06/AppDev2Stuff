import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  /*var i; //by default var is null
  int? j = null; //allows something to be nullable
  print(j);
  print("Enter the first value: ");
  var firstValue =
      double.parse(stdin.readLineSync()!); //! enforces the users not to enter null
  print("Enter the second value: ");
  var secondValue = double.parse(stdin.readLineSync()!);
  var sum = firstValue + secondValue;
  print(sum);*/
  A a = A();
  a.name = 'Daniel';
  a.age = 20;
  a._ssn = 12345;
  print('${a._ssn} : ${a.name}');
}

class A {
  var name; //no underscore means public
  var age;
  var _ssn; //this is private

  get ssn => _ssn;

  set ssn(value) {
    _ssn = value;
  }
}
