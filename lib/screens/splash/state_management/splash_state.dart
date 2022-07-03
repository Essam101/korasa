import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/screens/complete_store/complete_store_screen.dart';
import 'package:shop/screens/complete_store/state_management/complete_store_state.dart';
import 'package:shop/screens/navigation/navigation_screen.dart';
import 'package:shop/screens/sign_in/state_management/sign_in_state.dart';
import 'package:shop/services/service_base.dart';
import 'package:shop/services/users/user_local.dart';

class SplashState extends ServiceBase {
  navigateTo({required BuildContext context}) async {
    // await setCurrentUser();
    bool isLoggedIn = currantUser != null;
    bool isUserHasStore = storeId.isNotEmpty;
    if (isLoggedIn && isUserHasStore) {
      Navigator.pushReplacementNamed(context, NavigationScreen.routeName);
    } else if (isLoggedIn && !isUserHasStore) {
      Navigator.pushReplacementNamed(context, CompleteStoreScreen.routeName);
    }
  }
}
