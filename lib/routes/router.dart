import 'package:flutter/material.dart';
import 'package:kimirina_app/routes/routes.dart';
import 'package:kimirina_app/screens/carrusel/carrusel_page.dart';
import 'package:kimirina_app/screens/login/login_page.dart';
import 'package:kimirina_app/screens/login/register_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case carruselViewRoute:
      return MaterialPageRoute(builder: (context) => CarruselPage());
    case loginViewRoute:
     return MaterialPageRoute(builder: (context) => LoginScreen());
    case registerViewRoute:
     return MaterialPageRoute(builder: (context) => SignupScreen());
    break;
    default:
     return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}