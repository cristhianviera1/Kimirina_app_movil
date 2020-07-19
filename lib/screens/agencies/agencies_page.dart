import 'package:flutter/material.dart';
import 'package:kimirina_app/screens/agencies/listAgencies.dart';
import 'package:kimirina_app/shared/colors.dart';
import 'package:kimirina_app/utils/googleMap.dart';

class AgenciesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final agencies = agenciesList
        .map<Card>((agency) => Card(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 5.0, left: 6.0, right: 6.0, bottom: 0.0),
                child: ExpansionTile(
                  title: Text(
                    agency.city,
                    style: styleTextQuestions,
                  ),
                  children: <Widget>[
                    Image.asset(agency.imageAsset),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: agency.services.map<Text>((service)=>
                          Text(service)
                      ).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FloatingActionButton(
                            heroTag: "btn",
                            backgroundColor: azul,
                            child: const Icon(Icons.map),
                            onPressed: () {
                              MapUtils.openMap(agency.lat, agency.lng);

                            }),
                        SizedBox(height: 30)
                      ],
                    ),
                  ],
                ),
              ),
            ))
        .toList();

    final double infoHeight = 364.0;
    final _card0 = Container(
      decoration: BoxDecoration(
        color: nearlyWhite,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: grey.withOpacity(0.2),
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
                  height: 11,
                ),
                ...agencies
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
