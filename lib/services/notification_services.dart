import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop/core/instances.dart';
import 'package:shop/models/notificationModels/notificationModel.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  Instances instances = new Instances();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  String channelId = "Korasa";
  String channelName = "Korasa";
  String channelDescription = "Korasa";

  subscribeToTopic({required String topicName}) async {
    await instances.messaging.subscribeToTopic(topicName);
  }

  unsubscribeFromTopic({required String topicName}) async {
    await instances.messaging.unsubscribeFromTopic(topicName);
  }

  Future<void> sendPushNotification({required NotificationModel notificationModel}) async {
    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: notificationModel.toJson(),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  getInitialMessage({required Function action}) {
    instances.messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        action();
      }
    });
  }

  onMessage({required Function action}) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(channelId, channelName,
                channelDescription: channelDescription, icon: 'launch_background', playSound: true, priority: Priority.high),
          ),
        );
        action();
      }
    });
  }

  onMessageOpenedApp({required Function action}) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      action();
      //   print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(
      //   context,
      //   '/message',
      //   arguments: MessageArguments(message, true),
      // );
    });
  }
}
