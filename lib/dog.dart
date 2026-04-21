class Dog {
  final int id;
  final String name;
  final int age;

  Dog(
      {required this.id,
      required this.name,
      required this.age}); //mandatory constructor to turn into db object

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }

  @override
  String toString() {
    return 'Dog:\nId: $id\nName: $name\nAge: $age';
  }
}
