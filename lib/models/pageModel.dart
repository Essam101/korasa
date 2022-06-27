// To parse this JSON data, do
//
//     final pageModel = pageModelFromJson(jsonString);

import 'dart:convert';
import 'package:shop/models/orderModel.dart';
import 'package:shop/models/transactionModel.dart';

List<PageModel> pageModelFromJson(String str) => List<PageModel>.from(json.decode(str).map((x) => PageModel.fromJson(x)));

String pageModelToJson(List<PageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PageModel {
  PageModel({
    required this.pageId,
    required this.storeId,
    required this.customerId,
    required this.creationDate,
    this.isClosed = false,
    this.paidAmount = 0,
    this.amount = 0,
    required this.orders,
    required this.transactions,
  });

  String pageId;
  String storeId;
  String customerId;
  String creationDate;
  bool isClosed;
  double? paidAmount;
  double amount;
  List<Order> orders;
  List<Transaction> transactions;

  factory PageModel.fromRawJson(String str) => PageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PageModel.fromJson(Map<String, dynamic> json) => PageModel(
        pageId: json["pageId"],
        storeId: json["storeId"],
        customerId: json["customerId"],
        creationDate: json["creationDate"],
        isClosed: json["isClosed"],
        paidAmount: json["paidAmount"],
        amount: json["amount"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
        transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pageId": pageId,
        "storeId": storeId,
        "customerId": customerId,
        "creationDate": creationDate,
        "isClosed": isClosed,
        "paidAmount": paidAmount,
        "amount": amount,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
      };
}
