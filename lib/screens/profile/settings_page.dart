import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kimirina_app/shared/colors.dart';
import 'package:kimirina_app/services/user_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SettingsOnePage extends StatefulWidget {
  @override
  _SettingsOnePageState createState() => _SettingsOnePageState();
}

class _SettingsOnePageState extends State<SettingsOnePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool _dark;
  FocusNode focusNode2;
  FocusNode focusNode3;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _password;
  @override
  void initState() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    super.initState();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    _dark = false;
  }

  Future onSelectNotification(String payload) {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('Notification'),
        content: new Text('$payload'),
      ),
    );
    return null;
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var plataform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Primera notificacion', 'Flutter Notificacion', plataform,
        payload: 'hola q hace');
  }

  activarNotificaciones(bool estado) async {
    if (estado == false) {
      await flutterLocalNotificationsPlugin.cancelAll();
    } else {
      showNotification();
    }
  }

  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    var oneNotification = false;
    var twoNotification = false;
    var threeNotification = false;
    return Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        backgroundColor: _dark ? null : Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          brightness: _getBrightness(),
          iconTheme: IconThemeData(color: _dark ? Colors.white : Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            'Configuración',
            style: TextStyle(color: _dark ? Colors.white : Colors.black),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10.0),
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.lock_outline,
                            color: morado,
                          ),
                          title: Text("Cambiar Contraseña"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Alert(
                                context: context,
                                title: "Contraseña",
                                content: Column(
                                  children: <Widget>[
                                    Form(
                                      key: _formKey,
                                      autovalidate: _autoValidate,
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            validator: validatePassword,
                                            onSaved: (String val) {
                                              _password = val;
                                            },
                                            focusNode: focusNode2,
                                            obscureText: true,
                                            keyboardType: TextInputType.text,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              labelText: "Contraseña",
                                              contentPadding:
                                                  new EdgeInsets.symmetric(
                                                      vertical:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.022,
                                                      horizontal: 15.0),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25)),
                                              ),
                                            ),
                                            onFieldSubmitted: (String value) {
                                              FocusScope.of(context)
                                                  .requestFocus(focusNode3);
                                            },
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            validator: validateSamePassword,
                                            onSaved: (String val) {
                                              _password = val;
                                            },
                                            focusNode: focusNode3,
                                            obscureText: true,
                                            keyboardType: TextInputType.text,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                            textInputAction:
                                                TextInputAction.done,
                                            decoration: InputDecoration(
                                              labelText: "Confirmar contraseña",
                                              contentPadding:
                                                  new EdgeInsets.symmetric(
                                                      vertical:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.022,
                                                      horizontal: 15.0),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            child: GestureDetector(
                                                onTap: () {
                                                  print("pressed");
                                                  _validateInputs();
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.065,
                                                  decoration: BoxDecoration(
                                                      color: Colors
                                                          .deepPurpleAccent,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  25))),
                                                  child: Center(
                                                    child: Text(
                                                      "Cambiar contraseña",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                buttons: []).show();
                            //open change password
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Configuración de notificaciones",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: morado,
                    ),
                  ),
                  SwitchListTile(
                    activeColor: morado,
                    contentPadding: const EdgeInsets.all(0),
                    value: oneNotification,
                    title: Text("Recordatorio de prueba ViH"),
                    onChanged: (bool oneNotification) {
                      activarNotificaciones(oneNotification);
                    },
                  ),
                  const SizedBox(height: 60.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }

  String validatePassword(String value) {
    if (value.length < 6)
      return 'El password debe tener un mínimo de 6 caracteres';
    else
      _password = value;
    return null;
  }

  String validateSamePassword(String value) {
    if (_password != value) {
      return "Las contraseñas no coinciden";
    } else {
      return null;
    }
  }

  bool _value1 = false;
  bool _autoValidate = false;

  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      ApiService().updatePassword(_password).then((response) {
        if (response) {
          Navigator.pop(context);
          return Alert(
            context: context,
            type: AlertType.success,
            title: "Se ha actualizado exitósamente su contraseña",
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
        } else {
          Navigator.pop(context);
          return Alert(
            context: context,
            type: AlertType.warning,
            title: "Error al Actualizar su contraseña",
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
      });
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
