import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kimirina_app/services/user_service.dart';
import 'package:kimirina_app/shared/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  static final String path = "lib/src/pages/blog/sports_news1.dart";

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<Widget> newsCards = new List();
  final Color bgColor = Color(0xffF3F3F3);
  final Color primaryColor = Color(0xffE70F0B);

  @override
  initState() {
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          height: 70,
          padding: const EdgeInsets.only(top: 20.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: verde,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              )),
          child: ListTile(
            title: Text(
              "Noticias",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        preferredSize: Size.fromHeight(90.0),
      ),
      backgroundColor: bgColor,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
        children: <Widget>[
          Column(
            children: newsCards,
          )
        ],
      ),
    );
  }

  getNews() {
    ApiService().getNews().then((value) {
      setState(() {
        for (var news in value) {
          newsCards.add(new _NewsItem(news["title"],
              news["description"], news["image"], news["link"]));
        }
      });
    });
  }
}

class _NewsItem extends StatelessWidget {
  final String title, description, image, link;
  Uint8List imageDecoded;
  var titleTextStyle = TextStyle(
    color: Colors.black87,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );
  var teamNameTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: Colors.grey.shade800,
  );
  _NewsItem(this.title, this.description, this.image, this.link);
  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    image:
                        DecorationImage(image: new NetworkImage(this.image))),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: titleTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: AutoSizeText(description),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Text("Ver más..."),
                    GestureDetector(
                        child: Text(link,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue)),
                        onTap: () {
                          launch(link);
                        }),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ],
      ),
    );
  }
}
