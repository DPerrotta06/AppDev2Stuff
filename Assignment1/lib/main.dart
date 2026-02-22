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
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(),
        '/secondScreen': (context) => SecondScreen(),
        '/secondScreen/thirdScreen': (context) => ThirdScreen(),
        '/secondScreen/thirdScreen/fourthScreen': (context) => FourthScreen(),
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
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: AppBar(backgroundColor: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/first_page.jpg'),
            SizedBox(height: 10),
            Text('Welcome to Book Store'),
            SizedBox(height: 100),
            SizedBox(
              width: 250,
              child: TextField(
                textAlign: TextAlign.center,
                controller: name,
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  labelStyle: TextStyle(color: Colors.red),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(180),
                  ),
                ),
              ),
            ),
            SizedBox(height: 80),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/secondScreen',
                  arguments: name.text,
                );
              },
              child: Text(
                'Visit',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.lightGreenAccent,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.lightGreenAccent,
                  decorationThickness: 2,
                ),
              ),
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
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String? username =
        ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text('Book Store', style: TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                '$username', //username goes here
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.black,
                  decorationThickness: 2,
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(36),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: search,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Search here',
                  icon: Icon(Icons.search),
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: _buildList(username!),
    );
  }

  Widget _buildList(String username) {
    return ListView(
      children: [
        _tile('assets/book1.jpg', 'Coffeehouse', 1500.0, 1, username),
        Divider(),
        SizedBox(height: 5),
        _tile('assets/book2.jpg', 'Taming Jaguar', 1500.0, 550, username),
        Divider(),
        SizedBox(height: 5),
        _tile(
          'assets/book2.jpg',
          'Jaguar Development with PowerBuilder 7',
          1500.0,
          250,
          username,
        ),
        Divider(),
        SizedBox(height: 5),
        _tile(
          'assets/book3.jpg',
          'Learn Python Programming',
          750.34,
          375,
          username,
        ),
        Divider(),
        SizedBox(height: 5),
      ],
    );
  }

  Widget _tile(
    String bookImage,
    String title,
    double mrp,
    int price,
    String username,
  ) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/secondScreen/thirdScreen',
                  arguments: {
                    'username': username,
                    'title': title,
                    'bookImage': bookImage,
                    'mrp': mrp,
                    'price': price,
                  },
                );
              },
              child: Image.asset(
                bookImage,
                width: 170,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent,
                      fontSize: 20,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'M.R.P: ',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '\$$mrp',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.black,
                            decorationThickness: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Price: ',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '\$$price',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset('assets/sale.jpg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>?;
    final username = data?['username'] as String;
    final title = data?['title'] as String;
    final bookImage = data?['bookImage'] as String;
    final mrp = data?['mrp'] as double;
    final price = data?['price'] as int;
    final int total = price * counter;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text('Book Store', style: TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                username,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.black,
                  decorationThickness: 2,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontSize: 20,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Image.asset('assets/sale.jpg'),
                Padding(padding: EdgeInsets.all(31)),
                Image.asset(bookImage, height: 250, width: 150),
              ],
            ),
            SizedBox(height: 30),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'M.R.P.: ',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '\$$mrp',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      decorationColor: Colors.black,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 3,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Price: ',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '\$$total',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              height: 50,
              color: Colors.orange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _counterButton('+', () => _increment(price)),
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/secondScreen/thirdScreen/fourthScreen',
                        arguments: {'username': username, 'total': total},
                      );
                    },
                    child: Text(
                      'Buy',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  _counterButton('-', () => _decrement(price)),
                ],
              ),
            ),
            SizedBox(height: 25),
            SizedBox(
              height: 23,
              child: Text(
                'About this Item',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Container(
              width: 500,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Description\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: _getDescription(title),
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _increment(int price) => setState(() {
    counter++;
  });

  void _decrement(int price) => setState(() {
    (counter <= 1) ? counter = 1 : counter--;
  });

  String _getDescription(String title) {
    if (title == 'Coffeehouse') {
      return "Coffeehouse is an anthology of stories, poems and essays originally published on the World Wide Web. The purpose is to capture the zeitgeist of the web's creative community, and to give readers a chance to enjoy some of the best and most notable original works that have appeared in this form.";
    } else if (title == 'Taming Jaguar') {
      return "Taming the Jaguar is a comprehensive guide to mastering Sybase's Jaguar CTS (Component Transaction Server). It covers building and deploying distributed components, helping developers harness the full power of enterprise application development with practical examples and real-world solutions.";
    } else if (title == 'Jaguar Development with PowerBuilder 7') {
      return "Jaguar Development with PowerBuilder 7 is an in-depth resource for developers building enterprise applications using PowerBuilder 7 with Sybase's Jaguar CTS. It explores component-based development, distributed architecture, and how to effectively integrate PowerBuilder with Jaguar for scalable business solutions.";
    } else {
      return "Learn Python Programming is a beginner-friendly guide to mastering Python, one of the world's most popular programming languages. It covers core concepts such as data types, control flow, functions, object-oriented programming, and file handling, providing hands-on examples and practical projects to help readers build real-world applications with confidence.";
    }
  }

  Widget _counterButton(String label, VoidCallback onPress) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 70,
        height: 30,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        alignment: Alignment.center,
        child: Text(label, style: TextStyle(fontSize: 20, color: Colors.black)),
      ),
    );
  }
}

class FourthScreen extends StatefulWidget {
  const FourthScreen({super.key});

  @override
  State<FourthScreen> createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, Object>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>?;
    final username = data?['username'] as String;
    final total = data?['total'] as int;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text('Book Store', style: TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                username,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.black,
                  decorationThickness: 2,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Pay using UPI \$$total',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Thanks for the payment of 5 dollars, your request has been processed!',
                      ),
                    ),
                  );
                },
                child: Text('Paytm', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Thanks for the payment of 5 dollars, your request has been processed!',
                      ),
                    ),
                  );
                },
                child: Text('PhonePe', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Thanks for the payment of 5 dollars, your request has been processed!',
                      ),
                    ),
                  );
                },
                child: Text(
                  'GooglePlay',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 60),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/secondScreen',
                      arguments: username,
                    );
                  },
                  child: Text(
                    'Home',
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
