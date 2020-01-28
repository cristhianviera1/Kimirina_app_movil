import 'dart:convert';
import 'package:kimirina_app/models/chat-list-response_model.dart';
import 'package:kimirina_app/models/register_model.dart';
import 'package:http/http.dart' as http;
import 'package:kimirina_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ApiService {
  final String baseUrl = "http://192.168.100.220:4000";
  static var socket;

  static final ApiService _apiService = new ApiService._internal();

  factory ApiService(){
    return _apiService;
  }
  ApiService._internal(){
  }
  //headers
  final Map<String, String> headers = {"Content-type": "application/json"};
  String anyToJson(data) {
    final jsonData = data.toJson();
    return json.encode(jsonData);
  }

  //RegisterUser
  Future registerUser(RegisterForm userReg) async {
    final response = await http.post("$baseUrl/register",
        headers: {"content-type": "application/json"},
        body: anyToJson(userReg));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  //LoginUser
  Future loginUser(RegisterForm userReg) async {
    final response = await http.post("$baseUrl/login",
        headers: {"content-type": "application/json"},
        body: anyToJson(userReg));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  Future<bool> userSessionCheck(userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString("userid") ?? "";
    final response = await http.post("$baseUrl/userSessionCheck",
        headers: {"content-type": "application/json"},
        body: jsonEncode({"userId": userId}));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> connectSocket(String userId) async {
    socket = io.io(baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'extraHeaders': {'userId': '$userId'}
    }); 
    socket.emit("connection",{"msg":"Se ha conectado el usuario"+userId});
  }

  Future getChatList(userId) async {   
    socket.emit('chat-list', {"userId": userId});
    ChatListResponse chats;
    socket.on('chat-list-response', (response) {
      List<User> users = new List();
      response["chatList"].map((user) {
        if (user["id"] != userId) {
          users.add(new User(
              nombre: user["nombre"], id: user["id"], online: user["nombre"]));
        }
      }).toList();
      var res = new ChatListResponse(
          chatList: users,
          error: response["error"],
          singleUser: response["singleuser"],
          userDisconnected: response["userDisconnected"],
          userid: response["userid"]);
      chats = res;
    });
    await Future.delayed(Duration(milliseconds: 300));
    return chats;
  }
}
