import 'package:flutter/material.dart';
import 'package:kimirina_app/colors/colors.dart';
import 'package:kimirina_app/models/chat-list-response_model.dart';
import 'package:kimirina_app/models/user_model.dart';
import 'package:kimirina_app/routes/routes.dart';
import 'package:kimirina_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  ApiService _apiService = ApiService();
  List<ChatList> redenderChatList;
  String selectedUserId = null;
  List<User> chatListUsers = [];
  List<Widget> userAvailables = new List();

  bool loading = true;

  @override
  initState() {
    getChatList();
    super.initState();
  }

  Future getChatList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = preferences.getString("userid");
    _apiService.getChatList(userId).then((response) {
      renderChatList(response);
      setState(() {
        _userAvailable();
      });
      return response;
    });
  }

  void renderChatList(ChatListResponse chatListResponse) {
    if (chatListResponse.error == false) {
      this.chatListUsers = chatListResponse.chatList;
    }
    print(this.chatListUsers);
  }

  void _userAvailable() {
    chatListUsers
        .map((user) => userAvailables.add(new _ChatItem(
            user.nombre,
            'assets/images/login.png',
            1,
            true,
            'No tienes por que tener miedo, nosotros te podemos ayudar, pero el primer paso es que te hagas la prueba, no toma nada de tiempo y es 100% confiable')))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
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
        Column(
          children: userAvailables,
        ),
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

  Future<String> _getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("userid");
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
