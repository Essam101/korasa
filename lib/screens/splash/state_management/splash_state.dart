import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/screens/complete_store/complete_store_screen.dart';
import 'package:shop/screens/complete_store/state_management/complete_store_state.dart';
import 'package:shop/screens/home/home_screen.dart';
import 'package:shop/screens/sign_in/sign_in_screen.dart';
import 'package:shop/screens/sign_in/state_management/sign_in_state.dart';
import 'package:shop/screens/splash/splash_screen.dart';

class SplashState {
  navigateTo({required BuildContext context}) async {
    bool isLoggedIn = new SignInState().getIsLoggedIn();
    bool isUserHasStore = await new CompleteStoreState().isUserHasStore();
    await Provider.of<SignInState>(context, listen: false).getLoggedInUser();
    if (isLoggedIn && isUserHasStore) {
      Navigator.pushNamed(context, HomeScreen.routeName);
    } else if (isLoggedIn && !isUserHasStore) {
      Navigator.pushNamed(context, CompleteStoreScreen.routeName);
    }
  }
}
