import 'Album.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Album>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: Scaffold(
        appBar: AppBar(title: const Text('Fetch Data Example')),
        body: Center(
          child: FutureBuilder<List<Album>>(
              //used for asynchronous data sources like cloud json data
              future: futureAlbum,
              builder: (context, snapshot) {
                //THE SNAPSHOT IS A CHUNK OF DATA FROM THE CLOUD
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      //NEED THIS TO TELL HOW MUCH THE PROGRAM NEEDS TO ITERATE OVER THE JSON FILE
                      itemBuilder: (context, index) {
                        return Card(
                            margin: EdgeInsets.all(16),
                            child: ListTile(
                                leading: Text(
                                    'User ID: ${snapshot.data![index].userId}'),
                                title: Text('ID: ${snapshot.data![index].id}'),
                                subtitle: Text(snapshot.data![index].title)));
                      });
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }),
        ),
      ),
    );
  }

  Future<List<Album>> fetchAlbum() async {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/albums'),
        headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => Album.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}
