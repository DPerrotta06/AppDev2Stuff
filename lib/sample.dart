import "dart:io";

void main() {
  var emoji = '\u2665';
  print(emoji);
  operators();
  print(reverseNum(952));
  fibonacci();
  print("");
  print(factorial(5));
  off_pyramid(5);
  off_num_pyramid_1(4);
  off_num_pyramid_2(3);
}

void operators() {
  print("Example of operators:");
  var n1 = 10;
  var n2 = 5;
  print("n1+n2 = ${n1 + n2}");
  print("n1-n2 = ${n1 - n2}");
  print("n1*n2 = ${n1 * n2}");
  print("n1/n2 = ${n1 / n2}");
  print("n1%n2 = ${n1 % n2}");
}

int reverseNum(int num) {
  var remainder = 0;
  var reversed = 0;
  while (num > 0) {
    remainder = num % 10;
    reversed = reversed * 10 + remainder;
    num = num ~/ 10; //divides to a whole int number
  }
  return reversed;
}

void fibonacci() {
  var first = 0;
  var second = 1;
  var third = 0;
  stdout.write("${first} ");
  stdout.write("${second} ");
  for (int i = 0; i <= 10; i++) {
    third = first + second;
    stdout.write("${third} ");
    first = second;
    second = third;
  }
}

int factorial(int num) {
  int result = 1;
  for (int i = 1; i <= num; i++) {
    result *= i;
  }
  return result;
}

void off_pyramid(int rows) {
  for (int i = 0; i <= rows; i++) {
    for (int j = 0; j <= i; j++) {
      stdout.write(" *");
    }
    print('');
  }
}

void off_num_pyramid_1(int rows) {
  int start = 1;
  for (int i = 0; i <= rows; i++) {
    for (int j = 0; j <= i; j++) {
      stdout.write(" ${start}");
      start++;
    }
    print('');
  }
}

void off_num_pyramid_2(int rows) {
  int start = 1;
  for (int i = 0; i <= rows; i++) {
    for (int j = 0; j <= i; j++) {
      stdout.write(" ${start}");
    }
    print('');
    start++;
  }
}

void off_char_pyramid_3(int rows) {
  int start = 97;
  for (int i = 0; i <= rows; i++) {
    for (int j = 0; j <= i; j++) {
      stdout.write(" ${String.fromCharCode(start)}");
    }
    print('');
    start++;
  }
}
