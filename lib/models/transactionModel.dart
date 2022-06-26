import 'dart:convert';

class Transaction {
  Transaction({
    required this.creationDate,
    this.notes,
    required this.amount,
  });

  String creationDate;
  String? notes;
  double amount;

  factory Transaction.fromRawJson(String str) => Transaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        creationDate: json["creationDate"],
        notes: json["notes"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "creationDate": creationDate,
        "notes": notes,
        "amount": amount,
      };
}
