import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shop/core/instances.dart';

import '../firebase_options.dart';

class CloudMessaging {
  Instances instances = new Instances();
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
  );

  showNotification({required RemoteMessage remoteMessage}) {
    RemoteNotification? notification = remoteMessage.notification;
    new FlutterLocalNotificationsPlugin().show(
      notification.hashCode,
      notification?.title,
      notification?.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          icon: 'launch_background',
        ),
      ),
    );
  }

// for only ios and web
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

  Map<String, String> header() {
    var _header = {
      "Host": "fcm.googleapis.com",
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization":
          "key=AAAAxxGRMUw:APA91bEM4xFB7b--K3ckH0aook-QtX-5o8X6rC-YVAAfvQSJrOwRZ0eoO8kQSTQXzVxlt7eNCjvcR2mahKZiLIeZGE6-VeUP4yL7xSmccw5ScP4ArqRmgFgcr_JUvzW_uMEDlHryE6i8",
    };
    return _header;
  }
}
