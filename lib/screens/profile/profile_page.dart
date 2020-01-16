import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class ProfileScreen extends StatelessWidget {
  final image = 'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F1.jpg?alt=media';
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.only(top: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 96.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Alanys Rojas", style: Theme.of(context).textTheme.title,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(image),
                            fit: BoxFit.cover
                          )
                        ),
                        margin: EdgeInsets.only(left: 16.0),
                        ),
                    ],
                  ),

                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text("Email"),
                          subtitle: Text("afv.rojas@yavirac.edu.ec"),
                          leading: Icon(Icons.email),
                        ),
                        ListTile(
                          title: Text("Teléfono"),
                          subtitle: Text("xxxxxxx"),
                          leading: Icon(Icons.phone),
                        ),
                        ListTile(
                          title: Text("Provincia"),
                          subtitle: Text("Pichincha"),
                          leading: Icon(Icons.location_city),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}