import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kimirina_app/config/config.dart';
import 'package:kimirina_app/models/form_model.dart';
import 'package:kimirina_app/models/user_model.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ApiService with ChangeNotifier {
  final String baseUrl = urlApiRest;
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
    try {
      final response = await http.post("$baseUrl/user",
          headers: {"content-type": "application/json"},
          body: anyToJson(userReg));
      return response.body;
    } catch (err) {
      return err;
    }
  }

  //guardar formulario
  Future storeForm(FormQuestion formReg) async {
    final response = await http.post("$baseUrl/form",
        headers: {"content-type": "application/json"},
        body: anyToJson(formReg));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  //LoginUser
  Future loginUser(User userReg) async {
    try {
      final response = await http.post("$baseUrl/user/login",
          headers: {"content-type": "application/json"},
          body: anyToJson(userReg));
      return response.body;
    } catch (err) {
      return "inaccesible";
    }
  }

  userSessionCheck(userId) async {
    try {
      final response = await http.post("$baseUrl/userSessionCheck",
          headers: {"content-type": "application/json"},
          body: jsonEncode({"userId": userId}));
      if (response.statusCode == 200) {
        return true;
      }
    } catch (err) {
      return "inaccesible";
    }
  }

  //updUser
  updateUser(object) async {
    final response = await http.put("$baseUrl/user/$userid",
        headers: {"content-type": "application/json"},
        body: jsonEncode(object));
    return response.body;
  }

  uploadImage(PickedFile photo) async {
    String fileName = basename(photo.path);
    try {
      FormData formData = new FormData.fromMap({
        "image": await MultipartFile.fromFile(photo.path, filename: fileName)
      });
      var response =
          await Dio().put("$baseUrl/user/image/$userid", data: formData);
      return response.data;
    } catch (e) {
      return;
    }
  }

  //updatePassword
  Future<bool> updatePassword(String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("userid") ?? "";
    final response = await http.post("$baseUrl/user/updatePassword",
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
    final response = await http.post("$baseUrl/user/chats",
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
    final response = await http.post("$baseUrl/user/chat",
        headers: {"content-type": "application/json"},
        body: jsonEncode({"id": id, "idReceive": idReceive}));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  //SOCKET.IO
  Future<void> connectSocket(String userId) async {
    socket = io.io(urlApiRest);
    socket.emit("loginRoom", (userId));
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

  Future getNews() async {
    final response = await http.get("$baseUrl/news");
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  Future getProducts() async {
    final response = await http.get("$baseUrl/products");
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  Future logout(userId) {
    this.socket.emit('logout', {"userId": userId});
    this.socket.on('logout-response', (data) {});
  }
}
