import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewsScreen extends StatelessWidget {
  static final String path = "lib/src/pages/blog/sports_news1.dart";

  @override
  Widget build(BuildContext context) {
    final Color bgColor = Color(0xffF3F3F3);
    final Color primaryColor = Color(0xffE70F0B);

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
    return Scaffold(
      backgroundColor: bgColor,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 16.0),
        children: <Widget>[
          Card(
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
                          image: DecorationImage(
                            image: new AssetImage("assets/images/pacto_global.jpg"),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Kimirina: Miembro de la Red Pacto Global Ecuador",
                        style: titleTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                          child: AutoSizeText("KIMIRINA MIEMBRO DE LA RED PACTO GLOBAL ECUADOR Pacto Global es una iniciativa de Naciones Unidas lanzada en el año 2000, como un llamado voluntario"),
                          ),
                          
                          
                          
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ],
            ),
          ),
          Card(
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
                          image: DecorationImage(
                            image: new AssetImage("assets/images/2_15_2_SISTEMA_NACIONES-UNIDAS.jpg"),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "¡Latinoamérica y el Caribe: una región que no puede quedar atrás!",
                        style: titleTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                          child: AutoSizeText("¡Latinoamérica y el Caribe: una región que no puede quedar atrás! Las redes y organizaciones regionales trabajando en América Latina y el Caribe Hispano han"),
                          ),
                          
                          
                          
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ],
            ),
          ),
          Card(
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
                          image: DecorationImage(
                            image: new AssetImage("assets/images/convenio_kimirina_embajada.jpg"),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Alrededor de 500 personas en situación de movilidad humana conviven con VIH en Ecuador",
                        style: titleTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                          child: AutoSizeText("Alrededor de 500 personas en situación de movilidad humana conviven con VIH en Ecuador Vincent Pelletier, director de Coalición Plus; Verónica Espinosa, ministra de Salud;"),
                          ),
                          
                          
                          
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ],
            ),
          ),
           Card(
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
                          image: DecorationImage(
                            image: new AssetImage("assets/images/pruebaRapida.jpg"),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Hoja Informativa: Las Pruebas Rápidas y sus resultados",
                        style: titleTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                          child: AutoSizeText("Hoja Informativa: Las Pruebas Rápidas de VIH y sus resultados Desde el descubrimiento del VIH, la tecnología de las pruebas diagnósticas ha evolucionado sustancialmente y"),
                          ),
                          
                          
                          
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ],
            ),
          ),
        ],
        
      ),
      
    );
        
        
  }
  
}
