

import 'dart:convert';

EmployeeDeleteModel aboutDetailsModelFromJson(String str) =>
    EmployeeDeleteModel.fromJson(json.decode(str));

String aboutDetailsModelToJson(EmployeeDeleteModel data) =>
    json.encode(data.toJson());

class EmployeeDeleteModel {
  EmployeeDeleteModel({
    required this.success,
    required this.messege,
    // required this.data,
  });

  final bool success;
  final String messege;
  // final EmployeeDeleteData data;

  factory EmployeeDeleteModel.fromJson(Map<String, dynamic> json) =>
      EmployeeDeleteModel(
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

// class EmployeeDeleteData {
//   EmployeeDeleteData({
//     required this.id,
//     required this.firstName,
//     required this.middleName,
//     required this.lastName,
//     // this.password,
//     // this.address,
//     required this.phoneNo,
//     required this.email,
//     required this.departmentId,
//     required this.isActive,
//     required this.companyid,

//     // this.createdby,
//     // this.modifiedby,
//     // this.dateOfBrith,
//     // this.home,
//     // this.homeNo,
//     // this.workPhone,
//     // this.hourlyRate,
//     // this.salary,
//     // this.startDate,
//     // this.lastDayOfWork,
//     // this.photo,
//     // this.createdAt,
//     // this.updatedAt,
//   });

//   final int id;
//   final String firstName;
//   final String middleName;
//   final String lastName;
//   final String phoneNo;
//   final String email;
//   final int departmentId;
//   final String isActive;
//   final int companyid;
//   // final String password;
//   // final String address;
//   // final int createdby;
//   // final int modifiedby;
//   // final String dateOfBrith;
//   // final String home;
//   // final String homeNo;
//   // final String workPhone;
//   // final int hourlyRate;
//   // final int salary;
//   // final String startDate;
//   // final int lastDayOfWork;
//   // final String photo;
//   // final String createdAt;
//   // final String updatedAt;

//   factory EmployeeDeleteData.fromJson(Map<String, dynamic> json) => EmployeeDeleteData(
//         id: json["id"] ?? 0,
//         firstName: json["first_name"] ?? "",
//         middleName: json["middle_name"] ?? "",
//         lastName: json["last_name"] ?? "",
//         // password: json["password"],
//         // address: json["address"],
//         phoneNo: json["phone_no"] ?? "",
//         email: json["email"] ?? "",
//         departmentId: json["department_id"] ?? 0,
//         isActive: json["is_active"] ?? "",
//         companyid: json["companyid"] ?? 0,

//         // createdby: json["createdby"],
//         // modifiedby: json["modifiedby"],
//         // dateOfBrith: DateTime.parse(json["date_of_brith"]),
//         // home: json["home"],
//         // homeNo: json["home_no"],
//         // workPhone: json["work_phone"],
//         // hourlyRate: json["hourly_rate"],
//         // salary: json["salary"],
//         // startDate: DateTime.parse(json["start_date"]),
//         // lastDayOfWork: json["last_day_of_work"],
//         // photo: json["photo"],
//         // createdAt: DateTime.parse(json["created_at"]),
//         // updatedAt: DateTime.parse(json["updated_at"]),
//       );

  // void clear() {}

  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "first_name": firstName,
  //     "middle_name": middleName,
  //     "last_name": lastName,
  //     "password": password,
  //     "address": address,
  //     "phone_no": phoneNo,
  //     "email": email,
  //     "department_id": departmentId,
  //     "is_active": isActive,
  //     "createdby": createdby,
  //     "modifiedby": modifiedby,
  //     "date_of_brith": dateOfBrith.toIso8601String(),
  //     "home": home,
  //     "home_no": homeNo,
  //     "work_phone": workPhone,
  //     "hourly_rate": hourlyRate,
  //     "salary": salary,
  //     "start_date": startDate.toIso8601String(),
  //     "last_day_of_work": lastDayOfWork,
  //     "companyid": companyid,
  //     "photo": photo,
  //     "created_at": createdAt.toIso8601String(),
  //     "updated_at": updatedAt.toIso8601String(),
  // };
// }
