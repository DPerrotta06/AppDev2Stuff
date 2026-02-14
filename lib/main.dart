import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyNavigatorDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyNavigatorDemo extends StatelessWidget {
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();
  List<String> fruits = ["Mango", "Apple", "Dragon fruit", "Lemon"]; //list of test data but usually you are getting data from databases or apis

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First screen'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          children: [
            Text('First screen with yuser data'),
            SizedBox(height: 10),
            TextField(
              controller: login,
              decoration: InputDecoration(labelText: 'Enter your username'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: password,
              decoration: InputDecoration(
                labelText: 'Enter your password here',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                //THIS SECTION IS WHAT HANDLES THE NAVIGATION LOGIC FROM ONE PAGE TO ANOTHER
                Navigator.push( //push moves to a new screen
                  context,
                  MaterialPageRoute( //MaterialPageRoute defines what the screen will contain as data
                    builder: (context) => MySecondClass( //we are specifying what class it is based on
                      //using named parameters that are also required
                      data: login.text,
                      data1: password.text,
                      container: fruits,
                    ),
                  ),
                );
              },
              child: Text('Move to next page -->'),
            ),
          ],
        ),
      ),
    );
  }
}

class MySecondClass extends StatelessWidget {
  final String data;
  final String data1;
  final List<String> container;

  MySecondClass({
    required this.data,
    required this.data1,
    required this.container,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second screen')),
      backgroundColor: Colors.cyan,
      body: Center(
        child: Column(
          children: [
            Text('Welcome to the second screen'),
            SizedBox(height: 10),
            Text(
              'Data from the first screen $data and my second screen $data1',
            ),
            SizedBox(height: 10),
            Text('Container: $container'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); //the pop method removes the current screen from the stack of screens
              },
              child: Text('<-- Go back to previous page'),
            ),
            Expanded( //Expanded prevents overflow when displaying something
              child: ListView.builder( //the builder method builds only visible widget items and data
                itemCount: container.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Center(
                      child: Text(
                        container[index],
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
