import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AudioPlayer audio = AudioPlayer();

  MyApp({super.key});

  void playNote(int note) {
    audio.play(AssetSource('audios/note$note.wav'));
  }

  Widget _buildKey(Color c, int note) {
    return InkWell(
      onTap: () {
        playNote(note);
      },
      child: Container(color: c, height: 119, width: double.infinity),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          centerTitle: true,
          title: const Text(
            'Flutter Xylophone',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildKey(Colors.red, 1),
            _buildKey(Colors.orange, 2),
            _buildKey(Colors.yellow, 3),
            _buildKey(Colors.green, 4),
            _buildKey(Colors.teal, 5),
            _buildKey(Colors.blue, 6),
            _buildKey(Colors.purple, 7),
          ],
        ),
      ),
    );
  }
}
