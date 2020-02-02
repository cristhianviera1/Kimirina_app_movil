import 'package:flutter/material.dart';
import 'package:kimirina_app/colors/colors.dart';
import 'package:kimirina_app/routes/routes.dart';
import "package:kimirina_app/widgets/network_image.dart";

class PpvsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: naranja,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                  height: 300,
                  width: double.infinity,
                  child: Image.asset("assets/images/tratamiento.png")),
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
                      "Programa de atencion a PPVS",
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(height: 10.0),
                    Text("¿Qué es?"),
                    SizedBox(height: 10.0),
                    Divider(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Kimirina oferta servicios de asesoría, atención y control de PPVS, preferentemente a migrantes que se encuentren en situación de tránsito dentro del territorio nacional, con la intención de brindar información relacionada al cuidado, la protección y el tratamiento del VIH.",
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: GestureDetector(
                       onTap: (){
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
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
