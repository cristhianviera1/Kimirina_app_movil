import 'package:flutter/material.dart';
import 'package:kimirina_app/navBar/navBar.dart';
import 'package:kimirina_app/routes/routes.dart';
import 'package:kimirina_app/screens/agencies/mapasPrueba.dart';
import 'package:kimirina_app/screens/agencies/test.dart';
//import 'package:kimirina_app/screens/agencies/agencias_page.dart';
import 'package:kimirina_app/screens/carrusel/carrusel_page.dart';
import 'package:kimirina_app/screens/chat/chat_details_page.dart';
import 'package:kimirina_app/screens/chat/chat_page.dart';
import 'package:kimirina_app/screens/login/login_page.dart';
import 'package:kimirina_app/screens/login/register_page.dart';
import 'package:kimirina_app/screens/product/product_details.dart';
import 'package:kimirina_app/screens/product/produt_page.dart';
import 'package:kimirina_app/screens/profile/form_page.dart';
import 'package:kimirina_app/screens/profile/settings_page.dart';
import 'package:kimirina_app/screens/treatment/not_treatment.dart';
import 'package:kimirina_app/screens/vih/vih_question_page.dart';

import '../screens/treatment/yes_treatment.dart';

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
    case yesTreatmentViewRoute:
      return MaterialPageRoute(builder: (context) => YesTreatment());
    case noTreatmentViewRoute:
      return MaterialPageRoute(builder: (context) => NoTreatment());
    case chatListViewRoute:
      return MaterialPageRoute(builder: (context) => ChatList());
    case agenciasViewRoute:
      return MaterialPageRoute(builder: (context) => AgenciesScreen());
      case mapsViewRoute:
      return MaterialPageRoute(builder: (context) => MapsScreen());
    case settingsViewRoute:
      return MaterialPageRoute(builder: (context) => SettingsOnePage());
    case formViewRoute:
      return MaterialPageRoute(builder: (context) => FormPage());
    case productsViewRoute:
      return MaterialPageRoute(builder: (context) => ProductScreen());
    case vihQuestionViewRoute:
      return MaterialPageRoute(builder: (context) => ViHQuestionPage());
      break;
    default:
      return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}
