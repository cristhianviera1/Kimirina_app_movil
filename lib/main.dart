import 'package:flutter/material.dart';
import 'package:kimirina_app/services/user_service.dart';
import 'package:provider/provider.dart';
import 'routes/router.dart' as router;
import 'routes/routes.dart';
void main() =>runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ApiService(),
      child: MaterialApp(
        title: 'Flutter Kimirina',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generateRoute,
        initialRoute: carruselViewRoute,
      ),
    );
  }
}
