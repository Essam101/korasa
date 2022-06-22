// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class orderModel {
  orderModel({
     required this.id,
     required this.productName,
     required this.creationDate,
     required this.amount,
     required this.isPaid,
     required this.storeId,
  });

  final String id;
  final String productName;
  final String creationDate;
  final double amount;
  final bool isPaid;
  final String storeId;

  factory orderModel.fromRawJson(String str) => orderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory orderModel.fromJson(Map<String, dynamic> json) => orderModel(
    id: json["Id"],
    productName: json["productName"],
    creationDate: json["CreationDate"],
    amount: json["Amount"].toDouble(),
    isPaid: json["IsPaid"],
    storeId: json["StoreId"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "productName": productName,
    "CreationDate": creationDate,
    "Amount": amount,
    "IsPaid": isPaid,
    "StoreId": storeId,
  };
}
