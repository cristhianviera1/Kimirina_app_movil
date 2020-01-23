import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kimirina_app/colors/colors.dart';
import 'package:kimirina_app/screens/chat/chat_page.dart';
import 'package:kimirina_app/screens/news/news_page.dart';
import 'package:kimirina_app/screens/product/produt_page.dart';
import 'dart:async';

import 'package:kimirina_app/screens/profile/profile_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/routes.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBar createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  @override
  void dispose() {
    indexcontroller.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  PageController pageController = PageController(initialPage: 0);
  StreamController<int> indexcontroller = StreamController<int>.broadcast();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var tempAnswer = prefs.getBool("ViHAnswer") ?? false;
      if (!tempAnswer) {
        return showQuestionViH(context);
      }
    });
    return Scaffold(
      key: myGlobals.scaffoldKey,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          indexcontroller.add(index);
        },
        controller: pageController,
        children: <Widget>[
          Center(
            child: ProductScreen(),
          ),
          Center(
            child: NewsScreen(),
          ),
          Center(
            child: ChatList(),
          ),
          Center(child: ProfileScreen()),
        ],
      ),
      bottomNavigationBar: StreamBuilder<Object>(
          initialData: 0,
          stream: indexcontroller.stream,
          builder: (context, snapshot) {
            int cIndex = snapshot.data;
            return FancyBottomNavigation(
              currentIndex: cIndex,
              items: <FancyBottomNavigationItem>[
                FancyBottomNavigationItem(
                    icon: Icon(FontAwesomeIcons.kaggle),
                    title: Text('Kimirina')),
                FancyBottomNavigationItem(
                    icon: Icon(FontAwesomeIcons.newspaper),
                    title: Text('Noticias')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.message), title: Text('Chat')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.person), title: Text('Perfil')),
              ],
              onItemSelected: (int value) {
                indexcontroller.add(value);
                pageController.jumpToPage(value);
              },
            );
          }),
    );
  }
}

class FancyBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final double iconSize;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final List<FancyBottomNavigationItem> items;
  final ValueChanged<int> onItemSelected;

  FancyBottomNavigation(
      {Key key,
      this.currentIndex = 0,
      this.iconSize = 24,
      this.activeColor,
      this.inactiveColor,
      this.backgroundColor,
      @required this.items,
      @required this.onItemSelected}) {
    assert(items != null);
    assert(onItemSelected != null);
  }

  @override
  _FancyBottomNavigationState createState() {
    return _FancyBottomNavigationState(
        items: items,
        backgroundColor: backgroundColor,
        currentIndex: currentIndex,
        iconSize: iconSize,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        onItemSelected: onItemSelected);
  }
}

class _FancyBottomNavigationState extends State<FancyBottomNavigation> {
  final int currentIndex;
  final double iconSize;
  Color activeColor;
  Color inactiveColor;
  Color backgroundColor;
  List<FancyBottomNavigationItem> items;
  int _selectedIndex;
  ValueChanged<int> onItemSelected;

