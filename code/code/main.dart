import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyBD(),
    );
  }
}

class MyBD extends StatelessWidget {
  const MyBD({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Happy Birthday',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Image.asset('assets/cake.jpg', ),
            SizedBox(height: 10,),
            ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).
                  showSnackBar(SnackBar(content: Text('have Fun')));
                },
                child: Text('Wish me')),
            SizedBox(
              height: 60,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'To my Friend',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
