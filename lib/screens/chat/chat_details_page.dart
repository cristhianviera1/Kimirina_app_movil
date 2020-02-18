import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kimirina_app/colors/colors.dart';
import 'package:kimirina_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatScreen extends StatefulWidget {
  final String id;
  final String nombre;
  ChatScreen({Key key, @required this.id, this.nombre}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<dynamic> messages;
  double height, width;
  TextEditingController textController;
  ScrollController scrollController;
  String userId;
  var socket;

  @override
  void initState() {
    getSharedPreferences();
    //Initializing the message list
    messages = List();
    //Initializing the TextEditingController and ScrollController
    textController = TextEditingController();
    scrollController = ScrollController();
    //Get history of chats
    ApiService().getChat(widget.id).then((response) {
      this.setState(() {
        for (var msg in response) {
          messages.add(msg);
        }
        print("Número de chats:\n${messages.length}");
      });
    });
    //Creating the socket

    super.initState();
  }

  Widget buildSingleMessage(int index) {
    var aligment;
    var color;
    if (messages[index]["userIdSend"] == this.userId) {
      aligment = Alignment.topRight;
      color = Colors.purple;
    } else {
      aligment = Alignment.centerLeft;
      color = Colors.deepPurple;
    }
    /*
    if (index % 2 == 0) {
      aligment = Alignment.centerLeft;
      color = Colors.deepPurple;
    } else if (index % 2 == 1) {
      aligment = Alignment.topRight;
      color = Colors.purple;
    }*/
    return Container(
      alignment: aligment,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          messages[index]["message"],
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
      ),
    );
  }

  Widget buildMessageList() {
    return Container(
      height: height * 0.78,
      width: width,
      child: ListView.builder(
        controller: scrollController,
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          return buildSingleMessage(index);
        },
      ),
    );
  }

  Widget buildChatInput() {
    return Container(
      width: width * 0.7,
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.only(left: 40.0),
      child: TextField(
        decoration: InputDecoration.collapsed(
          hintText: 'Send a message...',
        ),
        controller: textController,
      ),
    );
  }

  Widget buildSendButton() {
    return FloatingActionButton(
      backgroundColor: morado,
      onPressed: () {
        //Check if the textfield has text or not
        if (textController.text.isNotEmpty) {
          /*socket.emit(
              "send_message",
              json.encode({
                "message": textController.text,
                "userIdSend": this.userId,
                "userIdReceive": widget.id
              }));*/
          socket.emit(
              'send_message',
              json.encode({
                "message": textController.text,
                "userIdReceive": widget.id,
                "userIdSend": this.userId
              }));
          this.setState(() => messages.add({
                "message": textController.text,
                "userIdSend": this.userId,
                "userIdReceive": widget.id
              }));
          textController.text = '';
          //Scrolldown the list to show the latest message
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 600),
            curve: Curves.ease,
          );
        }
      },
      child: Icon(
        Icons.send,
        size: 30,
      ),
    );
  }

  Widget buildInputArea() {
    return Container(
      height: height * 0.1,
      width: width,
      child: Row(
        children: <Widget>[
          buildChatInput(),
          buildSendButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nombre) ?? "Usuario",
        backgroundColor: morado,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //SizedBox(height: height * 0.1),
            buildMessageList(),
            buildInputArea(),
          ],
        ),
      ),
    );
  }

  void getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.userId = prefs.getString("userid");
      socket = io.io("http://192.168.0.103:4000");
      socket.emit("loginRoom", (this.userId));
      socket.on("receive_message", (jsonData) {
        print("------\n${jsonData['message']}\n-------\n");
        if (jsonData['userIdReceive'] == this.userId) {
          setState(() => messages.add({
                "message": jsonData['message'],
                "userIdSend": jsonData['userIdSend'],
                "userIdReceive": jsonData['userIdReceive']
              }));
        }
      });
    });
  }
  @override
  void dispose() {
    Navigator.pop(context);
    super.dispose();
  }
}
