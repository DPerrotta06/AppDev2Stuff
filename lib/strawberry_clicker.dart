import 'package:flutter/material.dart';

void main() {
  runApp(Stless());
}

class Stless extends StatelessWidget {
  const Stless({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Stful());
  }
}

class Stful extends StatefulWidget {
  const Stful({super.key});

  @override
  State<Stful> createState() => _StfulState();
}

class _StfulState extends State<Stful> {
  int counter = 1;
  double price = 5.4;

  void increase() {
    setState(() {
      counter++;
    });
  }

  void decrease() {
    setState(() {
      (counter <= 0) ? counter = 0 : counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double total = price * counter;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 380,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.amber, Colors.orangeAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/strawberries.webp',
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 50,
                right: 16,
                child: const Icon(Icons.menu, color: Colors.white, size: 28),
              ),
            ],
          ),

          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Strawberries',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const Text('1kg', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _counterButton('-', decrease),
                          const SizedBox(width: 16),
                          Text(
                            '$counter',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 16),
                          _counterButton('+', increase),
                        ],
                      ),
                      Text(
                        '\$${total.toStringAsFixed(1)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'Product Description',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Fresh strawberries packed with flavor. '
                    'Perfect for desserts, smoothies, or snacks.',
                    style: TextStyle(color: Colors.grey, height: 1.5),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(15),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Add to cart',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _counterButton(String label, VoidCallback onPress) {
    return InkWell(
      onTap: onPress,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
