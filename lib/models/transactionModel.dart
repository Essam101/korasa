// To parse this JSON data, do
//
//     final transactions = transactionsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class transactionModel {
  transactionModel({
    required this.id,
    required this.creationDate,
    required this.amount,
    required this.orderId,
    required this.customerId,
    required this.storeId,
  });

  final String id;
  final DateTime creationDate;
  final double amount;
  final String orderId;
  final String customerId;
  final String storeId;

  factory transactionModel.fromRawJson(String str) => transactionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory transactionModel.fromJson(Map<String, dynamic> json) => transactionModel(
    id: json["Id"],
    creationDate: DateTime.parse(json["CreationDate"]),
    amount: json["Amount"].toDouble(),
    orderId: json["OrderId"],
    customerId: json["CustomerId"],
    storeId: json["StoreId"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "CreationDate": creationDate.toIso8601String(),
    "Amount": amount,
    "OrderId": orderId,
    "CustomerId": customerId,
    "StoreId": storeId,
  };
}
