import 'package:flutter/material.dart';

void main() {
  runApp(Count());
}

class Count extends StatelessWidget {
  const Count({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyCounterApp(),
    );
  }
}

class MyCounterApp extends StatefulWidget {
  //this class captures the current state of the app
  const MyCounterApp({super.key});

  @override
  State<MyCounterApp> createState() => _MyCounterAppState();
}

class _MyCounterAppState extends State<MyCounterApp> {
  //this class reruns the engine to display any updates to the new state
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Page'),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    counter++;
                  });
                },
                child: Text('+')),
            SizedBox(height: 20),
            Text('$counter'),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    if(counter <= 0) {
                      counter = 0;
                    }else{
                      counter--;
                    }
                  });
                },
                child: Text('-'))
          ],
        ),
      ),
    );
  }
}
