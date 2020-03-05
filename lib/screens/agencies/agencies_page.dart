import 'package:flutter/material.dart';
import 'package:kimirina_app/colors/colors.dart';
import 'package:kimirina_app/utils/googleMap.dart';

import 'design_course_app_theme.dart';
import 'mapasPrueba.dart';

class AgenciesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _card1 = Card(
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, left: 6.0, right: 6.0, bottom: 0.0),
        child: ExpansionTile(
          title: Text(
            'Quito',
            style: styleTextQuestions,
          ),
          children: <Widget>[
            Image.asset("assets/images/agencia.png"),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' - Asesoría en Prevención de VIH e ITS',
                  textAlign: TextAlign.left,
                ),
                Text(' - Pruebas Rápidas VIH'),
                Text(' - Pruebas para ITS'),
                Text(' - Asesoria, vinculación a tratamiento VIH'),
                Text(' - Tratamiento ITS'),
                Text(' - PREP'),
                Text(' - Condones'),
                Text(' - Lubricantes'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                    heroTag: "btn",
                    backgroundColor: azul,
                    child: const Icon(Icons.map),
                    onPressed: () {
                      MapUtils.openMap(-0.205294, -78.488857);
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MapsScreen(
                                  agencieCity: "Quito",
                                  lat: -0.205294,
                                  lng: -78.488857)));*/
                      //Navigator.of(context).pushNamed(mapsViewRoute);
                    }),
                SizedBox(height: 30)
              ],
            ),
          ],
        ),
      ),
    );
    final _card2 = Card(
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, left: 6.0, right: 6.0, bottom: 0.0),
        child: ExpansionTile(
          title: Text(
            'Guayaquil',
            style: styleTextQuestions,
          ),
          children: <Widget>[
            Image.asset("assets/images/agencia.png"),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' - Asesoría en Prevención de VIH e ITS',
                  textAlign: TextAlign.left,
                ),
                Text(' - Pruebas Rápidas VIH'),
                Text(' - Pruebas para ITS'),
                Text(' - Asesoria, vinculación a tratamiento VIH'),
                Text(' - Tratamiento ITS'),
                Text(' - PREP'),
                Text(' - Condones'),
                Text(' - Lubricantes'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                    heroTag: "btn1",
                    backgroundColor: azul,
                    child: const Icon(Icons.map),
                    onPressed: () {
                      MapUtils.openMap(-2.191523, -79.883687);
                     /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MapsScreen(
                                  agencieCity: "Guayaquil",
                                  lat: -2.191523,
                                  lng: -79.883687)));
                      //Navigator.of(context).pushNamed(mapsViewRoute);*/
                    })
              ],
            ),
          ],
        ),
      ),
    );
    final _card3 = Card(
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, left: 6.0, right: 6.0, bottom: 0.0),
        child: ExpansionTile(
          title: Text(
            'Machala',
            style: styleTextQuestions,
          ),
          initiallyExpanded: false,
          children: <Widget>[
            Image.asset("assets/images/agencia.png"),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' - Asesoría en Prevención de VIH e ITS',
                  textAlign: TextAlign.left,
                ),
                Text(' - Pruebas Rápidas VIH'),
                Text(' - Pruebas para ITS'),
                Text(' - Asesoria, vinculación a tratamiento VIH'),
                Text(' - Tratamiento ITS'),
                Text(' - PREP'),
                Text(' - Condones'),
                Text(' - Lubricantes'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                    heroTag: "btn2",
                    backgroundColor: azul,
                    child: const Icon(Icons.map),
                    onPressed: () {
                      MapUtils.openMap(-3.260251, -79.957012);
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MapsScreen(
                                  agencieCity: " Machala",
                                  lat: -3.260251,
                                  lng: -79.957012)));
                      //Navigator.of(context).pushNamed(mapsViewRoute);*/
                    })
              ],
            ),
          ],
        ),
      ),
    );
    final _card4 = Card(
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, left: 6.0, right: 6.0, bottom: 0.0),
        child: ExpansionTile(
          title: Text(
            'Esmeraldas',
            style: styleTextQuestions,
          ),
          children: <Widget>[
            Image.asset("assets/images/agencia.png"),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' - Asesoría en Prevención de VIH e ITS',
                  textAlign: TextAlign.left,
                ),
                Text(' - Pruebas Rápidas VIH'),
                Text(' - Pruebas para ITS'),
                Text(' - Asesoria, vinculación a tratamiento VIH'),
                Text(' - Tratamiento ITS'),
                Text(' - PREP'),
                Text(' - Condones'),
                Text(' - Lubricantes'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                    heroTag: "btn3",
                    backgroundColor: azul,
                    child: const Icon(Icons.map),
                    onPressed: () {
                      MapUtils.openMap(-2.191523, -79.883687);
                     /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MapsScreen(
                                  agencieCity: " Esmeraldas",
                                  lat: -3.260251,
                                  lng: -79.957012)));
                      //Navigator.of(context).pushNamed(mapsViewRoute);*/
                    })
              ],
            ),
          ],
        ),
      ),
    );
    final _card5 = Card(
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, left: 6.0, right: 6.0, bottom: 0.0),
        child: ExpansionTile(
          title: Text(
            'Portoviejo',
            style: styleTextQuestions,
          ),
          children: <Widget>[
            Image.asset("assets/images/agencia.png"),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' - Asesoría en Prevención de VIH e ITS',
                  textAlign: TextAlign.left,
                ),
                Text(' - Pruebas Rápidas VIH'),
                Text(' - Pruebas para ITS'),
                Text(' - Asesoria, vinculación a tratamiento VIH'),
                Text(' - Tratamiento ITS'),
                Text(' - PREP'),
                Text(' - Condones'),
                Text(' - Lubricantes'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                    heroTag: "btn4",
                    backgroundColor: azul,
                    child: const Icon(Icons.map),
                    onPressed: () {
                       MapUtils.openMap(-2.191523, -79.883687);
                     /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MapsScreen(
                                  agencieCity: " Portoviejo",
                                  lat: -3.260251,
                                  lng: -79.957012)));
                      //Navigator.of(context).pushNamed(mapsViewRoute);*/
                    })
              ],
            ),
          ],
        ),
      ),
    );
    final _card6 = Card(
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, left: 6.0, right: 6.0, bottom: 0.0),
        child: ExpansionTile(
          title: Text(
            'Santo Domingo',
            style: styleTextQuestions,
          ),
          children: <Widget>[
            Image.asset("assets/images/agencia.png"),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' - Asesoría en Prevención de VIH e ITS',
                  textAlign: TextAlign.left,
                ),
                Text(' - Pruebas Rápidas VIH'),
                Text(' - Pruebas para ITS'),
                Text(' - Asesoria, vinculación a tratamiento VIH'),
                Text(' - Tratamiento ITS'),
                Text(' - PREP'),
                Text(' - Condones'),
                Text(' - Lubricantes'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                    heroTag: "btn5",
                    backgroundColor: azul,
                    child: const Icon(Icons.map),
                    onPressed: () {
                       MapUtils.openMap(-2.191523, -79.883687);
                     /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MapsScreen(
                                  agencieCity: " Santo Domingo",
                                  lat: -3.260251,
                                  lng: -79.957012)));
                      //Navigator.of(context).pushNamed(mapsViewRoute);*/
                    })
              ],
            ),
          ],
        ),
      ),
    );
    final _card7 = Card(
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, left: 6.0, right: 6.0, bottom: 0.0),
        child: ExpansionTile(
          title: Text(
            'Santa Elena',
            style: styleTextQuestions,
          ),
          children: <Widget>[
            Image.asset("assets/images/agencia.png"),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' - Asesoría en Prevención de VIH e ITS',
                  textAlign: TextAlign.left,
                ),
                Text(' - Pruebas Rápidas VIH'),
                Text(' - Pruebas para ITS'),
                Text(' - Asesoria, vinculación a tratamiento VIH'),
                Text(' - Tratamiento ITS'),
                Text(' - PREP'),
                Text(' - Condones'),
                Text(' - Lubricantes'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                    heroTag: "btn6",
                    backgroundColor: azul,
                    child: const Icon(Icons.map),
                    onPressed: () {
                       MapUtils.openMap(-2.191523, -79.883687);
                     /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MapsScreen(
                                  agencieCity: " Santa Elena",
                                  lat: -3.260251,
                                  lng: -79.957012)));
                      //Navigator.of(context).pushNamed(mapsViewRoute);*/
                    })
              ],
            ),
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
                  title: Text("Centros Comunitarios"),
                  centerTitle: true,
                  backgroundColor: azul,
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
