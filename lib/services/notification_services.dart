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
  CloudMessaging cloudMessaging = new CloudMessaging();

  subscribeToTopic({required String topicName}) async {
    await _instances.messaging.subscribeToTopic(topicName);
  }

  unsubscribeFromTopic({required String topicName}) async {
    await _instances.messaging.unsubscribeFromTopic(topicName);
  }

  Future<void> sendPushNotification() async {
    var data = jsonEncode({
      "notification": {"body": "This week's edition is now available.", "title": "NewsMagazine.com"},
      "priority": "normal",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "contents": "http://www.news-magazine.com/world-week/21659772",
        "status": "done"
      },
      "to": "/topics/test"
    });
    try {
      await subscribeToTopic(topicName: "test");
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            "Host": "fcm.googleapis.com",
            "Content-Type": "application/json; charset=UTF-8",
            "Content-Length": data.length.toString(),
            "Authorization":
                "key=AAAAxxGRMUw:APA91bEM4xFB7b--K3ckH0aook-QtX-5o8X6rC-YVAAfvQSJrOwRZ0eoO8kQSTQXzVxlt7eNCjvcR2mahKZiLIeZGE6-VeUP4yL7xSmccw5ScP4ArqRmgFgcr_JUvzW_uMEDlHryE6i8",
          },
          body: data);
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
      cloudMessaging.showNotification(remoteMessage: message);
      action();
    });
  }

  onMessageOpenedApp({required Function action}) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      action();
    });
  }
}
