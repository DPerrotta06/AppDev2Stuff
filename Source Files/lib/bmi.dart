import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: BMIApp(), debugShowCheckedModeBanner: false));
}

class BMIApp extends StatefulWidget {
  const BMIApp({super.key});

  @override
  State<BMIApp> createState() => _BMIAppState();
}

class _BMIAppState extends State<BMIApp> {
  String gender = '';
  int weight = 60;
  double height = 170;
  int age = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        title: Text(
          'BMI Calculator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        gender = 'male';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.male,
                              color: Colors.orangeAccent,
                              size: 130,
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Male',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                  InkWell(
                    onTap: () {
                      setState(() {
                        gender = 'female';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.female,
                              color: Colors.pinkAccent.shade200,
                              size: 130,
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Female',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28),
              Container(
                decoration: BoxDecoration(
                  color: Colors.indigo.shade400,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Height (in cm)',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        height.toStringAsFixed(0),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                      ),
                      Slider(
                        value: height,
                        min: 65,
                        max: 250,
                        activeColor: Colors.white,
                        inactiveColor: Colors.white24,
                        onChanged: (value) {
                          setState(() {
                            height = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 170,
                    height: 210,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              'Weight (in kg)',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              weight.toStringAsFixed(0),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                            ),
                            Slider(
                              value: weight.toDouble(),
                              min: 30,
                              max: 150,
                              activeColor: Colors.white,
                              inactiveColor: Colors.white24,
                              onChanged: (value) {
                                setState(() {
                                  weight = value.toInt();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    width: 170,
                    height: 210,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              'Age',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(height: 60),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _counterButton('-', _decrement),
                                SizedBox(width: 8),
                                Text(
                                  '$age',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                _counterButton('+', _increment),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(18),
                ),
                onPressed: () {
                  _showBmi(context);
                },
                child: Text(
                  'BMI',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double calculateBmi() {
    return weight / (pow(height / 100, 2));
  }

  String get bmiCategory {
    if (calculateBmi() < 18.5) return 'Underweight';
    if (calculateBmi() < 25) return 'Normal';
    if (calculateBmi() < 30) return 'Overweight';
    return 'Obese';
  }

  Widget _counterButton(String label, VoidCallback onPress) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white70),
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Text(
          textAlign: TextAlign.center,
          label,
          style: TextStyle(fontSize: 28, color: Colors.white70),
        ),
      ),
    );
  }

  void _increment() {
    setState(() {
      age++;
    });
  }

  void _decrement() {
    setState(() {
      (age <= 0) ? age = 0 : age--;
    });
  }

  Future<void> _showBmi(BuildContext context) async {
    final bmi = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
      builder: (context) {
        return Container(
          color: Colors.indigo.shade400,
          child: StatefulBuilder(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'You are $bmiCategory.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
