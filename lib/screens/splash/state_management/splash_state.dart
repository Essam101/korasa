import 'package:flutter/material.dart';
import 'package:shop/screens/complete_store/complete_store_screen.dart';
import 'package:shop/screens/navigation/navigation_screen.dart';
import 'package:shop/screens/sign_in/sign_in_screen.dart';
import 'package:shop/services/service_base.dart';

class SplashState extends ServiceBase {
  navigateTo({required BuildContext context}) async {
    bool isLoggedIn = currantUser != null;
    bool isUserHasStore = storeId.isNotEmpty;
    if (isLoggedIn && isUserHasStore) {
      Navigator.pushReplacementNamed(context, NavigationScreen.routeName);
    } else if (isLoggedIn && !isUserHasStore) {
      Navigator.pushReplacementNamed(context, CompleteStoreScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
    }
  }
}
