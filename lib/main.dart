import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: LocalJson(), debugShowCheckedModeBanner: false);
  }
}

class LocalJson extends StatefulWidget {
  const LocalJson({super.key});

  @override
  State<LocalJson> createState() => _LocalJsonState();
}

class _LocalJsonState
    extends State<LocalJson> /*with SingleTickerProviderStateMixin*/ {
  //late AnimationController _controller;
  List _items = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString("assets/sample.json");
    final realData = await json.decode(response);
    setState(() {
      _items = realData["items"]; // the key from your json file
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch local json'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      backgroundColor: Colors.blueAccent,
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            ElevatedButton(onPressed: readJson, child: Text('Fetch json data')),
            _items.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: _items.length,
                        //NEED THIS TO TELL HOW MUCH THE PROGRAM NEEDS TO ITERATE OVER THE JSON FILE
                        itemBuilder: (context, index) {
                          return Card(
                              margin: EdgeInsets.all(16),
                              child: ListTile(
                                  leading: Text(_items[index]["id"]),
                                  title: Text(_items[index]["name"]),
                                  subtitle:
                                      Text(_items[index]["description"])));
                        }))
                : Container()
          ],
        ),
      ),
    );
  }
}
