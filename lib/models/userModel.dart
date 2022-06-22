// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';



List<userModel> userModelFromJson(String str) => List<userModel>.from(json.decode(str).map((x) => userModel.fromJson(x)));

String userModelToJson(List<userModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class userModel {
  userModel({
    required this.id,
    required this.name,
    required this.role,
    required this.storeId,
  });

  late final String id;
  late final String name;
  late final roleType role;
  late final String storeId;

  factory userModel.fromRawJson(String str) => userModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory userModel.fromJson(Map<String, dynamic> json) => userModel(
        id: json["Id"],
        name: json["name"],
        role: json["Role"],
        storeId: json["StoreId"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "name": name,
        "Role": role,
        "StoreId": storeId,
      };
}

enum roleType { owner, emp }
