// To parse this JSON data, do
//
//     final locationCreateModel = locationCreateModelFromJson(jsonString);

import 'dart:convert';

LocationCreateModel locationCreateModelFromJson(String str) =>
    LocationCreateModel.fromJson(json.decode(str));

String locationCreateModelToJson(LocationCreateModel data) =>
    json.encode(data.toJson());

class LocationCreateModel {
  LocationCreateModel({
    required this.success,
    required this.messege,
    required this.error,
    // this.data,
  });

  final bool success;
  final String messege;
  final Error error;
  // final Data data;

  factory LocationCreateModel.fromJson(Map<String, dynamic> json) =>
      LocationCreateModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        error: Error.fromJson(json["error"] ?? {}),
        // data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        "error": error.toJson(),
        // "Data": data.toJson(),
      };
}

class Error {
    Error({
        required this.locationName,
    });

    final List<String> locationName;

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        locationName: List<String>.from((json["location_name"] ?? []).map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "location_name": List<dynamic>.from(locationName.map((x) => x)),
    };
}

// class Data {
//     Data({
//         this.locationName,
//         this.isActive,
//         this.createdby,
//         this.updatedAt,
//         this.createdAt,
//         this.id,
//     });

//     final String locationName;
//     final String isActive;
//     final String createdby;
//     final DateTime updatedAt;
//     final DateTime createdAt;
//     final int id;

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         locationName: json["location_name"],
//         isActive: json["is_active"],
//         createdby: json["createdby"],
//         updatedAt: DateTime.parse(json["updated_at"]),
//         createdAt: DateTime.parse(json["created_at"]),
//         id: json["id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "location_name": locationName,
//         "is_active": isActive,
//         "createdby": createdby,
//         "updated_at": updatedAt.toIso8601String(),
//         "created_at": createdAt.toIso8601String(),
//         "id": id,
//     };
// }
