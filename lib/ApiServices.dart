import 'dart:math';
import 'package:http/http.dart' as http;
import 'Users.dart';
import 'Constants.dart';

class Apiservices {
  Future<List<Users>?> getUsers() async {
    try {
      var uri = Uri.parse(Constants.baseUrl + Constants.userEndPoint);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        List<Users> _model = userModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      e.toString();
    }
    return null;
  }
}
