import 'dart:convert';

DeleteCompanyModel deleteCompanyModelFromJson(String str) => DeleteCompanyModel.fromJson(json.decode(str));

String deleteCompanyModelToJson(DeleteCompanyModel data) => json.encode(data.toJson());

class DeleteCompanyModel {
  DeleteCompanyModel({
    required this.success,
    required this.messege,
  });

  bool success;
  String messege;

  factory DeleteCompanyModel.fromJson(Map<String, dynamic> json) => DeleteCompanyModel(
    success: json["success"] ?? false,
    messege: json["messege"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "messege": messege,
  };
}
