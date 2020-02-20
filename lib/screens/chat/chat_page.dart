import 'package:flutter/material.dart';
import 'package:kimirina_app/colors/colors.dart';
import 'package:kimirina_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'chat_details_page.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  List<Widget> userAvailables = new List();
  List<User> userChatList = new List();
  bool loading = true;
  bool firstChats = true;
  SharedPreferences sharedPrefs;
  String userId;

  var socket;
  @override
  initState() {
    super.initState();
    getSharedPreferences();
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

  getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userid");
    socket = io.io("http://192.168.100.174:4000");
    socket.emit("getUserList", (userId));
    socket.on("getChats_response", (data) {
      print(data);
      if (data != null || data != "undefined") {
        if (userAvailables.length == 0) {
          setState(() {
            for (var usr in data) {
              userAvailables.add(_ChatItem(usr["nombre"], "assets/login.png", 0,
                  usr["online"], "", usr["_id"]));
            }
          });
        }
      }
    });
    socket.on("updateOfUser",(data){
      print(data);
    });
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
                      backgroundImage: AssetImage(this.imgURL),
                      radius: 30.0,
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
