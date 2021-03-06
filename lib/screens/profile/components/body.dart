import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/screens/profile/state_management/profile_state.dart';
import 'package:shop/screens/store_employees/store_staff_screen.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Store Employees",
            icon: "assets/icons/User Icon.svg",
            press: () => {Navigator.pushNamed(context, StoreEmployeesScreen.routeName)},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              Provider.of<ProfileState>(context, listen: false).logOut(context: context);
            },
          ),
        ],
      ),
    );
  }
}
