import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:kimirina_app/routes/routes.dart';
import 'package:kimirina_app/shared/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SlidesList.dart';

class CarruselPage extends StatefulWidget {
  @override
  _CarruselPageState createState() => _CarruselPageState();
}

class _CarruselPageState extends State<CarruselPage> {
  @override
  void initState() {
    super.initState();
    verifyFirstOpen();
  }

  final pages = carruselPages
      .map<PageViewModel>((slide) => PageViewModel(
            pageColor: Color(0xF6F6F7FF),
            bubbleBackgroundColor: slide.bubbleBackground,
            body: Column(
              children: <Widget>[
                slide.title,
                SizedBox(
                  height: 10,
                ),
                Text(
                  slide.subTitle,
                  style: TextStyle(color: Colors.black54, fontSize: 16.0),
                ),
              ],
            ),
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 0),
            mainImage: slide.mainImage,
            textStyle: TextStyle(color: Colors.black),
            title: Text(""),
          ))
      .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            IntroViewsFlutter(
              pages,
              onTapDoneButton: () {
                updateFirstOpen();
                Navigator.of(context).pushNamed(loginViewRoute);
              },
              showSkipButton: true,
              doneText: Text(
                "Empezar",
              ),
              skipText: Text("Omitir"),
              pageButtonsColor: naranja,
              pageButtonTextStyles: new TextStyle(
                // color: naranja,
                fontSize: 13.0,
                fontFamily: "Regular",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future updateFirstOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("firstInit", true);
  }

  Future<bool> verifyFirstOpen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var firstInit = pref.getBool("firstInit") ?? false;
    if (firstInit) {
      Navigator.of(context).pushNamed(loginViewRoute);
    }
  }
}
