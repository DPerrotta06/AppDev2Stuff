import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //set the initial slider value
  int _initValue = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider Demo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Icon(
              Icons.volume_up,
              size: 40,
            ),
            Expanded(
                child: Slider(
                    value: _initValue.toDouble(),
                    max: 20.0,
                    min: 1.0,
                    divisions: 10,
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey,
                    label: 'Set your volume',
                    onChanged: (newValue) => setState(() {
                          _initValue = newValue.round();
                        })))
          ],
        ),
      ),
    );
  }
}
