import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  // Entry point of the app → loads the main screen
  runApp(const MaterialApp(home: DogOwnerScreen()));
}

// Stateful because UI updates when DB changes
class DogOwnerScreen extends StatefulWidget {
  const DogOwnerScreen({super.key});

  @override
  _DogOwnerScreenState createState() => _DogOwnerScreenState();
}

class _DogOwnerScreenState extends State<DogOwnerScreen> {
  late Database database; // SQLite database instance

  // ---------------- TEXT CONTROLLERS ----------------
  // Used to capture user input from TextFields
  final ownerIdController = TextEditingController();
  final ownerNameController = TextEditingController();
  final dogIdController = TextEditingController();
  final dogNameController = TextEditingController();
  final dogAgeController = TextEditingController();
  final dogOwnerIdController = TextEditingController();

  // Lists to store query results
  List<Map<String, dynamic>> dogList = []; // stores dogs + owner info (JOIN)
  List<Map<String, dynamic>> ownerList = []; // used for owner filtering

  @override
  void initState() {
    super.initState();
    initDB(); // initialize database when app starts
  }

  // ---------------- DATABASE INITIALIZATION ----------------
  Future<void> initDB() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'dog_owner.db'), // DB file path
      onCreate: (db, version) async {
        // Create OWNERS table
        await db.execute('''
          CREATE TABLE owners(
            id INTEGER PRIMARY KEY,
            name TEXT
          )
        ''');

        // Create DOGS table with foreign key
        await db.execute('''
          CREATE TABLE dogs(
            id INTEGER PRIMARY KEY,
            name TEXT,
            age INTEGER,
            ownerId INTEGER,
            FOREIGN KEY(ownerId) REFERENCES owners(id)
          )
        ''');
      },
      version: 1,
    );
    readDogs(); // load data after DB is ready
  }

  // ================= OWNER CRUD =================

  // CREATE owner
  Future<void> insertOwner() async {
    await database.insert('owners', {
      'id': int.parse(ownerIdController.text),
      'name': ownerNameController.text,
    });
    // Clear input fields after insert
    ownerIdController.clear();
    ownerNameController.clear();
  }

  // DELETE owner by ID
  Future<void> deleteOwner() async {
    await database.delete(
      'owners',
      where: 'id = ?', // prevents SQL injection
      whereArgs: [int.parse(ownerIdController.text)],
    );
    ownerIdController.clear();
  }

  // ================= DOG CRUD =================

  // CREATE dog
  Future<void> insertDog() async {
    await database.insert('dogs', {
      'id': int.parse(dogIdController.text),
      'name': dogNameController.text,
      'age': int.parse(dogAgeController.text),
      'ownerId': int.parse(dogOwnerIdController.text), // FK reference
    });

    clearDogFields();
    readDogs(); // refresh UI
  }

  // UPDATE dog by ID
  Future<void> updateDog() async {
    await database.update(
      'dogs',
      {
        'name': dogNameController.text,
        'age': int.parse(dogAgeController.text),
        'ownerId': int.parse(dogOwnerIdController.text),
      },
      where: 'id = ?',
      whereArgs: [int.parse(dogIdController.text)],
    );
    clearDogFields();
    readDogs();
  }

  // DELETE dog
  Future<void> deleteDog() async {
    await database.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [int.parse(dogIdController.text)],
    );
    clearDogFields();
    readDogs();
  }

  // READ dogs with JOIN (dogs + owners)
  Future<void> readDogs() async {
    final List<Map<String, dynamic>> result = await database.rawQuery('''
    SELECT
      dogs.id AS dogId,
      dogs.name,
      dogs.age,
      owners.id AS ownerId,
      owners.name AS ownerName
    FROM dogs
    LEFT JOIN owners
    ON dogs.ownerId = owners.id
  ''');
    // Update UI with results
    setState(() {
      dogList = result;
    });
  }

  // ================= FILTER OPERATIONS =================

  // Filter dogs by OWNER ID
  Future<void> filterByOwner() async {
    final result = await database.rawQuery('''
    SELECT
      dogs.id AS dogId,
      dogs.name,
      dogs.age,
      owners.id AS ownerId,
      owners.name AS ownerName
    FROM dogs
    LEFT JOIN owners
    ON dogs.ownerId = owners.id
    WHERE owners.id = ?
  ''', [int.parse(dogOwnerIdController.text)]);
    setState(() {
      dogList = result;
    });
  }

  // Filter dogs where age > input
  Future<void> filterByAge() async {
    final result = await database.query(
      'dogs',
      where: 'age > ?',
      whereArgs: [int.parse(dogAgeController.text)],
    );
    setState(() {
      dogList = result;
    });
  }

  // Filter owners and show their dogs (reverse relation)
  Future<void> filterByDog() async {
    final result = await database.rawQuery('''
    SELECT
      owners.id AS ownerId,
      owners.name,
      dogs.id AS dogId,
      dogs.name AS dogName,
      dogs.age AS dogAge
    FROM owners
    LEFT JOIN dogs
    ON dogs.ownerId = owners.id
    WHERE owners.id = ? 
    ''', [int.parse(ownerIdController.text)]);

    setState(() {
      ownerList = result; // NOTE: not displayed in UI currently
    });
  }

  // Clear dog input fields
  void clearDogFields() {
    dogIdController.clear();
    dogNameController.clear();
    dogAgeController.clear();
    dogOwnerIdController.clear();
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dog & Owner CRUD")),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            // -------- OWNER SECTION --------
            const Text("Owner Section",
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
                controller: ownerIdController,
                decoration: const InputDecoration(labelText: "Owner ID")),
            TextField(
                controller: ownerNameController,
                decoration: const InputDecoration(labelText: "Owner Name")),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: insertOwner, child: const Text("Add Owner")),
                ElevatedButton(
                    onPressed: deleteOwner, child: const Text("Delete Owner")),
              ],
            ),

            const Divider(),

            // -------- DOG SECTION --------
            const Text("Dog Section", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
                controller: dogIdController,
                decoration: const InputDecoration(labelText: "Dog ID")),
            TextField(
                controller: dogNameController,
                decoration: const InputDecoration(labelText: "Dog Name")),
            TextField(
                controller: dogAgeController,
                decoration: const InputDecoration(labelText: "Dog Age")),
            TextField(
                controller: dogOwnerIdController,
                decoration: const InputDecoration(labelText: "Owner ID (FK)")),

            // Buttons for CRUD + filtering
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(onPressed: insertDog, child: const Text("Create")),
                ElevatedButton(onPressed: readDogs, child: const Text("Read")),
                ElevatedButton(onPressed: updateDog, child: const Text("Update")),
                ElevatedButton(onPressed: deleteDog, child: const Text("Delete")),
                ElevatedButton(
                    onPressed: filterByOwner, child: const Text("Filter Owner")),
                ElevatedButton(onPressed: filterByAge, child: const Text("Age >")),
                ElevatedButton(
                    onPressed: filterByDog, child: const Text('Filter Dog'))
              ],
            ),

            const SizedBox(height: 10),

            // -------- DISPLAY RESULTS --------
            Expanded(
              child: ListView(
                children: dogList.map((dog) {
                  return ListTile(
                    title: Text("Dog ID: ${dog['dogId']} - ${dog['name']}"),
                    subtitle: Text(
                        "Dog Age: ${dog['age']} | Owner ID: ${dog['ownerId']} | Owner Name: ${dog['ownerName']}"),
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
