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
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(),
        '/secondScreen': (context) => SecondScreen(),
      },
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    final double price = 8.99;
    final double total = price * counter;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black26,
          actions: [
            CircleAvatar(
              backgroundColor: Colors.black45,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.shopping_bag_outlined, color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white24,
        body: Center(
          child: Column(
            children: [
              Text(
                'FRUITS',
                style: TextStyle(
                  color: Colors.yellowAccent,
                  letterSpacing: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'BlueBerry',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.yellow, size: 20),
                  Text(' (121 Reviews)', style: TextStyle(color: Colors.grey)),
                ],
              ),
              SizedBox(height: 30),
              Image.asset('assets/blueberries.jpg'),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      text: '\$8.99\n',
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                      children: [
                        TextSpan(
                          text: 'PER KG',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 10,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 110),
                  CircleAvatar(
                    backgroundColor: Colors.white24,
                    radius: 30,
                    child: Icon(Icons.favorite, color: Colors.redAccent),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white24,
                    radius: 40,
                    child: Icon(
                      Icons.thumb_up_off_alt_outlined,
                      color: Colors.amber,
                    ),
                  ),
                  SizedBox(width: 30),
                  CircleAvatar(
                    backgroundColor: Colors.white24,
                    radius: 40,
                    child: Icon(Icons.star_outline, color: Colors.amber),
                  ),
                  SizedBox(width: 30),
                  CircleAvatar(
                    backgroundColor: Colors.white24,
                    radius: 40,
                    child: Icon(
                      Icons.local_dining_outlined,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Quality\nAssurance',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 55),
                  Text('Highly\nRated', style: TextStyle(color: Colors.white)),
                  SizedBox(width: 70),
                  Text(
                    'Best-in\nTaste',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(180),
                        ),
                        width: 170,
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _counterButton('-', () => _decrement(price)),
                            Text(
                              '$counter',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            _counterButton('+', () => _increment(price)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        fixedSize: Size(170, 80),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/secondScreen',
                          arguments: price,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Go to Cart',
                            style: TextStyle(color: Colors.black),
                          ),
                          Icon(Icons.arrow_forward, color: Colors.black),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _increment(double price) => setState(() {
    counter++;
  });

  void _decrement(double price) => setState(() {
    (counter <= 1) ? counter = 1 : counter--;
  });

  Widget _counterButton(String label, VoidCallback onPress) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 40,
        height: 30,
        decoration: BoxDecoration(border: Border.all(color: Colors.black45)),
        alignment: Alignment.center,
        child: Text(label, style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    final int? total = ModalRoute.of(context)?.settings.arguments as int?;
    return Text('\$$total');
  }
}
