// To parse this JSON data, do
//
//     final AllLocationListModel = AllLocationListModelFromJson(jsonString);

import 'dart:convert';

AllLocationListModel AllLocationListModelFromJson(String str) =>
    AllLocationListModel.fromJson(json.decode(str));

String AllLocationListModelToJson(AllLocationListModel data) =>
    json.encode(data.toJson());

class AllLocationListModel {
  AllLocationListModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  final bool success;
  final String messege;
  final List<LocationListData> data;

  factory AllLocationListModel.fromJson(Map<String, dynamic> json) =>
      AllLocationListModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        data: List<LocationListData>.from(
            json["Data"].map((x) => LocationListData.fromJson(x)) ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        // "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LocationListData {
  LocationListData({
    required this.id,
    required this.locationName,
    required this.isActive,
    required this.createdby,
    required this.modifiedby,
    required this.companyid,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String locationName;
  final String isActive;
  final int createdby;
  final int modifiedby;
  final String companyid;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory LocationListData.fromJson(Map<String, dynamic> json) =>
      LocationListData(
        id: json["id"],
        locationName: json["location_name"],
        isActive: json["is_active"],
        createdby: json["createdby"],
        modifiedby: json["modifiedby"] ?? 0,
        companyid: json["companyid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "location_name": locationName,
  //     "is_active": isActive,
  //     "createdby": createdby,
  //     "modifiedby": modifiedby == null ? null : modifiedby,
  //     "companyid": companyid,
  //     "created_at": createdAt.toIso8601String(),
  //     "updated_at": updatedAt.toIso8601String(),
  // };
}
