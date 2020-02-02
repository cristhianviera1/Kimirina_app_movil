import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kimirina_app/colors/colors.dart';
import 'package:kimirina_app/routes/routes.dart';
import 'package:kimirina_app/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'form_page.dart';

class CurrentProfile {
  /*ApiService _apiService = ApiService();
  verifyToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token") ?? null;
    if (token != null) {
      _apiService.verifyToken(token).then((response) {
        if (response != null) {
          prefs.setString("nombre", response.nombre);
          prefs.setString("email", response.id);
          prefs.setString("id", response.email);
        }
      });
    }
  }*/
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File _pickedImage;
  File _decode;
  bool _imagePicked = false;
  @override
  Widget build(BuildContext context) {
    void _pickImage() async {
      final imageSource = await showDialog<ImageSource>(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Select the image source"),
                actions: <Widget>[
                  MaterialButton(
                    child: Text("Camera"),
                    onPressed: () => Navigator.pop(context, ImageSource.camera),
                  ),
                  MaterialButton(
                    child: Text("Gallery"),
                    onPressed: () =>
                        Navigator.pop(context, ImageSource.gallery),
                  )
                ],
              ));
      if (imageSource != null) {
        print(imageSource);
        final file = await ImagePicker.pickImage(source: imageSource);
        if (file != null) {
          setState(() {
            print("Una imagen si fue seleccionada");
            _pickedImage = file;
            _decode = file;
            _imagePicked = true;
            List<int> imageBytes = file.readAsBytesSync();
            print(imageBytes);
            String base64Image = base64Encode(imageBytes);
            print(base64Image);
            Uint8List decoded = base64Decode(base64Image);
            print(decoded);
          });
        }
      }
    }

    Future.delayed(Duration.zero, () async {
      //CurrentProfile().verifyToken();
      //SharedPreferences prefs = await SharedPreferences.getInstance();
    });
    return Scaffold(
        //backgroundColor: Color.fromRGBO(255, 255, 255, .9),
        body: SafeArea(
      child: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 330,
                color: morado,
              ),
              Positioned(
                top: 10,
                right: 30,
                child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    elevation: 50.0,
                    onPressed: () {
                      Navigator.of(context).pushNamed(settingsViewRoute);
                    }),
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: 150,
                    margin: EdgeInsets.only(top: 60),
                    padding: EdgeInsets.all(20.0),
                    
                    child: GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: _imagePicked == false
                          ? Image.asset("assets/images/usuario.png")
                          : Image(image: new  FileImage(_decode)),
                    ),
                    //decoration: new BoxDecoration(

                    //image: new DecorationImage(
                    //  image: new FileImage(_pickedImage)
                    //  )
                    // ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                  ),
                  Text(
                    "Gabriel Viera",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  UserInfo()
                ],
              )
            ],
          ),
        ],
      ),
    ));
  }
}

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String _provincia = "Pichincha";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Información del usuario",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Divider(
                    color: Colors.black38,
                  ),
                  Container(
                      child: Column(
                    children: <Widget>[
                      ListTile(
                          leading: Icon(Icons.my_location),
                          title: Text("Provincia"),
                          subtitle: Text("$_provincia"),
                          onTap: () {
                            Alert(
                                context: context,
                                title: "Provincia",
                                content: Column(
                                  children: <Widget>[
                                    DropdownButton(
                                      value: _provincia,
                                      icon: Icon(Icons.arrow_downward),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      items: <String>[
                                        'Pichincha',
                                        'Guayas',
                                        'Loja',
                                        'Esmeraldas'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String newValue) {
                                        _provincia = newValue;
                                        //setState(() {});
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                                buttons: []).show();
                          }),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text("Correo"),
                        subtitle: Text("cristhian.viera1@gmail.com"),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text("Phone"),
                        subtitle: Text("0988677461"),
                      ),
                      ListTile(
                        leading: Icon(FontAwesomeIcons.powerOff),
                        title: Text("Cerrar Sesión"),
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          var userId = prefs.getString("userid");
                          Provider.of<ApiService>(context,listen: false).logout(userId);
                          prefs.remove("userid");
                          Navigator.of(context).pushNamed(loginViewRoute);
                        },
                      ),
                      ListTile(
                        leading: Icon(FontAwesomeIcons.kaggle,
                            color: Color.fromRGBO(240, 53, 6, 1)),
                        title: Text("¿Nos ayudas con más información?"),
                        subtitle: Text(
                            "Así podemos crear planes de prevención y campañas de tratamiento"),
                        onTap: () {
                          Navigator.of(context).pushNamed(formViewRoute);
                        },
                      )
                    ],
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
