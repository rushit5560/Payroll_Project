import 'dart:convert';

CreateCompanyModel createCompanyModelFromJson(String str) => CreateCompanyModel.fromJson(json.decode(str));

String createCompanyModelToJson(CreateCompanyModel data) => json.encode(data.toJson());

class CreateCompanyModel {
  CreateCompanyModel({
    required this.success,
    required this.messege,
    // required this.data,
  });

  bool success;
  String messege;
  // Data data;

  factory CreateCompanyModel.fromJson(Map<String, dynamic> json) => CreateCompanyModel(
    success: json["success"] ?? false,
    messege: json["messege"] ?? "",
    // data: Data.fromJson(json["Data"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "messege": messege,
    // "Data": data.toJson(),
  };
}

// class Data {
//   Data({
//     required this.userName,
//     required this.email,
//     required this.phoneno,
//     required this.address,
//     required this.fullName,
//     required this.departmentId,
//     required this.roleId,
//     required this.createdby,
//     // required this.updatedAt,
//     // required this.createdAt,
//     required this.id,
//   });
//
//   String userName;
//   String email;
//   String phoneno;
//   String address;
//   String fullName;
//   String departmentId;
//   int roleId;
//   String createdby;
//   // DateTime updatedAt;
//   // DateTime createdAt;
//   int id;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     userName: json["user_name"] ?? "",
//     email: json["email"] ?? "",
//     phoneno: json["phoneno"] ?? "",
//     address: json["address"] ?? "",
//     fullName: json["full_name"] ?? "",
//     departmentId: json["department_id"] ?? "",
//     roleId: json["role_id"] ?? 0,
//     createdby: json["createdby"] ?? "",
//     // updatedAt: DateTime.parse(json["updated_at"]),
//     // createdAt: DateTime.parse(json["created_at"]),
//     id: json["id"] ?? 0,
//   );
//
//   Map<String, dynamic> toJson() => {
//     "user_name": userName,
//     "email": email,
//     "phoneno": phoneno,
//     "address": address,
//     "full_name": fullName,
//     "department_id": departmentId,
//     "role_id": roleId,
//     "createdby": createdby,
//     // "updated_at": updatedAt.toIso8601String(),
//     // "created_at": createdAt.toIso8601String(),
//     "id": id,
//   };
// }
