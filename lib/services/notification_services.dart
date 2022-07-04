import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop/core/instances.dart';

class NotificationServices {
  subscribeToTopic({required String topicName}) async {
    await new Instances().messaging.subscribeToTopic(topicName);
  }

  unsubscribeFromTopic({required String topicName}) async {
    await new Instances().messaging.unsubscribeFromTopic(topicName);
  }

  Future<void> sendPushNotification({
    required topicName,
  }) async {
    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'topic': "",
          'data': {
            'via': 'FlutterFire Cloud Messaging!!!',
            'count': "1",
          },
          'notification': {
            'title': 'Hello FlutterFire!',
            'body': 'This notification  was created via FCM!',
          },
        }),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }
}
