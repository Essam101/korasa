// To parse this JSON data, do
//
//     final customers = customersFromJson(jsonString);

import 'dart:convert';

List<customerModel> customerModelFromJson(String str) =>
    List<customerModel>.from(
        json.decode(str).map((x) => customerModel.fromJson(x)));

String customerModelToJson(List<customerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class customerModel {
  customerModel({
    required this.id,
    required this.name,
    required this.storeId,
  });

  final String id;
  final String name;
  final String storeId;

  factory customerModel.fromRawJson(String str) =>
      customerModel.fromJson(json.decode(str));

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
