import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/constants.dart';
import 'package:shop/screens/home/home_screen.dart';
import 'package:shop/screens/profile/profile_screen.dart';
import 'package:shop/services/notification_services.dart';

import 'state_management/navigation_state.dart';

class NavigationScreen extends StatefulWidget {
  static String routeName = "/navigation";

  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  void initState() {
    super.initState();
    test();
  }

  test() async {
    NotificationServices notificationServices = new NotificationServices();

    await notificationServices.subscribeToTopic(topicName: 'test');
    notificationServices.getInitialMessage(action: () {
      print("Test getInitialMessage");
    });

    notificationServices.onMessage(action: () {
      print("Test onMessage");
    });
    notificationServices.onMessageOpenedApp(action: () {
      print("Test onMessageOpenedApp");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Provider.of<NavigationState>(context, listen: true).selectedScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Shop Icon.svg",
              color: Provider.of<NavigationState>(context, listen: false).tabColor(0),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/customers.svg",
              color: Provider.of<NavigationState>(context, listen: false).tabColor(1),
              height: 28,
              width: 50,
            ),
            label: 'Customer',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/User Icon.svg",
              color: Provider.of<NavigationState>(context, listen: false).tabColor(2),
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: Provider.of<NavigationState>(context, listen: true).selectedScreenIndex,
        selectedItemColor: kPrimaryColor,
        onTap: Provider.of<NavigationState>(context, listen: false).onItemTapped,
      ),
    );
  }
}
