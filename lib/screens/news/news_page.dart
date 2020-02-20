import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kimirina_app/colors/colors.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:kimirina_app/services/user_service.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  static final String path = "lib/src/pages/blog/sports_news1.dart";

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<Widget> novedadesCards = new List();
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
            children: novedadesCards,
          )
        ],
      ),
    );
  }

  getNews() {
    ApiService().getNovedades().then((value) {
      setState(() {
        for (var novedad in value) {
          novedadesCards.add(new _NovedadItem(novedad["titulo"],
              novedad["descripcion"], novedad["imagen"], novedad["link"]));
          print(novedadesCards[0]);
        }
      });
    });
  }
}

class _NovedadItem extends StatelessWidget {
  final String titulo, descripcion, imagen, link;
  Uint8List imagenDecodificada;
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
  _NovedadItem(this.titulo, this.descripcion, this.imagen, this.link);
  @override
  Widget build(BuildContext context) {
    // imagenDecodificada = base64.decode(imagen.toString());
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
                        DecorationImage(image: new NetworkImage(this.imagen))),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  titulo,
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
                          child: AutoSizeText(descripcion),
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
