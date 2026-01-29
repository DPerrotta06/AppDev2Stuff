import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LakeProject(),
    );
  }
}

class LakeProject extends StatelessWidget {
  const LakeProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/cake.jpg', ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('OeschenNien Lake'),
                    SizedBox(height: 5,),
                    Text('Kandersteg Swiss'),
                  ],
                ),
                Column(
                  children: [
                    Text('*41'),

                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.star,
                      color: Colors.red,),
                    Text('CALL')],

                ),
                Column(
                  children: [
                    Icon(Icons.star,
                      color: Colors.red,),
                    Text('CALL')],

                ),
                Column(
                  children: [
                    Icon(Icons.star,
                      color: Colors.red,),
                    Text('CALL')],

                )
              ],
            )


          ],
        ),
      ),
    );
  }
}
