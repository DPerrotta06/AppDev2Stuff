import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      openDatabase(join(await getDatabasesPath(), 'doggie_database.db'),
          onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');
  }, version: 1);

  Future<void> insertDogs(Dog dog) async {
    final db = await database;
    await db.insert('dogs', dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  var fido = Dog(id: 0, name: 'Fido', age: 35);
  await insertDogs(fido);
  Future<List<Dog>> dogs() async {
    final db = await database;
    final List<Map<String, Object?>> dogMaps = await db.query('dogs');
    return [
      for (final {'id': id as int, 'name': name as String, 'age': age as int}
          in dogMaps)
        Dog(id: id, name: name, age: age)
    ];
  }

  print(await dogs());

  Future<void> updateDog(Dog dog) async {
    final db = await database;
    await db.update('dogs', dog.toMap(), where: 'id = ?', whereArgs: [dog.id]);
  }

  fido = Dog(id: fido.id, name: fido.name, age: fido.age + 7);
  await updateDog(fido);
  print(await dogs());

  Future<void> deleteDog(int id) async {
    final db = await database;
    await db.delete('dogs', where: 'id = ?', whereArgs: [id]);
  }

  await deleteDog(fido.id);
  print(await dogs());
}
