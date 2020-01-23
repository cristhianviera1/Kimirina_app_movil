import 'package:flutter/material.dart';
import 'package:kimirina_app/colors/colors.dart';

import 'design_course_app_theme.dart';

class AgenciesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _card1 = Card(
      child: Padding(
        padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: Text(
            'Quito',
            style: styleTextQuestions,
          ),
          children: <Widget>[
            Image.asset("assets/images/mapKimirina.png"),
            SizedBox(height: 10),
            Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.'),
          ],
        ),
      ),
    );
    final _card2 = Card(
      child: Padding(
        padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: Text(
            'Guayaquil',
            style: styleTextQuestions,
          ),
          children: <Widget>[
            Image.asset("assets/images/mapKimirina.png"),
            SizedBox(height: 10),
            Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.'),
          ],
        ),
      ),
    );
    final _card3 = Card(
      child: Padding(
        padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: Text(
            'Machala',
            style: styleTextQuestions,
          ),
          initiallyExpanded: false,
          children: <Widget>[
            Image.asset("assets/images/mapKimirina.png"),
            SizedBox(height: 10),
            Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.'),
          ],
        ),
      ),
    );
    final _card4 = Card(
      child: Padding(
        padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: Text(
            'Esmeraldas',
            style: styleTextQuestions,
          ),
          children: <Widget>[
            Image.asset("assets/images/mapKimirina.png"),
            SizedBox(height: 10),
            Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.'),
          ],
        ),
      ),
    );
    final _card5 = Card(
      child: Padding(
        padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: Text(
            'Portoviejo',
            style: styleTextQuestions,
          ),
          children: <Widget>[
            Image.asset("assets/images/mapKimirina.png"),
            SizedBox(height: 10),
            Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.'),
          ],
        ),
      ),
    );
    final _card6 = Card(
      child: Padding(
        padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: Text(
            'Santo Domingo',
            style: styleTextQuestions,
          ),
          children: <Widget>[
            Image.asset("assets/images/mapKimirina.png"),
            SizedBox(height: 10),
            Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.'),
          ],
        ),
      ),
    );
    final _card7 = Card(
      child: Padding(
        padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: Text(
            'Santa Elena',
            style: styleTextQuestions,
          ),
          children: <Widget>[
            Image.asset("assets/images/mapKimirina.png"),
            SizedBox(height: 10),
            Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.'),
          ],
        ),
      ),
    );
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    final double infoHeight = 364.0;
    final _card0 = Container(
      decoration: BoxDecoration(
        color: DesignCourseAppTheme.nearlyWhite,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: DesignCourseAppTheme.grey.withOpacity(0.2),
              offset: const Offset(1.1, 1.1),
              blurRadius: 20.0),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
                minHeight: infoHeight, maxHeight: double.infinity),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                _card1,
                _card2,
                _card3,
                _card4,
                _card5,
                _card6,
                _card7
              ],
            ),
          ),
        ),
      ),
    );
    final List<Widget> _listOfAgencies = [
      _card0,
    ];
    return SafeArea(
      child: Material(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MySliverAppBar(expandedHeight: 300),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(_listOfAgencies),
            )
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image.asset('assets/images/address.png'),
        Center(
          child: Opacity(
              opacity: shrinkOffset / expandedHeight,
              child: Container(
                child: AppBar(
                  title: Text("Nuestras Agencias"),
                  centerTitle: true,
                  backgroundColor: naranja,
                ),
              )),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
