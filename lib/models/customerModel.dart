// To parse this JSON data, do
//
//     final customers = customersFromJson(jsonString);

import 'dart:convert';

List<CustomerModel> customerModelFromJson(String str) => List<CustomerModel>.from(json.decode(str).map((x) => CustomerModel.fromJson(x)));

String customerModelToJson(List<CustomerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerModel {
  CustomerModel({
    required this.id,
    required this.name,
    required this.storeId,
  });

  final String id;
  final String name;
  final String storeId;

  factory CustomerModel.fromRawJson(String str) => CustomerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
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
