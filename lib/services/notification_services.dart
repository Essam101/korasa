import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop/core/cloud_messaging.dart';
import 'package:shop/core/instances.dart';
import 'package:shop/models/notificationModels/notificationModel.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  Instances _instances = new Instances();

  subscribeToTopic({required String topicName}) async {
    await _instances.messaging.subscribeToTopic(topicName);
  }

  unsubscribeFromTopic({required String topicName}) async {
    await _instances.messaging.unsubscribeFromTopic(topicName);
  }

  Future<void> sendPushNotification() async {
    try {
      await subscribeToTopic(topicName: "test");
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "to": "/topics",
            'data': {
              'via': 'FlutterFire Cloud Messaging!!!',
            },
            "priority": "high",
            'notification': {
              'title': 'Hello FlutterFire!',
              'body': 'This notification   was created via FCM!',
            },
          }));
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  getInitialMessage({required Function action}) {
    _instances.messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        action();
      }
    });
  }

  onMessage({required Function action}) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      new CloudMessaging().showNotification(remoteMessage: message);
      action();
    });
  }

  onMessageOpenedApp({required Function action}) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      action();
    });
  }
}
