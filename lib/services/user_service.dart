import 'dart:convert';
import 'package:kimirina_app/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = "http://192.168.100.220:3000";
  User currentUser = new User();
  //headers
  final Map<String, String> headers = {"Content-type": "application/json"};
  String profileToJson(User data) {
    final jsonData = data.toJson();
    return json.encode(jsonData);
  }

  //RegisterUser
  Future<bool> registerUser(User user) async {
    final response = await http.post("$baseUrl/api/auth/register",
        headers: {"content-type": "application/json"},
        body: profileToJson(user));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //LoginUser
  Future<bool> loginUser(User user) async {
    print("$baseUrl");
    final response = await http.post("$baseUrl/api/auth/login",
        headers: {"content-type": "application/json"},
        body: profileToJson(user));
    if (response.statusCode == 200) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("token", jsonDecode(response.body)["token"]);
      verifyToken(pref.get("token"));
      return true;
    } else {
      return false;
    }
  }
  Future <User> verifyToken(token) async {
    final response = await http
        .get("$baseUrl/api/auth/me", headers: {"x-access-token": token});
    if (response.statusCode == 200) {
      User tmpUser = new User(
        email: jsonDecode(response.body)["email"],
        nombre: jsonDecode(response.body)["nombre"],
      );
      currentUser = tmpUser;
      return tmpUser;
    }
  }
}
