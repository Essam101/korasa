import 'dart:convert';

List<StoreModel> storeModelFromJson(String str) => List<StoreModel>.from(json.decode(str).map((x) => StoreModel.fromJson(x)));

String storeModelToJson(List<StoreModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreModel {
  StoreModel({
    required this.storeId,
    required this.name,
    required this.status,
    this.notes,
  });

  /// store Id
  final String storeId;
  final String name;
  final String? notes;
  final int status;

  factory StoreModel.fromRawJson(String str) => StoreModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        storeId: json["storeId"] == null ? null : json["storeId"],
        name: json["name"] == null ? null : json["name"],
        notes: json["notes"] == null ? null : json["notes"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "storeId": storeId,
        "name": name,
        "notes": notes,
        "status": status,
      };
}

enum StoreStatus { Active, Deactivated }
