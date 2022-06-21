import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/routes.dart';
import 'package:shop/screens/profile/profile_screen.dart';
import 'package:shop/screens/splash/splash_screen.dart';
import 'package:shop/core/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shop/services/auth_services.dart';
import 'package:shop/services/services.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: new Services(context).providers(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        initialRoute: SplashScreen.routeName,
        routes: routes,
      ),
    );
  }
}
