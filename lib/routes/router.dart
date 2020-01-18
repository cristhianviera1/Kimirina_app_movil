import 'package:flutter/material.dart';
import 'package:kimirina_app/navBar/navBar.dart';
import 'package:kimirina_app/routes/routes.dart';
import 'package:kimirina_app/screens/carrusel/carrusel_page.dart';
import 'package:kimirina_app/screens/chat/chat_details_page.dart';
import 'package:kimirina_app/screens/login/login_page.dart';
import 'package:kimirina_app/screens/login/register_page.dart';
import 'package:kimirina_app/screens/product/product_details.dart';
import 'package:kimirina_app/screens/vih/vih_question_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case carruselViewRoute:
      return MaterialPageRoute(builder: (context) => CarruselPage());
    case loginViewRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case navBarViewRoute:
      return MaterialPageRoute(builder: (context) => NavBar());
    case productDetaisViewRoute:
      return MaterialPageRoute(builder: (context) => ProductDetailsPage());
    case registerViewRoute:
      return MaterialPageRoute(builder: (context) => SignupScreen());
      case chatDetailViewRoute:
      return MaterialPageRoute(builder: (context) => ChatScreen());
    case vihQuestionViewRoute:
      return MaterialPageRoute(builder: (context) => ViHQuestionPage());
      break;
    default:
      return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}
