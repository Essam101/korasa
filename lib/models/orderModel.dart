import 'dart:convert';

class Order {
  Order({
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

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
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
