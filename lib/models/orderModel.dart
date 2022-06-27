import 'dart:convert';

class OrderModel {
  OrderModel({
    required this.orderId,
    required this.creationDate,
    required this.itemName,
    required this.price,
    this.notes,
    this.isPaid = false,
  });

  String orderId;
  String creationDate;
  bool isPaid;
  String itemName;
  String? notes;
  double price;

  factory OrderModel.fromRawJson(String str) => OrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderId: json["orderId"],
        creationDate: json["creationDate"],
        isPaid: json["isPaid"],
        itemName: json["itemName"],
        notes: json["notes"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "creationDate": creationDate,
        "isPaid": isPaid,
        "itemName": itemName,
        "notes": notes,
        "price": price,
      };
}
