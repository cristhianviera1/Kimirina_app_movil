import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:kimirina_app/shared/colors.dart';
import 'package:kimirina_app/models/user_model.dart';
import 'package:kimirina_app/routes/routes.dart';
import 'package:kimirina_app/screens/login/register_page.dart';
import 'package:kimirina_app/services/user_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:kimirina_app/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = true;
  FocusNode myFocusNode;
  ApiService _apiService = ApiService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  void initState() {
    super.initState();
    checkUserLogin();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                ClipPath(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width,
                    color: naranja.withOpacity(0.6), //azul abajo
                  ),
                  clipper: RoundedClipper(60),
                ),
                ClipPath(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.33,
                    width: MediaQuery.of(context).size.width,
                    color: naranja, //Primario
                  ),
                  clipper: RoundedClipper(50),
                ),
                Positioned(
                    top: -110,
                    left: -110,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.30,
                      width: MediaQuery.of(context).size.height * 0.30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              (MediaQuery.of(context).size.height * 0.30) / 2),
                          color:
                              Color.fromRGBO(255, 0, 0, 0.9)), //circulo esquina
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: naranja),
                        ),
                      ),
                    )),
                Positioned(
                    top: -100,
                    left: 100,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.36,
                      width: MediaQuery.of(context).size.height * 0.36,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              (MediaQuery.of(context).size.height * 0.36) / 2),
                          color:
                              Color.fromRGBO(255, 0, 0, 0.9)), //Circulo Grande
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(
                                  255, 0, 0, 1.0)), //circulo centro
                        ),
                      ),
                    )),
                Positioned(
                    top: -50,
                    left: 60,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              (MediaQuery.of(context).size.height * 0.15) / 2),
                          color: Color.fromRGBO(255, 0, 0, 0.9)),
                    )),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.15 - 80),
                  height: MediaQuery.of(context).size.height * 0.33,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/logoTransparente.png",
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.height * 0.25,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 12, 20, 10),
              child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: validateEmail,
                      onSaved: (String val) {
                        _email = val;
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Correo",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.022,
                            horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                      onFieldSubmitted: (String value) {
                        FocusScope.of(context).requestFocus(myFocusNode);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: validatePassword,
                      onSaved: (String val) {
                        _password = val;
                      },
                      focusNode: myFocusNode,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: "password",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.022,
                            horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            activeColor: naranja,
                            value: _value1,
                            onChanged: _value1Changed,
                          ),
                          Text(
                            "recordarme",
                            style: TextStyle(
                                color: naranja, //letras recuerdame
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      child: GestureDetector(
                          onTap: () {
                            _validateInputs();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.065,
                            decoration: BoxDecoration(
                                color: naranja, //Boton
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: Center(
                              child: Text(
                                "Ingresar",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10, bottom: 15),
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()));
                          },
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "¿Eres nuevo?",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Registrarse",
                                  style: TextStyle(
                                      color: naranja,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool _value1 = false;
  bool _autoValidate = false;

  ///redirect user to main screen
  void _value1Changed(bool value) => setState(() => {_value1 = value});

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      //    If all data are correct then save data to out variables
      _formKey.currentState.save();
      _loginUser();
    } else {
      //    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void _loginUser() {
    User userReg = new User(email: _email, password: _password);
    _apiService.loginUser(userReg).then((response) async {

      if (response == "inaccesible") {
        return Alert(
          context: context,
          type: AlertType.warning,
          title: "No se pudo conectar",
          desc: "Por favor revise su conexión a internet.",
          buttons: [
            DialogButton(
              child: Text(
                "Aceptar",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }
      if (jsonDecode(response)["error"] == false) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        var tmpUsrId = jsonDecode(response)["user"]["id"];
        var name = jsonDecode(response)["user"]["name"];
        var email = jsonDecode(response)["user"]["email"];
        var image = jsonDecode(response)["user"]["image"];
        var age = jsonDecode(response)["user"]["age"];
        var gender = jsonDecode(response)["user"]["gender"];
        var rol = jsonDecode(response)["user"]["rol"];

        //recordarme
        preferences.setBool("recordarme", _value1);
        //
        userid = tmpUsrId;
        preferences.setString("userid", tmpUsrId);
        preferences.setString("name", name);
        preferences.setString("email", email);
        preferences.setString("image", image);
        preferences.setString("age", age);
        preferences.setString("gender", gender);
        preferences.setString("rol", rol);
        userApp.gender = gender;
        userApp.age = age;
        userApp.image = image;
        socket.emit("login", {"userId": tmpUsrId});
        Navigator.of(context).pushReplacementNamed(navBarViewRoute);
      } else {
        var errMsg = jsonDecode(response)["msg"];
        return Alert(
          context: context,
          type: AlertType.warning,
          title: "Error al iniciar sesión",
          desc: errMsg,
          buttons: [
            DialogButton(
              child: Text(
                "Aceptar",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }
      return null;
    });
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Ingrese un email válido';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.length < 6)
      return 'La contraseña debe tener al menos 6 caracteres';
    else
      return null;
  }

  void checkUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var remeberMe = prefs.getBool("recordarme") ?? false;
    if (remeberMe) {
      Navigator.of(context).pushNamed(navBarViewRoute);
    }
  }
}

class RoundedClipper extends CustomClipper<Path> {
  var differenceInHeights = 0;

  RoundedClipper(int differenceInHeights) {
    this.differenceInHeights = differenceInHeights;
  }

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - differenceInHeights);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
