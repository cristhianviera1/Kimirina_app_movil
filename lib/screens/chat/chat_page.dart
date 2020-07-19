import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kimirina_app/shared/colors.dart';
import 'package:kimirina_app/config/config.dart';
import 'package:kimirina_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'chat_details_page.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  List<Widget> userAvailables = new List();
  List<User> userChatList = new List();
  bool loading = true;
  bool firstChats = true;
  SharedPreferences sharedPrefs;
  String userId;
  var userAvailablesList;
  @override
  initState() {
    getSharedPreferences();
    socket.on("updateUsers", (data) {
      print(data);
      if (mounted) {
        setState(() {
          userAvailables.removeRange(0, userAvailables.length);
        });
      }
      this.getSharedPreferences();
    });
    socket.on("receive_message", (jsonData) {
      print(jsonData);
      activarNotificaciones(true, jsonData["userIdSend"], jsonData["message"]);
    });
    /**Para la notificación */
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    super.initState();
  }

  Future onSelectNotification(String payload) {
    debugPrint("payload : $payload");
    return null;
  }

  showNotification(user, message) async {
    var android = new AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription',
        priority: Priority.High,
        importance: Importance.Max,
        icon: "",
        color: primaryColor);
    var iOS = new IOSNotificationDetails();
    var plataform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin
        .show(0, '$user', '$message', plataform, payload: '');
  }

  activarNotificaciones(bool estado, user, message) async {
    if (estado == false) {
      await flutterLocalNotificationsPlugin.cancelAll();
    } else {
      var name = "";
      for (var usr in userAvailablesList) {
        if (usr["_id"] == user) {
          name = usr["nombre"];
        }
      }
      showNotification(name, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    //Retorna el widget
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Mensajes',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Column(children: userAvailables),
        Padding(
          padding: EdgeInsets.only(top: 40.0, bottom: 10),
          child: Text(
            'No tienes más mensajes',
            style: TextStyle(color: Colors.grey[350]),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  void getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        var userId = prefs.getString("userid");
        socket.emit("getUserList", (userId));
        socket.on("getChats_response", (data) {
          if (data != null || data != "undefined") {
            if (userAvailables.length == 0) {
              userAvailablesList = data;
              for (var usr in data) {
                var foto;
                if (usr["imagen"] != "") {
                  foto = usr["imagen"];
                } else {
                  foto =
                      'http://144.91.108.171:4008/images/usuarios/836295524.jpg';
                }
                setState(() {
                  userAvailables.add(_ChatItem(
                      usr["nombre"], foto, 0, usr["online"], "", usr["_id"]));
                });
              }
            }
          }
        });
      });
    }
  }
}

class _ChatItem extends StatelessWidget {
  final String imgURL, name, message, id;
  final int unread;
  final bool active;

  _ChatItem(
      this.name, this.imgURL, this.unread, this.active, this.message, this.id);

  Widget _activeIcon(isActive) {
    if (isActive) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(3),
          width: 16,
          height: 16,
          color: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              color: Color(0xff43ce7d), // flat green
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("$id\n$name");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ChatScreen(
                      id: id,
                      nombre: name,
                    )));
      },
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 12.0),
              child: Stack(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      //Navigator.of(context).pushNamed(chatDetailViewRoute);
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(this.imgURL),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: _activeIcon(active),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 6.0, right: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        this.name,
                        style: TextStyle(fontSize: 18),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 4.0),
                        child: Text(this.message,
                            style: TextStyle(
                                color: Colors.grey, fontSize: 15, height: 1.1),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class _UnreadIndicator extends StatelessWidget {
  final int unread;

  _UnreadIndicator(this.unread);

  @override
  Widget build(BuildContext context) {
    if (unread == 0) {
      return Container(); // return empty container
    } else {
      return Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 30,
                color: azul,
                width: 30,
                padding: EdgeInsets.all(0),
                alignment: Alignment.center,
                child: Text(
                  unread.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              )));
    }
  }
}
