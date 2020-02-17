import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kimirina_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ApiService with ChangeNotifier {
  final String baseUrl = "http://192.168.0.103:4000";
  List<User> _chatListUsers = new List();
  List<User> get chatListUsers => _chatListUsers;
  void set chatListUsers(newValue) {
    _chatListUsers = newValue;
  }

  var socket;

  static final ApiService _apiService = new ApiService._internal();

  factory ApiService() {
    return _apiService;
  }
  ApiService._internal() {}
  //headers
  final Map<String, String> headers = {"Content-type": "application/json"};
  String anyToJson(data) {
    final jsonData = data.toJson();
    return json.encode(jsonData);
  }

  //RegisterUser
  Future registerUser(User userReg) async {
    final response = await http.post("$baseUrl/usuario",
        headers: {"content-type": "application/json"},
        body: anyToJson(userReg));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  //LoginUser
  Future loginUser(User userReg) async {
    final response = await http.post("$baseUrl/usuario/login",
        headers: {"content-type": "application/json"},
        body: anyToJson(userReg));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  Future<bool> userSessionCheck(userId) async {
    final response = await http.post("$baseUrl/userSessionCheck",
        headers: {"content-type": "application/json"},
        body: jsonEncode({"userId": userId}));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //updUser
  Future<bool> updateUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("userid") ?? "";
    final response = await http.post("$baseUrl/usuario/$id",
        headers: {"content-type": "application/json"}, body: jsonEncode(user));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //updatePassword
  Future<bool> updatePassword(String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("userid") ?? "";
    final response = await http.post("$baseUrl/usuario/updPassword",
        headers: {"content-type": "application/json"},
        body: jsonEncode({"id": id, "password": pass}));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future getChats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("userid") ?? "";
    final response = await http.post("$baseUrl/usuario/chats",
        headers: {"content-type": "application/json"},
        body: jsonEncode({"id": id}));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  Future getChat(String idReceive) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("userid");
    final response = await http.post("$baseUrl/usuario/chat",
        headers: {"content-type": "application/json"},
        body: jsonEncode({"id": id,"idReceive":idReceive}));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  //SOCKET.IO
  Future<void> connectSocket(String userId) async {
    socket = io.io(baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'extraHeaders': {'userId': '$userId'}
    });
    socket.emit("connection", {"msg": "Se ha conectado el usuario: " + userId});
  }

  Stream getChatList(userId) async* {
    if (userId != null) {
      this.socket.emit('chat-list', {"userId": userId});
    }
    yield socket.on('chat-list-response', (response) {
      response.stream();
      return response;
    });
  }

  Future logout(userId) {
    this.socket.emit('logout', {"userId": userId});
    this.socket.on('logout-response', (data) {
      print(data);
    });
  }
}
