// To parse this JSON data, do
//
//     final locationUpdateModel = locationUpdateModelFromJson(jsonString);

import 'dart:convert';

LocationUpdateModel locationUpdateModelFromJson(String str) =>
    LocationUpdateModel.fromJson(json.decode(str));

String locationUpdateModelToJson(LocationUpdateModel data) =>
    json.encode(data.toJson());

class LocationUpdateModel {
  LocationUpdateModel({
    required this.success,
    required this.messege,
    // this.data,
  });

  final bool success;
  final String messege;
  // final Data data;

  factory LocationUpdateModel.fromJson(Map<String, dynamic> json) =>
      LocationUpdateModel(
        success: json["success"],
        messege: json["messege"],
        // data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        // "Data": data.toJson(),
      };
}

// class Data {
//     Data({
//         this.id,
//         this.locationName,
//         this.isActive,
//         this.createdby,
//         this.modifiedby,
//         this.companyid,
//         this.createdAt,
//         this.updatedAt,
//     });

//     final int id;
//     final String locationName;
//     final String isActive;
//     final int createdby;
//     final String modifiedby;
//     final dynamic companyid;
//     final DateTime createdAt;
//     final DateTime updatedAt;

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["id"],
//         locationName: json["location_name"],
//         isActive: json["is_active"],
//         createdby: json["createdby"],
//         modifiedby: json["modifiedby"],
//         companyid: json["companyid"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "location_name": locationName,
//         "is_active": isActive,
//         "createdby": createdby,
//         "modifiedby": modifiedby,
//         "companyid": companyid,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//     };
// }
