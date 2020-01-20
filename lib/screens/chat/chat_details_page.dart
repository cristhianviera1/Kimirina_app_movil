import 'package:flutter/material.dart';
import 'package:kimirina_app/colors/colors.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _showBottom = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black54),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MyCircleAvatar(
              imgUrl: friendsList[0]['imgUrl'],
            ),
            SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Cybdom Tech",
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "Online",
                  style: Theme.of(context).textTheme.subtitle.apply(
                        color: Color.fromRGBO(26, 134, 61, 1),
                      ),
                )
              ],
            )
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: messages.length,
                    itemBuilder: (ctx, i) {
                      if (messages[i]['status'] == MessageType.received) {
                        return ReceivedMessagesWidget(i: i);
                      } else {
                        return SentMessageWidget(i: i);
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  height: 61,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35.0),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.face), onPressed: () {}),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: "Type Something...",
                                      border: InputBorder.none),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.photo_camera),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.attach_file),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: morado, shape: BoxShape.circle),
                        child: InkWell(
                          child: Icon(
                            Icons.keyboard_voice,
                            color: Colors.white,
                          ),
                          onLongPress: () {
                            setState(() {
                              _showBottom = true;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showBottom = false;
                });
              },
            ),
          ),
          _showBottom
              ? Positioned(
                  bottom: 90,
                  left: 25,
                  right: 25,
                  child: Container(
                    padding: EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 5),
                            blurRadius: 15.0,
                            color: Colors.grey)
                      ],
                    ),
                    child: GridView.count(
                      mainAxisSpacing: 21.0,
                      crossAxisSpacing: 21.0,
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      children: List.generate(
                        icons.length,
                        (i) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.grey[200],
                              border: Border.all(color: Color.fromRGBO(26, 134, 61, 1), width: 2),
                            ),
                            child: IconButton(
                              icon: Icon(
                                icons[i],
                                color: Color.fromRGBO(26, 134, 61, 1),
                              ),
                              onPressed: () {},
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
class SentMessageWidget extends StatelessWidget {
  final int i;
  const SentMessageWidget({
    Key key,
    this.i,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "${messages[i]['time']}",
            style: Theme.of(context).textTheme.body2.apply(color: Colors.grey),
          ),
          SizedBox(width: 15),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .6),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: azul,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
            ),
            child: Text(
              "${messages[i]['message']}",
              style: Theme.of(context).textTheme.body2.apply(
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReceivedMessagesWidget extends StatelessWidget {
  final int i;
  const ReceivedMessagesWidget({
    Key key,
    @required this.i,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        children: <Widget>[
          MyCircleAvatar(
            imgUrl: messages[i]['contactImgUrl'],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${messages[i]['contactName']}",
                style: Theme.of(context).textTheme.caption,
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .6),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Color(0xfff9f9f9),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Text(
                  "${messages[i]['message']}",
                  style: Theme.of(context).textTheme.body1.apply(
                        color: Colors.black87,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(width: 15),
          Text(
            "${messages[i]['time']}",
            style: Theme.of(context).textTheme.body2.apply(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class MyCircleAvatar extends StatelessWidget {
  final String imgUrl;
  const MyCircleAvatar({
    Key key,
    @required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(.3),
              offset: Offset(0, 2),
              blurRadius: 5)
        ],
      ),
      child: CircleAvatar(
        backgroundImage: NetworkImage("$imgUrl"),
      ),
    );
  }
}


List<IconData> icons = [
  Icons.image,
  Icons.camera,
  Icons.file_upload,
  Icons.folder,
  Icons.gif
];

List<Map<String, dynamic>> messages = [
  {
    'status' : MessageType.received,
    'contactImgUrl' : 'https://cdn.pixabay.com/photo/2015/01/08/18/29/entrepreneur-593358_960_720.jpg',
    'contactName' : 'Client',
    'message' : 'Hi mate, I\d like to hire you to create a mobile app for my business' ,
    'time' : '08:43 AM'
  },
  {
    'status' : MessageType.sent,
    'message' : 'Hi, I hope you are doing great!' ,
    'time' : '08:45 AM'
  },
  {
    'status' : MessageType.sent,
    'message' : 'Please share with me the details of your project, as well as your time and budgets constraints.' ,
    'time' : '08:45 AM'
  },
  {
    'status' : MessageType.received,
    'contactImgUrl' : 'https://cdn.pixabay.com/photo/2015/01/08/18/29/entrepreneur-593358_960_720.jpg',
    'contactName' : 'Client',
    'message' : 'Sure, let me send you a document that explains everything.' ,
    'time' : '08:47 AM'
  },
  {
    'status' : MessageType.sent,
    'message' : 'Ok.' ,
    'time' : '08:45 AM'
  },
];

List<Map<String, dynamic>> friendsList = [
  {
    'imgUrl':
        'https://cdn.pixabay.com/photo/2019/11/06/17/26/gear-4606749_960_720.jpg',
    'username': 'Cybdom Tech',
    'lastMsg': 'Hey, checkout my website: cybdom.tech ;)',
    'seen': true,
    'hasUnSeenMsgs': false,
    'unseenCount': 0,
    'lastMsgTime': '18:44',
    'isOnline': true
  },
  {
    'imgUrl':
        'https://cdn.pixabay.com/photo/2019/11/11/04/33/africa-4617142_960_720.jpg',
    'username': 'Flutter Dev',
    'lastMsg': 'Hey, checkout my website: cybdom.tech ;)',
    'seen': false,
    'hasUnSeenMsgs': false,
    'unseenCount': 0,
    'lastMsgTime': '18:44',
    'isOnline': false
  },
  {
    'imgUrl':
        'https://cdn.pixabay.com/photo/2019/11/05/08/52/adler-4603104_960_720.jpg',
    'username': 'Dart Dev',
    'lastMsg': 'Hey, checkout my website: cybdom.tech ;)',
    'seen': false,
    'hasUnSeenMsgs': true,
    'unseenCount': 3,
    'lastMsgTime': '18:44',
    'isOnline': true
  },
  {
    'imgUrl':
        'https://cdn.pixabay.com/photo/2015/02/04/08/03/baby-623417_960_720.jpg',
    'username': 'Designer',
    'lastMsg': 'Hey, checkout my website: cybdom.tech ;)',
    'seen': true,
    'hasUnSeenMsgs': true,
    'unseenCount': 2,
    'lastMsgTime': '18:44',
    'isOnline': true
  },
  {
    'imgUrl':
        'https://cdn.pixabay.com/photo/2012/03/04/01/01/baby-22194_960_720.jpg',
    'username': 'FrontEnd Dev',
    'lastMsg': 'Hey, checkout my website: cybdom.tech ;)',
    'seen': false,
    'hasUnSeenMsgs': true,
    'unseenCount': 4,
    'lastMsgTime': '18:44',
    'isOnline': true
  },
  {
    'imgUrl':
        'https://cdn.pixabay.com/photo/2015/01/08/18/29/entrepreneur-593358_960_720.jpg',
    'username': 'Full Stack Dev',
    'lastMsg': 'Hey, checkout my website: cybdom.tech ;)',
    'seen': false,
    'hasUnSeenMsgs': false,
    'unseenCount': 0,
    'lastMsgTime': '18:44',
    'isOnline': true
  },
  {
    'imgUrl':
        'https://cdn.pixabay.com/photo/2015/01/08/18/29/entrepreneur-593358_960_720.jpg',
    'username': 'Backend Dev',
    'lastMsg': 'Hey, checkout my website: cybdom.tech ;)',
    'seen': false,
    'hasUnSeenMsgs': true,
    'unseenCount': 3,
    'lastMsgTime': '18:44',
    'isOnline': true
  }
];



enum MessageType {sent, received}