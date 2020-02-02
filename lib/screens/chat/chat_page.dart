import 'package:flutter/material.dart';
import 'package:kimirina_app/colors/colors.dart';
import 'package:kimirina_app/models/user_model.dart';
import 'package:kimirina_app/routes/routes.dart';
import 'package:kimirina_app/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

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
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
        this.userId = sharedPrefs.getString("userid");
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Ejecuta la función para traer los chats
    Provider.of<ApiService>(context).getChatList(userId);
    //print(Provider.of<ApiService>(context).chatListUsers);
    //Escucha los cambios del chat
    //var tmpUserChatList = Provider.of<ApiService>(context).chatListUsers;
    /*if (tmpUserChatList != null) {
            //print(tmpUserChatList);
          }*/
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
        _ChatItem("Gabriel", " assets/images/profile.jpg", 0, true, ""),
        //Column(children: userAvailables),
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
}

class _ChatItem extends StatelessWidget {
  final String imgURL, name, message;
  final int unread;
  final bool active;

  _ChatItem(this.name, this.imgURL, this.unread, this.active, this.message);

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
        Navigator.of(context).pushNamed(chatDetailViewRoute);
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
                      Navigator.of(context).pushNamed(chatDetailViewRoute);
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
            Column(
              children: <Widget>[
                Text('15 min', style: TextStyle(color: Colors.grey[350])),
                _UnreadIndicator(this.unread),
              ],
            )
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
