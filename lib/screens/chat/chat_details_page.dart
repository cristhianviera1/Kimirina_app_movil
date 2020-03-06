import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kimirina_app/colors/colors.dart';
import 'package:kimirina_app/config/config.dart';
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
      });
    });
    super.initState();
  }

  void _pickImage() async {
    final imageSource = ImageSource.gallery;
    if (imageSource != null) {
      File file = await ImagePicker.pickImage(source: imageSource);
      if (file != null) {
        setState(() {
          List<int> imageBytes = file.readAsBytesSync();
          String base64Image = base64Encode(imageBytes);
          messages.add({
            "message": base64Image,
            "imagen": true,
            "userIdSend": this.userId,
            "userIdReceive": widget.id
          });
          socket.emit(
              'send_message',
              json.encode({
                "imagen": true,
                "message": base64Image,
                "userIdReceive": widget.id,
                "userIdSend": this.userId
              }));
        });
      }
    }
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
          children: <Widget>[buildMessageList(), buildInputArea()],
        ),
      ),
    );
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
    if (messages[index]["imagen"] == true) {
      Uint8List bytes = base64.decode(messages[index]["message"]);
      return Container(
        alignment: aligment,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Image.memory(bytes),
        ),
      );
    } else {
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
  }

  Widget buildMessageList() {
    return Container(
      height: height * 0.77,
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

  void getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userId = prefs.getString("userid");
    //socket = io.io(urlApiRest);
    //socket.emit("loginRoom", (this.userId));
    socket.on("receive_message", (jsonData) {
      print(jsonData);
      messages.add({
        "imagen": jsonData['imagen'],
        "message": jsonData['message'],
        "userIdSend": jsonData['userIdSend'],
        "userIdReceive": jsonData['userIdReceive']
      });
      setState(() {});
      scrollController.animateTo(
          scrollController.position.maxScrollExtent * 1.2,
          duration: Duration(milliseconds: 600),
          curve: Curves.ease,
        );
    });
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  buildInputArea() {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5),
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.photo_camera),
                    onPressed: () {
                      _pickImage();
                    },
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Escribe algo...",
                          border: InputBorder.none),
                      controller: textController,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 15),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(color: morado, shape: BoxShape.circle),
              child: InkWell(
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () {
              if (textController.text.isNotEmpty) {
                socket.emit(
                    'send_message',
                    json.encode({
                      "message": textController.text,
                      "imagen": false,
                      "userIdReceive": widget.id,
                      "userIdSend": this.userId
                    }));
                this.setState(() => messages.add({
                      "message": textController.text,
                      "imagen": false,
                      "userIdSend": this.userId,
                      "userIdReceive": widget.id
                    }));
                textController.text = '';
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent * 1.2,
                  duration: Duration(milliseconds: 600),
                  curve: Curves.ease,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
