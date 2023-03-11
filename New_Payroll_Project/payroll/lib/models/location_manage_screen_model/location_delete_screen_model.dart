import 'dart:convert';

LocationDeleteModel aboutDetailsModelFromJson(String str) =>
    LocationDeleteModel.fromJson(json.decode(str));

String aboutDetailsModelToJson(LocationDeleteModel data) =>
    json.encode(data.toJson());

class LocationDeleteModel {
  LocationDeleteModel({
    required this.success,
    required this.messege,
    // required this.data,
  });

  final bool success;
  final String messege;
  // final EmployeeDeleteData data;

  factory LocationDeleteModel.fromJson(Map<String, dynamic> json) =>
      LocationDeleteModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        // data: EmployeeDeleteData.fromJson(json["Data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        // "Data": data.toJson(),
      };
}
