import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false,));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String googleMapsURL =
      "https://www.google.com/maps/dir/?api=1&origin=45.5144626,-73.6755719&destination=45.501689,-73.567256";

  Future<void> _openMap() async {
    final Uri uri = Uri.parse(googleMapsURL);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not connect to google maps!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get directions'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _openMap,
          child: const Text('Open Directions in Google Maps'),
        ),
      ),
    );
  }
}
