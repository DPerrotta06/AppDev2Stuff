import 'package:flutter/material.dart';

void main() {
  runApp(const MyListView());
}

class MyListView extends StatelessWidget {
  const MyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          centerTitle: true,
          title: Row(
            children: [
              Text(
                'Cities Around The World',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: _buildList(),
      ),
    );
  }
}

Widget _buildList() {
  return ListView(
    children: [
      _tile('assets/delhi.jpg', 'Delhi', 'India', 'Population: 19 mil'),
      Divider(),
      SizedBox(height: 5),
      _tile('assets/london.jpg', 'London', 'Britain', 'Population: 8 mil'),
      Divider(),
      SizedBox(height: 5),
      _tile(
        'assets/vancouver.jpg',
        'Vancouver',
        'Canada',
        'Population: 2.4 mil',
      ),
      Divider(),
      SizedBox(height: 5),
      _tile('assets/ny.jpg', 'New York', 'USA', 'Population: 8.1 mil'),
    ],
  );
}

Widget _tile(
  String countryPic,
  String city,
  String country,
  String population,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image.asset(countryPic, width: 200, height: 150, fit: BoxFit.contain),
      ListTile(
        title: Text(
          city,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: Text(
          '$country\n$population',
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ),
    ],
  );
}
