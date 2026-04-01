import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: const MyMainClass(),
      title: const Text(
        'Welcome to my app',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
      ),
      image: Image.network(
          'https://www.acouplecooks.com/wp-content/uploads/2021/08/Jagermeister-Drink-009.jpg'),
      photoSize: 100,
      loaderColor: Colors.blueAccent,
      backgroundColor: Colors.lightGreenAccent,
      styleTextUnderTheLoader: const TextStyle(),
      loadingText: const Text(
        'Preparing your drink...',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
      ),
      loadingTextPadding: const EdgeInsets.only(top: 20),
      useLoader: true,
    );
  }
}

class MyMainClass extends StatelessWidget {
  const MyMainClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Landing Page'),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          children: [Text('My Home Page')],
        ),
      ),
    );
  }
}
