import 'dart:async';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/darkTheme.dart';
import 'package:shop/core/routes.dart';
import 'package:shop/core/theme.dart';
import 'package:shop/screens/splash/splash_screen.dart';
import 'package:shop/services/services.dart';

import 'core/esayLoadingConfig.dart';
import 'firebase_options.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    await GetStorage.init();
    runApp(EasyDynamicThemeWidget(
      child: MyApp(),
    ));
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
  new EasyLoadingConfig().configLoading();
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
        darkTheme: darkThem(),
        themeMode: EasyDynamicTheme.of(context).themeMode,
        initialRoute: SplashScreen.routeName,
        routes: routes,
        builder: EasyLoading.init(),
      ),
    );
  }
}
