import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kimirina_app/screens/chat/chat_page.dart';
import 'package:kimirina_app/screens/news/news_page.dart';
import 'package:kimirina_app/screens/product/produt_page.dart';
import 'package:kimirina_app/screens/vih/vih_question_page.dart';
import 'dart:async';

import 'package:kimirina_app/screens/profile/profile_page.dart';

class NavBar extends StatefulWidget {
  static final String path = "lib/src/pages/misc/navybar.dart";
  @override
  _NavBar createState() => _NavBar();
}


class _NavBar extends State<NavBar> {
  @override
  void dispose() {
    indexcontroller.close();
    super.dispose();
  }
  PageController pageController = PageController(initialPage: 0);
  StreamController<int> indexcontroller = StreamController<int>.broadcast();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: ChatScreen(),            
          ),
          Center(
            child: ProfileScreen()
          ),
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
                    icon: Icon(FontAwesomeIcons.kaggle), title: Text('Kimirina')),
                FancyBottomNavigationItem(
                    icon: Icon(FontAwesomeIcons.newspaper), title: Text('Noticias')),
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
    colors(){
      if(_selectedIndex == 0){
        activeColor = Color.fromRGBO(240, 53, 6, 1);
      }else if(_selectedIndex == 1){
        activeColor = Color.fromRGBO(45, 40, 124, 1);
      }else if(_selectedIndex == 2){
        activeColor = Color.fromRGBO(26, 134, 61, 1);
      }else if(_selectedIndex == 3){
        activeColor = Color.fromRGBO(111, 0, 92, 1);
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

