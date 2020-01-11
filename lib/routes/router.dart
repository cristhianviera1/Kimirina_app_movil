import 'package:flutter/material.dart';
import 'package:kimirina_app/routes/routes.dart';
import 'package:kimirina_app/screens/login/login_page.dart';
import 'package:kimirina_app/screens/registro/registro_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case landingViewRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case loginViewRoute:
     return MaterialPageRoute(builder: (context) => LoginPage());
    case registerViewRoute:
     return MaterialPageRoute(builder: (context) => RegisterPage());
    break;
    default:
     return MaterialPageRoute(builder: (context) => LoginPage());
  }
}