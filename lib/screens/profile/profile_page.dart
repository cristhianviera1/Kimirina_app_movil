import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kimirina_app/models/user_model.dart';
import 'package:kimirina_app/routes/routes.dart';
import 'package:kimirina_app/services/user_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Usuario {
  
  final User infoOfToken = ApiService().currentUser;

}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, .9),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 330,
                    color: Colors.teal,
                  ),
                  Positioned(
                    top: 10,
                    right: 30,
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                          height: 100,
                          margin: EdgeInsets.only(top: 60),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                'https://ktusu.com/admin/uploads/slider/836295524.jpg'),
                          )),
                      Padding(
                        padding: EdgeInsets.all(4),
                      ),
                      Text(
                        "_nombre",
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
                          subtitle: Text("_provincia"),
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
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                                buttons: [
                                ]).show();
                          }),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text("Correo"),
                        subtitle: Text("_correo"),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text("Phone"),
                        subtitle: Text(""),
                      ),
                      ListTile(
                        leading: Icon(FontAwesomeIcons.powerOff),
                        title: Text("Cerrar Sesión"),
                        onTap: () async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString("token", null);
                          Navigator.of(context).pushNamed(loginViewRoute);
                        },
                      ),
                      ListTile(
                        leading: Icon(FontAwesomeIcons.kaggle,color: Color.fromRGBO(240, 53, 6, 1)),
                        title: Text("¿Nos ayudas con más información?"),
                        subtitle: Text("Así podemos crear planes de prevención y campañas de tratamiento"),
                        onTap: (){
                          Navigator.of(context).pushNamed("routeName");
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
