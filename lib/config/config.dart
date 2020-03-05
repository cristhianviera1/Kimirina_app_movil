library kimirina.globals;
import 'package:socket_io_client/socket_io_client.dart' as io;
String userid = "";
String urlApiRest = "http://192.168.3.231:4000";
var socket = io.io(urlApiRest, <String, dynamic>{
      'transports': ['websocket'],
      'extraHeaders': {'userId': '$userid'}
    });