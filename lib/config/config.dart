library kimirina.globals;

import 'package:kimirina_app/models/user_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

String userid = "";
User userApp = new User(id: "",genero: "",nombre: "",imagen: "http://62.171.128.13:4008/images/usuarios/836295524.jpg",edad: "");
String urlApiRest = "http://62.171.128.13:4008";
var socket = io.io(urlApiRest, <String, dynamic>{
  'transports': ['websocket'],
  'extraHeaders': {'userId': '$userid'}
});
