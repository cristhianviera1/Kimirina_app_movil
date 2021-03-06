import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kimirina_app/config/config.dart';
import 'package:kimirina_app/navBar/navBar.dart';
import 'package:kimirina_app/routes/routes.dart';
import 'package:kimirina_app/services/user_service.dart';
import 'package:kimirina_app/shared/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _id;
  String _name;
  String _email;
  String _image;

  PickedFile _pickedImage;
  bool _imagePicked = false;
  String _gender;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    getPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _pickImage() async {
      final imageSource = await showDialog<ImageSource>(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Seleccione una fuente"),
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
        final file = (await _picker.getImage(source: imageSource));
        if (file != null) {
          setState(() {
            _pickedImage = file;
            _imagePicked = true;
            ApiService().uploadImage(file).then((response) => {
                  if (response["error"] == false)
                    {
                      setState(() => {userApp.image = response["data"]}),
                      Alert(
                        context: context,
                        title: "Se ha actualizado la imagen de perfil",
                        type: AlertType.success,
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Aceptar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                          )
                        ],
                      ).show()
                    }
                  else
                    {
                      Alert(
                        context: context,
                        title: "Ha ocurrido un error",
                        desc: "Por favor vuelva a intentarlo",
                        type: AlertType.error,
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Aceptar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                          )
                        ],
                      ).show()
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
                        child: userApp.image ==
                                "http://144.91.108.171:4008/images/usuarios/836295524.jpg"
                            ? CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                    "http://144.91.108.171:4008/images/usuarios/836295524.jpg"),
                              )
                            : CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(userApp.image),
                              )),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                  ),
                  Text(
                    _name ?? "Usuario",
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
                                      subtitle: Text(_email ?? "email"),
                                    ),
                                    ListTile(
                                      leading: Icon(FontAwesomeIcons.powerOff),
                                      title: Text("Cerrar Sesión"),
                                      onTap: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        var userId = prefs.getString("userid");
                                        var socket = io.io(urlApiRest);
                                        socket
                                            .emit('logout', {"userId": userId});
                                        socket.on("updateOfUser", (data) {});
                                        //Provider.of<ApiService>(context,listen: false).logout(userId);
                                        prefs.remove("userid");
                                        prefs.remove("recordarme");
                                        Navigator.pop(
                                            scaffoldKey.currentContext);
                                        Navigator.of(context)
                                            .pushNamed(loginViewRoute);
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
      this._id = prefs.getString("userid");
      this._name = prefs.getString("name");
      this._email = prefs.getString("email");
    });
  }
}
