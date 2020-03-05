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
      body: Column(
        children: <Widget>[
          Text(
            "Kimirina",
            style: TextStyle(
              inherit: true,
              fontSize: 48.0,
              color: Colors.white,
              shadows: [
                Shadow(
                    // bottomLeft
                    offset: Offset(-1.5, -1.5),
                    color: naranja),
                Shadow(
                    // bottomRight
                    offset: Offset(1.5, -1.5),
                    color: naranja),
                Shadow(
                    // topRight
                    offset: Offset(1.5, 1.5),
                    color: naranja),
                Shadow(
                    // topLeft
                    offset: Offset(-1.5, 1.5),
                    color: naranja),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Otra Oportunidad de Vida',
            style: TextStyle(color: Colors.black, fontSize: 19.0),
          ),
        ],
      ),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 0),
      mainImage: Image.asset('assets/gif/kimirina_logo.gif'),
      textStyle: TextStyle(color: Colors.black),
      title: Text(""),
    ),
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      bubbleBackgroundColor: morado,
      title: Container(
        height: 0,
        width: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth,
          animation: "Untitled"),
      textStyle: TextStyle(color: Colors.black),
    ),
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      iconColor: null,
      bubbleBackgroundColor: azul,
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
          fit: BoxFit.fitWidth,
          animation: "Untitled"),
      textStyle: TextStyle(color: Colors.black),
    ),
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
      iconColor: null,
      bubbleBackgroundColor: verde,
      title: Container(),
      body: Column(
        children: <Widget>[
          Text('Kimirina Inclusiva'),
          SizedBox(
            height: 10,
          ),
          Text(
            'Nuestras políticas se adaptan basadas en la importancia de caminar juntos hacia un norte que asegura la justicia y la equidad entre hombres, mujeres y toda su diversidad',
            style: TextStyle(color: Colors.black54, fontSize: 16.0),
          ),
        ],
      ),
      mainImage: Image.asset(
        'assets/images/sinDiscriminacion.png',
        fit: BoxFit.fitWidth,
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
