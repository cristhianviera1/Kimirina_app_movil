import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kimirina_app/colors/colors.dart';
import 'package:kimirina_app/models/user_model.dart';
import 'package:kimirina_app/navBar/navBar.dart';
import 'package:kimirina_app/routes/routes.dart';
import 'package:kimirina_app/services/user_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _nombre;
  String _correo;
  String _imagen;
  String _edad;
  String _genero;
  File _pickedImage;
  Uint8List _decode;
  bool _imagePicked = false;
  @override
  void initState() {
    super.initState();
    getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    void _pickImage() async {
      final imageSource = await showDialog<ImageSource>(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Select the image source"),
                actions: <Widget>[
                  MaterialButton(
                    child: Text("Cámara"),
                    onPressed: () => Navigator.pop(context, ImageSource.camera),
                  ),
                  MaterialButton(
                    child: Text("Galeria"),
                    onPressed: () =>
                        Navigator.pop(context, ImageSource.gallery),
                  )
                ],
              ));
      if (imageSource != null) {
        print(imageSource);
        final file = await ImagePicker.pickImage(source: imageSource);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (file != null) {
          setState(() {
            print("Una imagen si fue seleccionada");
            _pickedImage = file;
            _imagePicked = true;
            List<int> imageBytes = file.readAsBytesSync();
            print(imageBytes);
            String base64Image = base64Encode(imageBytes);
            this._decode = base64Decode(base64Image);
            prefs.setString("imagen", base64Image);
            print(base64Image);
            var user = new User(imagen: base64Image);
            ApiService().updateUser(user).then((response){
              if(response){
                Alert(
                  context: context,
                  title: "Se ha actualizado la imagen de perfil",
                  type: AlertType.success,
                ).show();
              }else{
                Alert(
                  context: context,
                  title: "Ha ocurrido un error",
                  desc: "Por favor vuelva a intentarlo",
                  type: AlertType.error,
                ).show();
              }
            });
          });
        }
      }
    }

    return Scaffold(
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
                    padding: EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: _imagePicked == false
                          ? Image.asset("assets/images/usuario.png")
                          : ClipRRect(
                              borderRadius: new BorderRadius.circular(10.0),
                              child: Image.memory(_decode)
                            ) 
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                  ),
                  Text(
                    _nombre ?? "Usuario",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Container(
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
                                      leading: Icon(Icons.email),
                                      title: Text("Correo"),
                                      subtitle: Text(_correo ?? "correo"),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.email),
                                      title: Text("Edad"),
                                      subtitle: Text(_edad ?? "Edad"),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.email),
                                      title: Text("Genero"),
                                      subtitle: Text(_genero ?? "Genero"),
                                    ),
                                    ListTile(
                                      leading: Icon(FontAwesomeIcons.powerOff),
                                      title: Text("Cerrar Sesión"),
                                      onTap: () async {
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        var userId = prefs.getString("userid");
                                        var socket = io.io("http://192.168.0.103:4000");
                                        socket.emit('logout', {"userId": userId});
                                        //Provider.of<ApiService>(context,listen: false).logout(userId);
                                        prefs.remove("userid");
                                        Navigator.pop(scaffoldKey.currentContext);
                                        Navigator.of(context).pushNamed(loginViewRoute);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(FontAwesomeIcons.kaggle,
                                          color: Color.fromRGBO(240, 53, 6, 1)),
                                      title: Text(
                                          "¿Nos ayudas con más información?"),
                                      subtitle: Text(
                                          "Toda la información será completamente confidencial y con fines de estudio"),
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed(formViewRoute);
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
                  )
                ],
              )
            ],
          ),
        ],
      ),
    ));
  }

  void getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this._nombre = prefs.getString("nombre");
      this._correo = prefs.getString("correo");
      this._imagen = prefs.getString("imagen");
      /*if(this._imagen != null){
        this._decode = base64Decode(this._imagen);
        _imagePicked=true;
      }*/
      this._edad = prefs.getString("edad");
      this._genero = prefs.getString("genero");
    });
  }
}
