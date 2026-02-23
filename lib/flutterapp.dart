import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: MyController(), debugShowCheckedModeBanner: false);
  }
}

class MyController extends StatefulWidget {
  const MyController({super.key});

  @override
  State<MyController> createState() => _MyControllerState();
}

class _MyControllerState extends State<MyController> {
  TextEditingController num1 = TextEditingController();
  TextEditingController num2 = TextEditingController();
  int result = 0;

  void compute() {
    int n1 = int.tryParse(num1.text) ?? 0;
    int n2 = int.tryParse(num1.text) ?? 0;
    setState(() {
      result = n1 + n2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controller Demo'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.greenAccent,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: num1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter the first value'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: num2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter the second value'),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: compute, child: Text('Sum')),
            SizedBox(height: 10),
            Text('Result: $result',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
