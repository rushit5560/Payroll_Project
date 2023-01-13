import 'dart:convert';

DeleteAndUploadEmployeeDocumentModel deleteEmployeeDocumentModelFromJson(String str) => DeleteAndUploadEmployeeDocumentModel.fromJson(json.decode(str));

String deleteEmployeeDocumentModelToJson(DeleteAndUploadEmployeeDocumentModel data) => json.encode(data.toJson());

class DeleteAndUploadEmployeeDocumentModel {
  DeleteAndUploadEmployeeDocumentModel({
    required this.success,
    required this.messege,
  });

  bool success;
  String messege;

  factory DeleteAndUploadEmployeeDocumentModel.fromJson(Map<String, dynamic> json) => DeleteAndUploadEmployeeDocumentModel(
    success: json["success"] ?? false,
    messege: json["messege"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "messege": messege,
  };
}
