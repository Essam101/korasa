import 'dart:convert';

class StoreModel {
  StoreModel({
    required this.storeId,
    required this.name,
    required this.status,
  });

  late final int storeId;

  late final String name;
  late final String status;

  factory StoreModel.fromRawJson(String str) => StoreModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        storeId: json["storeId"] == null ? null : json["storeId"],
        name: json["Name"] == null ? null : json["Name"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "storeId": storeId == null ? null : storeId,
        "Name": name == null ? null : name,
        "status": status == null ? null : status,
      };
}
