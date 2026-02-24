import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CurrencyConverterScreen(),
    );
  }
}

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  // All rates relative to USD
  final Map<String, double> ratesFromUSD = {
    'USD': 1.0,
    'INR': 83.09,
    'EUR': 0.92,
    'CAD': 1.36,
    'GBP': 0.79,
  };

  final Map<String, String> currencyFlags = {
    'USD': '🇺🇸',
    'INR': '🇮🇳',
    'EUR': '🇪🇺',
    'CAD': '🇨🇦',
    'GBP': '🇬🇧',
  };

  String fromCurrency = 'USD';
  String toCurrency = 'INR';
  final TextEditingController amountController = TextEditingController();
  double? convertedAmount;

  void convert() {
    final double? amount = double.tryParse(amountController.text.trim());
    if (amount == null) {
      setState(() => convertedAmount = null);
      return;
    }
    // Convert: amount → USD → target
    final double inUSD = amount / ratesFromUSD[fromCurrency]!;
    setState(() {
      convertedAmount = inUSD * ratesFromUSD[toCurrency]!;
    });
  }

  void swapCurrencies() {
    setState(() {
      final temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
      convertedAmount = null;
      amountController.clear();
    });
  }

  double get exchangeRate {
    final double inUSD = 1.0 / ratesFromUSD[fromCurrency]!;
    return inUSD * ratesFromUSD[toCurrency]!;
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currencies = ratesFromUSD.keys.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),

              // ── Title ──────────────────────────────────────────
              const Text(
                'Currency Converter',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Check live exchange rates and convert currencies',
                style: TextStyle(color: Colors.grey, fontSize: 13),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // ── Card ───────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // From section
                    const Text(
                      'Amount',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        // Currency dropdown
                        _currencyDropdown(
                          value: fromCurrency,
                          items: currencies,
                          onChanged: (val) {
                            setState(() {
                              fromCurrency = val!;
                              convertedAmount = null;
                            });
                          },
                        ),
                        const SizedBox(width: 12),
                        // Amount input
                        Expanded(
                          child: TextField(
                            controller: amountController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            onChanged: (_) => convert(),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFF0F0F0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              hintText: '0.00',
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Swap button
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: GestureDetector(
                          onTap: swapCurrencies,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.swap_vert,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // To section
                    const Text(
                      'Converted Amount',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _currencyDropdown(
                          value: toCurrency,
                          items: currencies,
                          onChanged: (val) {
                            setState(() {
                              toCurrency = val!;
                              convertedAmount = null;
                            });
                          },
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F0F0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              convertedAmount != null
                                  ? convertedAmount!.toStringAsFixed(2)
                                  : '',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Exchange rate display ───────────────────────────
              Text(
                'Exchange Rates',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              const SizedBox(height: 4),
              Text(
                '1 $fromCurrency = ${exchangeRate.toStringAsFixed(5)} $toCurrency',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _currencyDropdown({
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          items: items.map((currency) {
            return DropdownMenuItem(
              value: currency,
              child: Row(
                children: [
                  Text(
                    currencyFlags[currency]!,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    currency,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
