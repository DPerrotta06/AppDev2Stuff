import 'package:flutter/material.dart';
import 'package:myapplication/main.dart';

void main() { //starting point like in javafx
  runApp(MyFirstApp());
}

class MyFirstApp extends StatelessWidget {
  const MyFirstApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyDemo(),
    ); //returning a Widget type
  }
}

class MyDemo extends StatelessWidget {
  const MyDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My First Program'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center( // y orientation
        child: Column( //x orientation
          children: [
            Text('Hi', style: TextStyle(fontSize:  40),),
            SizedBox(height: 20,),
            Text('Vanier', style: TextStyle(fontSize:  40)),
            SizedBox(height: 20,),
            Text('Mobile', style: TextStyle(fontSize: 40),),
            SizedBox(height: 30,),
            ElevatedButton(
                onPressed: (){ //anonymous function (has no name)
                  //code goes here
                },
                child: Text('Login', style: TextStyle(fontSize: 20),)
            )
          ],
        ),
      ),
    );
  }
}


