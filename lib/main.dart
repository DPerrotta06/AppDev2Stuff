import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: DogTable());
  }
}

class DogTable extends StatefulWidget {
  const DogTable({super.key});

  @override
  State<DogTable> createState() => _DogTableState();
}

class _DogTableState extends State<DogTable> {
  late Database database;

  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  List<Dog> dogList = [];

  @override
  void initState() {
    super.initState();
    initDb();
  }

  Future<void> initDb() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'dogs_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dog(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );

    readDogs(); // load existing data
  }

  Future<void> addDog() async {
    final dog = Dog(
      id: int.parse(idController.text),
      name: nameController.text,
      age: int.parse(ageController.text),
    );

    await database.insert(
      'dog',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    clearFields();
    readDogs();
  }

  Future<void> readDogs() async {
    final List<Map<String, Object?>> maps = await database.query('dog');

    setState(() {
      dogList = maps.map((map) {
        return Dog(
          id: map['id'] as int,
          name: map['name'] as String,
          age: map['age'] as int,
        );
      }).toList();
    });
  }

  Future<void> deleteDogs() async {
    await database.delete(
      'dog',
      where: 'id=?',
      whereArgs: [int.parse(idController.text)],
    );

    clearFields();
    readDogs();
  }

  Future<void> updateDogs() async {
    final dog = Dog(
      id: int.parse(idController.text),
      name: nameController.text,
      age: int.parse(ageController.text),
    );

    await database.update(
      'dog',
      dog.toMap(),
      where: 'id=?',
      whereArgs: [dog.id],
    );

    clearFields();
    readDogs();
  }

  void clearFields() {
    idController.clear();
    nameController.clear();
    ageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dog Database")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: 'Enter id'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Enter name'),
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Enter age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => addDog(), child: const Text('Add')),
                ElevatedButton(
                    onPressed: () => readDogs(), child: const Text('Show')),
                ElevatedButton(
                    onPressed: () => updateDogs(), child: const Text('Update')),
                ElevatedButton(
                    onPressed: () => deleteDogs(), child: const Text('Delete')),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: dogList.map((dog) {
                  return ListTile(
                    title: Text(dog.name),
                    subtitle: Text("Age: ${dog.age} | ID: ${dog.id}"),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
