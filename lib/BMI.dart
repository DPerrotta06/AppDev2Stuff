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
      debugShowCheckedModeBanner: false,
      home: BMIPage(),
    );
  }
}

class BMIPage extends StatefulWidget {
  const BMIPage({super.key});

  @override
  State<BMIPage> createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  int selectedFeet = 5;
  int selectedInches = 7;
  final TextEditingController weightController = TextEditingController();
  double? bmi;

  void calculateBMI() {
    final double? weightLbs = double.tryParse(weightController.text.trim());
    if (weightLbs == null || weightLbs <= 0) return;

    final double totalInches = (selectedFeet * 12 + selectedInches).toDouble();
    final double heightMeters = totalInches * 0.0254;
    final double weightKg = weightLbs * 0.453592;

    setState(() {
      bmi = weightKg / (heightMeters * heightMeters);
    });
  }

  String get bmiCategory {
    if (bmi == null) return '';
    if (bmi! < 18.5) return 'Underweight';
    if (bmi! < 25) return 'Normal';
    if (bmi! < 30) return 'Overweight';
    return 'Obese';
  }

  Color get bmiColor {
    if (bmi == null) return Colors.black;
    if (bmi! < 18.5) return Colors.blue;
    if (bmi! < 25) return Colors.green;
    if (bmi! < 30) return Colors.orange;
    return Colors.red;
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Height
            const Text('Height', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: selectedFeet,
                    decoration: const InputDecoration(
                      labelText: 'Feet',
                      border: OutlineInputBorder(),
                    ),
                    items: List.generate(8, (i) => i + 1)
                        .map((e) => DropdownMenuItem(value: e, child: Text('$e ft')))
                        .toList(),
                    onChanged: (val) => setState(() => selectedFeet = val!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: selectedInches,
                    decoration: const InputDecoration(
                      labelText: 'Inches',
                      border: OutlineInputBorder(),
                    ),
                    items: List.generate(12, (i) => i)
                        .map((e) => DropdownMenuItem(value: e, child: Text('$e in')))
                        .toList(),
                    onChanged: (val) => setState(() => selectedInches = val!),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Weight
            const Text('Weight', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
              decoration: const InputDecoration(
                labelText: 'Pounds (lbs)',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 32),

            // Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculateBMI,
                child: const Text('Calculate BMI'),
              ),
            ),

            const SizedBox(height: 32),

            // Result
            if (bmi != null)
              Center(
                child: Column(
                  children: [
                    Text(
                      bmi!.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: bmiColor,
                      ),
                    ),
                    Text(
                      bmiCategory,
                      style: TextStyle(fontSize: 20, color: bmiColor),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}