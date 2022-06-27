import 'dart:convert';

class Transaction {
  Transaction({
    required this.transactionId,
    required this.creationDate,
    required this.amount,
    this.notes,
  });

  String transactionId;
  String creationDate;
  double amount;
  String? notes;

  factory Transaction.fromRawJson(String str) => Transaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        transactionId: json["transactionId"],
        creationDate: json["creationDate"],
        notes: json["notes"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "creationDate": creationDate,
        "notes": notes,
        "amount": amount,
      };
}
