// To parse this JSON data, do
//
//     final customers = customersFromJson(jsonString);

import 'dart:convert';

List<CustomerModel> customerModelFromJson(String str) => List<CustomerModel>.from(json.decode(str).map((x) => CustomerModel.fromJson(x)));

String customerModelToJson(List<CustomerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerModel {
  CustomerModel({
    required this.customerId,
    required this.name,
    required this.notes,
    required this.storeId,
  });

  final String customerId;
  final String name;
  final String notes;
  late  String storeId;

  factory CustomerModel.fromRawJson(String str) => CustomerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        customerId: json["customerId"],
        name: json["name"],
        notes: json["notes"],
        storeId: json["storeId"],
      );

  Map<String, dynamic> toJson() => {
        "customerId": customerId,
        "name": name,
        "notes": notes,
        "storeId": storeId,
      };
}
