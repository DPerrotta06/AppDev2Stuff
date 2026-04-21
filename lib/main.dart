import 'package:flutter/material.dart';
import 'Users.dart';
import 'Constants.dart';
import 'ApiServices.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Users>> futureUser;

  // Proper async function that RETURNS data
  Future<List<Users>?> _getData() async {
    return await Apiservices().getUsers();
  }

  @override
  void initState() {
    super.initState();
    futureUser = _getData(); // assign future here HAS ERROR
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      home: Scaffold(
        appBar: AppBar(title: const Text('Fetch Data Example')),

        body: Center(
          child: FutureBuilder<List<Users>>(
            future: futureUser,

            builder: (context, snapshot) {

              // ✅ Data loaded
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,

                  itemBuilder: (context, index) {
                    final user = snapshot.data![index];

                    return Card(
                      margin: const EdgeInsets.all(16),

                      child: ListTile(
                        leading: Text('User ID: ${user.userId}'), //HAS ERROR
                        title: Text('ID: ${user.id}'),
                        subtitle: Text(user.title), //HAS ERROR
                      ),
                    );
                  },
                );
              }

              //Error handling
              else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              //Loading state
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}