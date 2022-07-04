import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shop/core/instances.dart';

class CloudMessaging {
  Instances instances = new Instances();

  requestPermission() async {
    NotificationSettings settings = await instances.messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
