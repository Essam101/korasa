// To parse this JSON data, do
//
//     final customers = customersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class customerModel {
  customerModel({
    required this.id,
    required this.name,
    required this.storeId,
  });

  final String id;
  final String name;
  final String storeId;

  factory customerModel.fromRawJson(String str) => customerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory customerModel.fromJson(Map<String, dynamic> json) => customerModel(
    id: json["Id"],
    name: json["name"],
    storeId: json["StoreId"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "name": name,
    "StoreId": storeId,
  };
}
