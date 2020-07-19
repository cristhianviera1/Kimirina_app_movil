import 'package:auto_size_text/auto_size_text.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kimirina_app/shared/colors.dart';
import 'package:kimirina_app/navBar/navBar.dart';
import 'package:kimirina_app/routes/routes.dart';
import 'package:kimirina_app/screens/product/product_details.dart';
import 'package:kimirina_app/services/user_service.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key key}) : super(key: key);

  _ProductScreen createState() => _ProductScreen();
}

class _ProductScreen extends State<ProductScreen> {
  List<Widget> productosCards = new List();
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);

  @override
  initState() {
    getProducts();
    super.initState();
  }

  List<Map> schoolLists = [
    {
      "name": "Asesoría en Prevención de VIH e ITS",
      "type": "En respuesta a la epidemia del VIH, con capacidades...",
      "logoText": "assets/images/asesorias.png",
      "route": productDetaisViewRoute
    },
    {
      "name": "Pruebas Rápidas VIH",
      "type":
          "Esta prueba es empleada para detectar la infección causada por ese virus, permite detectar anticuerpos contra el VIH en la sangre en menos de 30 minutos",
      "logoText": "assets/images/pruebaRapida.jpg",
      "route": pruebaRapidaVihViewRoute
    },
    {
      "name": "Pruebas rapidas ITS",
      "type":
          "Es un tipo de prueba de anticuerpos, contra virus o bacterias, causantes de infecciones de transmisión sexual.",
      "logoText": "assets/images/its.png",
      "route": pruebaRapidaItsViewRoute
    },
    {
      "name": "Atención a personas con ITS",
      "type": "Se oferta el servicio y la derivación médica...",
      "logoText": "assets/images/vinculacion.png",
      "route": atencionItsViewRoute
    },
    {
      "name": "PrEP",
      "type":
          "Esta dirigida a personas negativas para VIH que buscan prevenir una futura infección.",
      "logoText": "assets/images/prep.png",
      "route": prepViewRoute
    },
    {
      "name": "nPEP",
      "type":
          "Consiste tomar medicamentos contra el VIH dentro de 72 horas después de una posible...",
      "logoText": "assets/images/npep.jpg",
      "route": npepViewRoute
    },
    {
      "name": "Programa de atencion a PPVS",
      "type":
          "Kimirina oferta servicios de asesoría, atención y control de PPVS.",
      "logoText": "assets/images/ppvs.png",
      "route": ppvsViewRoute
    },
  ];
  var numberOfProducts = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          height: 70,
          padding: const EdgeInsets.only(top: 20.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: naranja,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              )),
          child: ListTile(
            title: Text(
              "Nuestros servicios",
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
      backgroundColor: Color(0xfff0f0f0),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height - 120,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: numberOfProducts,
                    itemBuilder: (BuildContext context, int index) {
                      return buildList(context, index);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProductDetailsPage(
                      titulo: schoolLists[index]['name'],
                      descripcion: schoolLists[index]['type'],
                      imagenUrl: schoolLists[index]['logoText'],
                      link: schoolLists[index]['link'],
                      observaciones: schoolLists[index]['observaciones'],
                      precio: schoolLists[index]['precio'],
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 110,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              margin: EdgeInsets.only(right: 15, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                border: Border.all(width: 3, color: secondary),
                image: DecorationImage(
                    image: new NetworkImage(schoolLists[index]['logoText']),
                    fit: BoxFit.fill),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    schoolLists[index]['name'],
                    style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.info,
                        color: secondary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: AutoSizeText(
                        schoolLists[index]['type'],
                        maxLines: 3,
                      )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getProducts() {
    this.schoolLists = new List();
    ApiService().getProductos().then((value) {
      setState(() {
        for (var i = 0; i < value.length; i++) {
          schoolLists.add({
            "name": value[i]["titulo"],
            "type": value[i]["descripcion"],
            "logoText": value[i]["imagen"],
            "link": value[i]["link"],
            "observaciones": value[i]["observaciones"],
            "precio": value[i]["precio"],
          });
        }
        numberOfProducts = schoolLists.length;
      });
    });
  }
}
