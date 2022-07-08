import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:shop/core/cloud_messaging.dart';
import 'package:shop/core/instances.dart';

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
    await _instances.messaging.subscribeToTopic('test');

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
      await http
          .post(Uri.parse('https://fcm.googleapis.com/fcm/send'), headers: cloudMessaging.header(), body: data)
          .then((value) => {print(jsonEncode(value.body))});
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
