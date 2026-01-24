import 'package:flutter/material.dart';

void main() {
  runApp(Birthday());
}

class Birthday extends StatelessWidget {
  const Birthday({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: BirthdayApp());
  }
}

class BirthdayApp extends StatelessWidget {
  const BirthdayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Happy Birthday'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/birthday.jpg',
                    height: 600, width: 1000, fit: BoxFit.cover),
              ],
            ),
            SizedBox(height: 40),
            ElevatedButton(onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Button Clicked')));
            }, child: Text('Click Me')),
            SizedBox(height: 45),
            Text('my friend!')
          ],
        ),
      ),
    );
  }
}
