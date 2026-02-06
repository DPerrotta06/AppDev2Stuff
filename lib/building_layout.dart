import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('TextStyles'),
        ),
        body: Center(
          //padding: EdgeInsets.all(16),
            child: _buildGrid() /*Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Headline 1',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              Text('Headline 2',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text('Large content',
                  style: TextStyle(fontSize: 18, color: Colors.black45)),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Text(
                'I am trying to find all the features',
                style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 3,
                    wordSpacing: 8,
                    height: 2,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.amber,
                    decorationStyle: TextDecorationStyle.wavy,
                    decorationThickness: 5,
                    backgroundColor: Colors.blue,
                    fontFamily: 'Roboto'),
              ),
              Divider(),
              SizedBox(height: 22),
              _buildImageColumn(),
              _buildGrid(),
              Divider(),
              SizedBox(height: 28),
              _buildGrid()
            ],
          ),*/
        ),
      ),
    );
  }
}

Widget _buildImageColumn() {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.black26,
    ),
    child: Column(
      children: [_buildImageRow(1), _buildImageRow(3)],
    ),
  );
}

Widget _buildImageRow(int index) =>
    Row(
      children: [_buildDecoratedImage(index), _buildDecoratedImage(index + 1)],
    );

Widget _buildDecoratedImage(int index) =>
    Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 10, color: Colors.black38),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        margin: const EdgeInsets.all(4),
        child: Image.asset('assets/pic$index.jpg'),
      ),
    );

Widget _buildGrid() =>
    GridView.extent(
        maxCrossAxisExtent: 150,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: _buildGridTileList(4));

List<Container> _buildGridTileList(int count) =>
    List.generate(
        count,
            (i) =>
            Container(
              child: Image.asset('assets/pic$i.jpg'),
            ));

Widget _buildStack() {
  return Stack(
    alignment: const Alignment(0.6, 0.6),
    children: [
      const CircleAvatar(
        backgroundImage: AssetImage('assets/pic1.jpg'),
        radius: 100,
      ),
      Container(
        decoration: const BoxDecoration(
            color: Colors.black45
        ),
        child: const Text('Mia B', style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
      )
    ],
  );
}