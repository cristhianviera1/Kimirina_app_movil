import 'package:flutter/material.dart';
import 'package:kimirina_app/models/productos_model.dart';
import 'package:kimirina_app/shared/colors.dart';
import 'package:kimirina_app/routes/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailsPage extends StatefulWidget {
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();

  //final Agencias agencias;
  final Producto ProductoDetails;

  ProductDetailsPage({Key key, this.ProductoDetails}) : super(key: key);
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: naranja,
        title: Text(widget.ProductoDetails.titulo),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                decoration: new BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.ProductoDetails.imagen),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16.0, 250.0, 16.0, 16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.ProductoDetails.titulo,
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(height: 10.0),
                    Text(widget.ProductoDetails.precio),
                    SizedBox(height: 10.0),
                    Divider(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      widget.ProductoDetails.descripcion,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.ProductoDetails.observaciones,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                        child: Text(
                            "Consulta este enlace para más información\n${widget.ProductoDetails.link}",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue)),
                        onTap: () {
                          launch(widget.ProductoDetails.link);
                        }),
                    SizedBox(height: 20.0),
                    Container(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(agenciasViewRoute);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.065,
                            decoration: BoxDecoration(
                                color: naranja,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: Center(
                              child: Text(
                                "Agencias",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
