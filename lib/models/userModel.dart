// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    required this.userId,
    required this.name,
    required this.role,
    required this.storeId,
    required this.email
  });

  late final String userId;
  late final String name;
  late final roleType role;
  late final String storeId;
  late final String email ;

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
        name: json["name"],
        role: json["Role"],
        storeId: json["StoreId"],
    email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "Role": role,
        "StoreId": storeId,
        "email": email,
      };
}

enum roleType { owner, emp }
