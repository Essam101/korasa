import 'dart:convert';

class TransactionModel {
  TransactionModel({
    required this.transactionId,
    required this.creationDate,
    required this.amount,
    this.notes,
  });

  String transactionId;
  String creationDate;
  double amount;
  String? notes;

  factory TransactionModel.fromRawJson(String str) => TransactionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
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
