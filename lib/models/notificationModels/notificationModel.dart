// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

class NotificationModel {
  NotificationModel({
    required this.topic,
    required this.data,
    required this.notification,
  });

  String topic;
  Data data;
  Notifiy notification;

  factory NotificationModel.fromRawJson(String str) => NotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        topic: json["topic"],
        data: Data.fromJson(json["data"]),
        notification: Notifiy.fromJson(json["notification"]),
      );

  Map<String, dynamic> toJson() => {
        "topic": topic,
        "data": data.toJson(),
        "notification": notification.toJson(),
      };
}

class Data {
  Data({
    required this.via,
    required this.count,
  });

  String via;
  String count;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        via: json["via"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "via": via,
        "count": count,
      };
}

class Notifiy {
  Notifiy({
    required this.title,
    required this.body,
  });

  String title;
  String body;

  factory Notifiy.fromRawJson(String str) => Notifiy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Notifiy.fromJson(Map<String, dynamic> json) => Notifiy(
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
      };
}
