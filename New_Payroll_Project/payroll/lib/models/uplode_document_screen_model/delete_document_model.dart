import 'dart:convert';

DeleteAndUploadDocumentModel deleteEmployeeDocumentModelFromJson(String str) =>
    DeleteAndUploadDocumentModel.fromJson(json.decode(str));

String deleteEmployeeDocumentModelToJson(DeleteAndUploadDocumentModel data) =>
    json.encode(data.toJson());

class DeleteAndUploadDocumentModel {
  DeleteAndUploadDocumentModel({
    required this.success,
    required this.messege,
  });

  bool success;
  String messege;

  factory DeleteAndUploadDocumentModel.fromJson(Map<String, dynamic> json) =>
      DeleteAndUploadDocumentModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
      };
}
