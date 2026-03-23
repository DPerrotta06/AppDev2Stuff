import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: RoomDb());
  }
}

class RoomDb extends StatefulWidget {
  const RoomDb({super.key});

  @override
  State<RoomDb> createState() => _RoomDbState();
}

class _RoomDbState extends State<RoomDb> {
  String? name;
  bool editing = false;
  late Database database;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController ssnController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  List<Map<String, dynamic>> userList = [];

  @override
  void initState() {
    super.initState();
    initDb();
  }

  Future<void> initDb() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'user.db'),
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE users(
        name TEXT PRIMARY KEY,
        contactPhone INTEGER,
        ssn INTEGER,
        address TEXT
        )''');
      },
      version: 1,
    );
    readAllUsers();
  }

  Future<void> addUser() async {
    await database.insert('users', {
      'name': nameController.text,
      'contactPhone': int.parse(contactController.text),
      'ssn': int.parse(ssnController.text),
      'address': addressController.text,
    });
    clearUserFields();
    readAllUsers();
  }

  Future<void> readAllUsers() async {
    final List<Map<String, dynamic>> result = await database.rawQuery(
      '''SELECT * FROM users''',
    );
    setState(() {
      userList = result;
    });
  }

  Future<void> deleteUser(String name) async {
    await database.delete('users', where: 'name = ?', whereArgs: [name]);
    readAllUsers();
  }

  Future<void> updateUser() async {
    if (name == null) {
      return;
    }
    await database.update(
      'users',
      {
        'name': nameController.text,
        'contactPhone': int.parse(contactController.text),
        'ssn': int.parse(ssnController.text),
        'address': addressController.text,
      },
      where: 'name = ?',
      whereArgs: [name],
    );
    name = null;
    editing = false;
    clearUserFields();
    readAllUsers();
  }

  void clearUserFields() {
    nameController.clear();
    contactController.clear();
    ssnController.clear();
    addressController.clear();
  }

  bool _isFilledOut() {
    return nameController.text.isNotEmpty &&
        contactController.text.isNotEmpty &&
        ssnController.text.isNotEmpty &&
        addressController.text.isNotEmpty;
  }

  Widget _buildUserList() {
    return Expanded(
      child: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];
          return Card(
            margin: EdgeInsets.all(15),
            child: ListTile(
              leading: CircleAvatar(child: Image.asset('assets/pfp.jpg')),
              title: Text(user['name']),
              subtitle: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, height: 1.5),
                  children: [
                    TextSpan(text: "${user['contactPhone']}\n"),
                    TextSpan(text: "${user['ssn']}\n"),
                    TextSpan(text: user['address']),
                  ],
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      deleteUser(user['name']);
                    },
                    icon: Icon(Icons.delete_outline, color: Colors.red),
                    color: Colors.black,
                  ),
                  InkWell(
                    onTap: () {
                      editing = true;
                      name = user['name'];
                      nameController.text = user['name'];
                      contactController.text = user['contactPhone'].toString();
                      ssnController.text = user['ssn'].toString();
                      addressController.text = user['address'];
                      setState(() {});
                    },
                    child: Image.asset('assets/edit.jpg'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
        title: Text(
          'ROOM DATABASE',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      fillColor: Colors.grey,
                    ),
                  ),
                  TextField(
                    controller: contactController,
                    decoration: InputDecoration(
                      hintText: 'Contact Phone',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      fillColor: Colors.grey,
                    ),
                  ),
                  TextField(
                    controller: ssnController,
                    decoration: InputDecoration(
                      hintText: 'SSN',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      fillColor: Colors.grey,
                    ),
                  ),
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      fillColor: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (editing) {
                        updateUser();
                      } else {
                        if (!_isFilledOut()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                textAlign: TextAlign.center,
                                'Please fill out all the fields before proceeding!',
                              ),
                            ),
                          );
                        } else {
                          addUser();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lime,
                      minimumSize: Size(200, 50),
                    ),
                    child: Text(
                      editing ? 'UPDATE USER' : 'INSERT USER',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildUserList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
