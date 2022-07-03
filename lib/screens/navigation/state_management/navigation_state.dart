import 'package:flutter/material.dart';
import 'package:shop/core/constants.dart';
import 'package:shop/screens/customer/customer_screen.dart';
import 'package:shop/screens/home/home_screen.dart';
import 'package:shop/screens/profile/profile_screen.dart';
import 'package:shop/services/service_base.dart';

class NavigationState extends ServiceBase {
  int selectedScreenIndex = 0;
  List<Widget> screens = [HomeScreen(), CustomerScreen(), ProfileScreen()];

  Widget selectedScreen() => screens.elementAt(selectedScreenIndex);

  Color tabColor(index) {
    return index == selectedScreenIndex ? kPrimaryColor : KInActiveIconColor;
  }

  void onItemTapped(int index) {
    selectedScreenIndex = index;
    notifyListeners();
  }
}