  _FancyBottomNavigationState(
      {@required this.items,
      this.currentIndex,
      this.activeColor,
      this.inactiveColor = Colors.black,
      this.backgroundColor,
      this.iconSize,
      @required this.onItemSelected}) {
    _selectedIndex = currentIndex;
  }
  var itemsNav = [];
  Widget _buildItem(FancyBottomNavigationItem item, bool isSelected) {
    colors() {
      if (_selectedIndex == 0) {
        activeColor = naranja;
      } else if (_selectedIndex == 1) {
        activeColor = verde;
      } else if (_selectedIndex == 2) {
        activeColor = azul;
      } else if (_selectedIndex == 3) {
        activeColor = morado;
      }
    }

    colors();
    return AnimatedContainer(
      width: isSelected ? 124 : 50,
      height: double.maxFinite,
      duration: Duration(milliseconds: 250),
      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              color: activeColor,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconTheme(
                  data: IconThemeData(
                      size: iconSize,
                      color: isSelected ? backgroundColor : inactiveColor),
                  child: item.icon,
                ),
              ),
              isSelected
                  ? DefaultTextStyle.merge(
                      style: TextStyle(color: backgroundColor),
                      child: item.title,
                    )
                  : SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    activeColor =
        (activeColor == null) ? Theme.of(context).accentColor : activeColor;

    backgroundColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 56,
        padding: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
        decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.map((item) {
            var index = items.indexOf(item);
            return GestureDetector(
              onTap: () {
                onItemSelected(index);

                setState(() {
                  _selectedIndex = index;
                });
              },
              child: _buildItem(item, _selectedIndex == index),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class FancyBottomNavigationItem {
  final Icon icon;
  final Text title;

  FancyBottomNavigationItem({
    @required this.icon,
    @required this.title,
  }) {
    assert(icon != null);
    assert(title != null);
  }
}

//Se pregunta si la persona tiene ViH
Future<void> showQuestionViH(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("ViHAnswer",true);
  Alert(
    context: context,
    image: Image.asset("assets/gif/kimirina_logo.gif"),
    title: "¿Tienes ViH?",
    desc: "Sabías que hoy en día existen pruebas rápidas y fiables",
    buttons: [
      DialogButton(
          color: secondaryColor,
          radius: BorderRadius.circular(18.0),
          child: Text(
            "SI",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: (){
              prefs.setBool("UserViH", true);
              Navigator.pop(myGlobals.scaffoldKey.currentContext);
              yesAlert(myGlobals.scaffoldKey.currentContext);
          }),
      DialogButton(
          color: tertyaryColor,
          radius: BorderRadius.circular(18.0),
          child: Text(
            "NO",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool("ViHAnswer", true);
              //Se guarda si el usuario tiene o no ViH
              prefs.setBool("UserViH", false);
              Navigator.pop(context);
              noAlert(myGlobals.scaffoldKey.currentContext);
          }),
    ],
  ).show();
}

Future<Alert> noAlert(BuildContext context) {
  Alert(
    context: context,
    image: Image.asset("assets/images/questionBlue.png"),
    title: "¿Estas seguro?",
    desc: "Toma una buena decisión",
    buttons: [
      DialogButton(
          color: secondaryColor,
          child: Text(
            "¡Hazte la prueba!",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).pushNamed(agenciasViewRoute);
          })
    ],
  ).show();
}

Future<Alert> yesAlert(BuildContext contextYes) {
  Alert(
    context: contextYes,
    image: Image.asset("assets/images/questions.png"),
    title: "¿Cómo esta tu tratamiento?",
    desc:
        "Es muy importante seguir el tratamiento antirretroviral y tomar los medicamentos diariamente",
    content: Column(
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        DialogButton(
          child: Text(
            "Lo he abandonado",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          color: primaryColor,
          onPressed: () =>
              Navigator.of(contextYes).pushNamed(noTreatmentViewRoute),
        ),
        SizedBox(
          height: 15,
        ),
        DialogButton(
          child: Text(
            "No estoy en tratamiento",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          color: secondaryColor,
          onPressed: () =>
              Navigator.of(contextYes).pushNamed(noTreatmentViewRoute),
        ),
        SizedBox(
          height: 15,
        ),
        DialogButton(
          child: Text(
            "Todo en orden",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          color: tertyaryColor,
          onPressed: () {
            Navigator.pop(contextYes);
            Navigator.of(contextYes).pushNamed(yesTreatmentViewRoute);
          }           
        )
      ],
    ),
    buttons: [],
  ).show();
}

//Se define una variable global para tener el contexto inicial de la clase
final MyGlobals myGlobals = new MyGlobals();

class MyGlobals {
  GlobalKey _scaffoldKey;
  MyGlobals() {
    _scaffoldKey = GlobalKey();
  }
  GlobalKey get scaffoldKey => _scaffoldKey;
}
