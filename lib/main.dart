import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kimirina_app/services/user_service.dart';
import 'package:provider/provider.dart';
import 'routes/router.dart' as router;
import 'routes/routes.dart';
Future main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ApiService(),
      child: MaterialApp(
        title: 'Kimirina',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generateRoute,
        initialRoute: carouselViewRoute,
      ),
    );
  }
}
