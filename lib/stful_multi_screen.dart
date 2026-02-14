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
      //THIS SECTION KIND OF ACTS LIKE A FILE DIRECTORY OR MAP OF ALL THE SCREEN IN YOUR APPLICATION IS THE BETTER PRACTICE OF IT
      initialRoute: '/',
      //home
      routes: {
        '/': (context) => FirstScreen(),
        //home
        '/landingPage': (context) => SecondScreen(),
        //the second page after home
      },
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirtState();
}

class _FirtState extends State<FirstScreen> {
  List<String> fruits = ["Mango", "Apple", "Dragon fruit", "Lemon"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/landingPage', arguments: fruits); //pushNamed method is similar to the push, only difference is instead of saying
                // what class or widget you want directly you are using string based navigation and builds whatever widget is under that path and you can pass arguments
              },
              child: Text('Click Me'),
            ),
          ],
        ),
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
    final List? data = ModalRoute.of(context)?.settings.arguments as List?; // get the value of the context of the current route and allowing it to be null or empty.
    // Then we retrieve was passed in the arguments and then casting it a list and then allowing it to be null.
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          children: [
            Text('Once again'),
            SizedBox(height: 10),
            Text('Data: $data'),
            Expanded(
              child: ListView.builder(
                itemCount: data?.length, //can be null to prevent a crash
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Center(
                      child: Text(data![index], textAlign: TextAlign.center), //using null assertion to let the compiler know not to crash if the list is null
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
