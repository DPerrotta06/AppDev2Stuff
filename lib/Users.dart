import 'Address.dart';
import 'Company.dart';
import 'dart:convert';

List<Users> userModelFromJson(String str) =>
    List<Users>.from(json.decode(str).map((data) => Users.fromJson(data)));

class Users {
  final int id;
  final String name;
  final String username;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  Users(
      {required this.id,
      required this.name,
      required this.username,
      required this.address,
      required this.phone,
      required this.website,
      required this.company});

  factory Users.fromJson(Map<String, dynamic> json) => Users(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      address: json["address"],
      phone: json["phone"],
      website: json["website"],
      company: json["company"]);
}
