// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Users {
  Users({
    required this.id,
    required this.name,
    required this.role,
    required this.storeId,
  });

  late final String id;
  late final String name;
  late final roleType role;
  late final String storeId;

  factory Users.fromRawJson(String str) => Users.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Users.fromJson(Map<String, dynamic> json) => Users(
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
