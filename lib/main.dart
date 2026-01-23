import 'package:flutter/material.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, //removes the debug banner
      home: MyDesignApp(),
    );
  }
}

class MyDesignApp extends StatelessWidget {
  const MyDesignApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Hi',
              style: TextStyle(fontSize: 45, fontFamily: 'Impact'),
            ),
            SizedBox(height: 20),
            Text('GM'),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //the snack bar is a little bar that appears and disapears after something happens
                      content: Text('Login successful')));
                },
                child: Text('Login')),
            SizedBox(height: 20),
            Container(
              height: 200,
              width: 300,
              color: Colors.black,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/hippo.jpg',
                    height: 200, width: 300, fit: BoxFit.cover),
                SizedBox(height: 10),
                Image.asset('assets/hippo.jpg',
                    height: 200, width: 300, fit: BoxFit.cover)
              ],
            ),
            Icon(
              Icons.beach_access,
              color: Colors.amber,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
