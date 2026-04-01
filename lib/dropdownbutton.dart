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
  //create a container that holds values in the dropdown list
  var countries = ['USA', 'Canada', 'Italy', 'Spain', 'France'];

  //set an item in the list to be shown by default
  String dropdownValue = 'USA';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown menu'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            DropdownButton(
                value: dropdownValue,
                items:
                    countries //map function needed to transform dropdown menu into a string list
                        .map((country) => DropdownMenuItem(
                            value: country, child: Text(country)))
                        .toList(),
                onChanged: (newValue) => setState(() {
                      dropdownValue = newValue!; //non nullable
                    }))
          ],
        ),
      ),
    );
  }
}
