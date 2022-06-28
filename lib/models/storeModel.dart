import 'dart:convert';

List<StoreModel> storeModelFromJson(String str) => List<StoreModel>.from(json.decode(str).map((x) => StoreModel.fromJson(x)));

String storeModelToJson(List<StoreModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreModel {
  StoreModel({
    required this.storeId,
    required this.name,
    required this.status,
    this.description,
  });

  /// store Id
  late final String storeId;
  late final String name;
  late final String? description;
  final int status;

  factory StoreModel.fromRawJson(String str) => StoreModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        storeId: json["storeId"] == null ? null : json["storeId"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "storeId": storeId,
        "name": name,
        "notes": description,
        "status": status,
      };
}

enum StoreStatus { Active, Deactivated }
