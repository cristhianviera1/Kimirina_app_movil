import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:kimirina_app/colors/colors.dart';
import 'package:kimirina_app/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final pages = [
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      bubbleBackgroundColor: naranja,
      //title: Container(),
      body: Column(
        children: <Widget>[
          Text(
            'Kimirina',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Kimirina es una organización comunitaria especializada en la respuesta a la epidemia del VIH, con capacidades técnicas, metodologías, abordajes, ',
            style: TextStyle(color: Colors.black54, fontSize: 16.0),
          ),
        ],
      ),
      mainImage: Image.asset('assets/gif/kimirina_logo.gif'),
      textStyle: TextStyle(color: Colors.black), title: Text(""),
    ),
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      bubbleBackgroundColor: naranja,
      title: Container(),
      body: Column(
        children: <Widget>[
          Text('Confidencialidad'),
          SizedBox(
            height: 10,
          ),
          Text(
            'Kimirina respeta y valora la confianza con nuestra corporación brindando la seguridad de la privacidad de la información de cada usuario',
            style: TextStyle(color: Colors.black54, fontSize: 16.0),
          ),
        ],
      ),
      mainImage: FlareActor("assets/animations/Lock_Animation.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "Untitled"),
      textStyle: TextStyle(color: Colors.black),
    ),
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      iconColor: null,
      bubbleBackgroundColor: naranja,
      title: Container(),
      body: Column(
        children: <Widget>[
          Text('Confianza'),
          SizedBox(
            height: 10,
          ),
          Text(
            'Kimirina con más de 20 años de experiencia es la primera corporación Ecuatoriana especializada en el VIH',
            style: TextStyle(color: Colors.black54, fontSize: 16.0),
          ),
        ],
      ),
      mainImage: FlareActor("assets/animations/handShake.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "Untitled"),
      textStyle: TextStyle(color: Colors.black),
    ),
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      iconColor: null,
      bubbleBackgroundColor: naranja,
      title: Container(),
      body: Column(
        children: <Widget>[
          Text('Sin Discriminación'),
          SizedBox(
            height: 10,
          ),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            style: TextStyle(color: Colors.black54, fontSize: 16.0),
          ),
        ],
      ),
      mainImage: Image.asset(
        'assets/images/sinDiscriminacion.png',
        width: 400.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(color: Colors.black),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
