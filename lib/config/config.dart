library kimirina.globals;

import 'package:kimirina_app/models/user_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

String userid = "";
String imageOfUser = "";
String edad = "";
User userApp = new User(id: "",genero: "",nombre: "");
String urlApiRest = "http://192.168.0.100:4000";
var socket = io.io(urlApiRest, <String, dynamic>{
  'transports': ['websocket'],
  'extraHeaders': {'userId': '$userid'}
});
