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
  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        initialDate: currentDate,
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Picker Demo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(currentDate.toString()),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Select a new Date'))
          ],
        ),
      ),
    );
  }
}
