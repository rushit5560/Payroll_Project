import 'dart:convert';

CreateCompanyModel createCompanyModelFromJson(String str) =>
    CreateCompanyModel.fromJson(json.decode(str));

String createCompanyModelToJson(CreateCompanyModel data) =>
    json.encode(data.toJson());

class CreateCompanyModel {
  CreateCompanyModel({
    required this.success,
    required this.messege,
    // required this.data,
    required this.error,
  });

  bool success;
  String messege;
  Error error;
  // Data data;

  factory CreateCompanyModel.fromJson(Map<String, dynamic> json) =>
      CreateCompanyModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        // data: Data.fromJson(json["Data"] ?? {}),
        error: Error.fromJson(json["error"]??{}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        "error": error.toJson(),
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
class Error {
  Error({
    required this.email,
  });

  List<String> email;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        email: List<String>.from((json["email"] ?? []).map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "email": List<dynamic>.from(email.map((x) => x)),
      };
}
