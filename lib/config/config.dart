library kimirina.globals;

import 'package:socket_io_client/socket_io_client.dart' as io;

String userid = "";
String urlApiRest = "http://144.91.108.171:4008";
var socket = io.io(urlApiRest, <String, dynamic>{
  'transports': ['websocket'],
  'extraHeaders': {'userId': '$userid'}
});
