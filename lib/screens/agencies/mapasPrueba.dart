import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:kimirina_app/colors/colors.dart';

class MapsScreen extends StatefulWidget {
    //final Agencias agencias;
    final String agencieCity;
    final double lat;
    final double lng;
    MapsScreen({Key key,@required this.agencieCity,this.lat,this.lng}):super(key:key);

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  Widget build(BuildContext context) {
    print("Hail Hydra${widget.agencieCity}\n${widget.lat}-${widget.lng}");
     return Scaffold(
       appBar: AppBar(
         title: Text("Centro Comunitario de ${widget.agencieCity}"),
         backgroundColor: azul,
         
       ),
       body: new FlutterMap(
        options: new MapOptions(
          center: new LatLng(widget.lat,widget.lng),
          zoom: 18.0,
        ),
        layers: [
          new TileLayerOptions(
            //urlTemplate: "https://api.tiles.mapbox.com/v4/"
             //   "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
             urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            additionalOptions: {
              'accessToken': 'pk.eyJ1IjoiYWx5dXd1ciIsImEiOiJjazVxNTdweTkwM3R4M21zNjJueGpvdXdtIn0.ANc-OGubkc-MkqcKE4Fn9w',
              'id': 'mapbox.streets',
            },
            subdomains: ["a","b","c"],
          ),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 80.0,
                height: 80.0,
                point: new LatLng(widget.lat, widget.lng),
                builder: (ctx) =>
                new Container(
                  child: Image.asset("assets/images/logoTransparente.png"),
                ),
              ),
            ],
          ),
        ],
    ),
    
     );

  }
}

/*class Agencias {
  final String ciudad;
  final String coordenadas;

  Agencias(this.ciudad, this.coordenadas);
}
final agencias = List<Agencias>.generate(
  20,
  (i) => Agencias(
        'Agencias $i',
        'coordenadas $i',
      ),
      ListView.builder(
  itemCount: agencias.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(agencias[index].ciudad),
    );
  },
),
);


List<Map<String, dynamic>> agenciasCiudad = [
  {
    'ciudad': "Quito",
    'coordenadas': '-0.205294, -78.488857'
    
  },
  {
   'ciudad': "Guayaquil",
    'coordenadas': '-2.191523, -79.883687'
    
  },
  {
    'ciudad': "Machala",
    'coordenadas': '-3.260251, -79.957012'
  },
  {
    'ciudad': "esmeraldas",
    'coordenadas': '-0.205294, -78.488857'
  },
  {
   'ciudad': "portoviejo",
    'coordenadas': '-0.205294, -78.488857'
  },
  {
    'ciudad': "santoDomingo",
    'coordenadas': '-0.205294, -78.488857'
  },
  {
    'ciudad': "santaElena",
    'coordenadas': '-0.205294, -78.488857'
  },
];


*/