void main() {
  // creating a list
 //  var list1 = <int>[23, 4, 32, 7, 76, 6, 100, 100];
 //  print(list1);
 //  // enhanced for loop
 //  for(var i in list1) {
 //    print(i);
 //  }
 // // multiplication table
 //  var table_no = 2;
 //  var max_val = 10;
 //  for(int i = 1 ; i<=table_no;i++) {
 //    for(int j = 1; j<=max_val; j++) {
 //      print("${i} * ${j} = ${i*j}");
 //    }
 //  }
 // // create a function
 //  int summary(int i, int j) {
 //    return i + j;
 //  }
 //  var result =  summary(15,42);
 //  print(result);
 //  // wap to find the smallest int in the list
 //  var smallNumber = list1[0]; //23
 //  for (int i = 1; i < list1.length; i++) {
 //    if (list1[i] < smallNumber) {
 //      smallNumber = list1[i];
 //    }
 //  }
 //  print(smallNumber);
 //  // create a set
 //  var mySet = <String>{};
 //  mySet.add('apple');
 //  mySet.add('orange');
 //  mySet.add('Lemon');
 //  mySet.add('Lemon');
 //  print(mySet);
 //  print(mySet.contains('pineapple'));
 //  mySet.remove('apple');
 //  print(mySet);
 //
 //  // create a map key-value pair
 //  var myMap = <String, int>{};
 //  myMap['apple'] = 100;
 //  myMap['lemon'] = 200;
 //  myMap['lime'] = 300;
 //  print(myMap);
 //  print(myMap['lemon']);
 //  myMap.remove('lime');
 //  print(myMap.containsKey('vanier'));
 //
 //  var n1 = 3343;
 //  var n2 = 454;
 //  var n3 = 23422;
 //  // wap to find the largest using nested if among n1,n2,n3
 //  if (n1 > n2) {
 //    if (n1 > n3) {
 //      print('n1 is the largest number');
 //    } else {
 //      print('n3 is the largest number');
 //    }
 //  } else if (n2 > n3) {
 //    print('n2 is the largest number');
 //  } else {
 //    print('n3 is the largest number');
 //  }
 //  // enhanced for loop

  // wap to create an anonymous function

  var newList = ['tim','tommy','katy','timothee'];
  print(newList);
  newList.forEach((item) {
    print('${newList.indexOf(item)} : $item');
  });

  // create a lambda expression/arrow function
  var multiply = (int a, int b) => a * b;
  var result = multiply(3,5);
  print(result);
  // recursive function to find the factorial of 6
  var factvalue = 6;
  var factresult =  recfunction(factvalue);
  print(factresult);

}

int recfunction(int factvalue) {
  if(factvalue <=1)
    return 1;
  else
    return factvalue * recfunction(--factvalue);
}

