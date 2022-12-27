// // To parse this JSON data, do
// //
// //     final updateCompanyModel = updateCompanyModelFromJson(jsonString);

// import 'dart:convert';

// UpdateEmployeeModel updateCompanyModelFromJson(String str) => UpdateEmployeeModel.fromJson(json.decode(str));

// String updateEmployeeModelToJson(UpdateEmployeeModel data) => json.encode(data.toJson());

// class UpdateEmployeeModel {
//   UpdateEmployeeModel({
//     required this.success,
//     required this.messege,
//   });

//   final bool success;
//   final String messege;

//   factory UpdateEmployeeModel.fromJson(Map<String, dynamic> json) => UpdateEmployeeModel(
//     success: json["success"] ?? false,
//     messege: json["messege"] ?? "",
//   );

//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "messege": messege,
//   };
// }

// To parse this JSON data, do
//
//     final updateEmployeeModel = updateEmployeeModelFromJson(jsonString);

import 'dart:convert';

UpdateEmployeeModel updateEmployeeModelFromJson(String str) =>
    UpdateEmployeeModel.fromJson(json.decode(str));

String updateEmployeeModelToJson(UpdateEmployeeModel data) =>
    json.encode(data.toJson());

class UpdateEmployeeModel {
  UpdateEmployeeModel({
    required this.success,
    required this.messege,
    // required this.data,
  });

  final bool success;
  final String messege;
  // final UpdateEmployeeData data;

  factory UpdateEmployeeModel.fromJson(Map<String, dynamic> json) =>
      UpdateEmployeeModel(
        success: json["success"],
        messege: json["messege"],
        // data: UpdateEmployeeData.fromJson(json["Data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        // "Data": data.toJson(),
      };
}

// class UpdateEmployeeData {
//   UpdateEmployeeData({
//     required this.id,
//     required this.firstName,
//     required this.middleName,
//     required this.lastName,
//     required this.password,
//     required this.address,
//     required this.phoneNo,
//     required this.email,
//     required this.departmentId,
//     required this.isActive,
//     required this.createdby,
//     required this.modifiedby,
//     required this.dateOfBrith,
//     required this.home,
//     required this.homeNo,
//     required this.workPhone,
//     required this.hourlyRate,
//     required this.salary,
//     required this.startDate,
//     required this.lastDayOfWork,
//     required this.companyid,
//     required this.photo,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   final int id;
//   final String firstName;
//   final String middleName;
//   final String lastName;
//   final String password;
//   final String address;
//   final String phoneNo;
//   final String email;
//   final String departmentId;
//   final String isActive;
//   final int createdby;
//   final String modifiedby;
//   final String dateOfBrith;
//   final String home;
//   final String homeNo;
//   final String workPhone;
//   final String hourlyRate;
//   final String salary;
//   final String startDate;
//   final String lastDayOfWork;
//   final String companyid;
//   final String photo;
//   final String createdAt;
//   final String updatedAt;

//   factory UpdateEmployeeData.fromJson(Map<String, dynamic> json) =>
//       UpdateEmployeeData(
//         id: json["id"],
//         firstName: json["first_name"],
//         middleName: json["middle_name"],
//         lastName: json["last_name"],
//         password: json["password"],
//         address: json["address"],
//         phoneNo: json["phone_no"],
//         email: json["email"],
//         departmentId: json["department_id"],
//         isActive: json["is_active"],
//         createdby: json["createdby"],
//         modifiedby: json["modifiedby"],
//         dateOfBrith: json["date_of_brith"],
//         home: json["home"],
//         homeNo: json["home_no"],
//         workPhone: json["work_phone"],
//         hourlyRate: json["hourly_rate"],
//         salary: json["salary"],
//         startDate: json["start_date"],
//         lastDayOfWork: json["last_day_of_work"],
//         companyid: json["companyid"],
//         photo: json["photo"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "first_name": firstName,
//         "middle_name": middleName,
//         "last_name": lastName,
//         "password": password,
//         "address": address,
//         "phone_no": phoneNo,
//         "email": email,
//         "department_id": departmentId,
//         "is_active": isActive,
//         "createdby": createdby,
//         "modifiedby": modifiedby,
//         "date_of_brith": dateOfBrith,
//         "home": home,
//         "home_no": homeNo,
//         "work_phone": workPhone,
//         "hourly_rate": hourlyRate,
//         "salary": salary,
//         "start_date": startDate,
//         "last_day_of_work": lastDayOfWork,
//         "companyid": companyid,
//         "photo": photo,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//       };
// }
