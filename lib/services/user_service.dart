import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:dio/dio.dart';
import 'package:kimirina_app/models/user_model.dart';
import 'package:kimirina_app/models/formulario_model.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ApiService with ChangeNotifier {
  final String baseUrl = "http://192.168.100.220:4000";
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

  //guardar formulario
  Future storeForm(Formulario formReg) async {
    final response = await http.post("$baseUrl/formulario",
        headers: {"content-type": "application/json"},
        body: anyToJson(formReg));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  checkConnect() async {
    try {
      print(await http.read(baseUrl));
    } catch (err) {
      return "unaccesible";
    }
  }

  //LoginUser
  Future loginUser(User userReg) async {
    try {
      final response = await http.post("$baseUrl/usuario/login",
          headers: {"content-type": "application/json"},
          body: anyToJson(userReg));
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (err) {
      return "inaccesible";
    }
  }

  userSessionCheck(userId) async {
    this.checkConnect();
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
  Future<bool> updateUser(User user) async {
    final response = await http.post("$baseUrl/usuario/${user.id}",
        headers: {"content-type": "application/json"}, body: user.imagen);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  uploadImage(User user) async {
    print(user.id);
    String fileName = basename(user.imagen.path);
    print("File base name: $fileName");
    try {
      FormData formData = new FormData.from({"image": new UploadFileInfo(user.imagen, fileName)});
      var response = await Dio().put("$baseUrl/usuario/imagen/${user.id}", data: formData);
      print("File upload response: $response");
      return response.data;
    } catch (e) {
      print("Exception Caught: $e");
      return;
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
        body: jsonEncode({"id": id, "idReceive": idReceive}));
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

  Future getNovedades() async {
    final response = await http.get("$baseUrl/novedades");
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

    Future getProductos() async {
    final response = await http.get("$baseUrl/productos");
    if (response.statusCode == 200) {
      return json.decode(response.body);
      
    } else {
      return json.decode(response.body);
    }
  }

  Future logout(userId) {
    this.socket.emit('logout', {"userId": userId});
    this.socket.on('logout-response', (data) {
      print(data);
    });
  }
}
