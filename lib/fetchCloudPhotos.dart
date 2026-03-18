import 'Photos.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Photos>> futurePhotos;

  @override
  void initState() {
    super.initState();
    futurePhotos = fetchPhotos();
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
          child: FutureBuilder<List<Photos>>(
              //used for asynchronous data sources like cloud json data
              future: futurePhotos,
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
                              isThreeLine: true,
                              leading: CircleAvatar(
                                child: Image.network(
                                    snapshot.data![index].thumbnailUrl),
                              ),
                              title: Text(
                                  'Album ID: ${snapshot.data![index].albumId}'),
                              subtitle: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text:
                                          'ID: ${snapshot.data![index].id}\n'),
                                  TextSpan(text: snapshot.data![index].title)
                                ]),
                              ),
                              trailing:
                                  Image.network(snapshot.data![index].url),
                            ));
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

  Future<List<Photos>> fetchPhotos() async {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/photos'),
        headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => Photos.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
