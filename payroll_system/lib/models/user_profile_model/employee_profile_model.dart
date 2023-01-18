// To parse this JSON data, do
//
//     final employeeProfileModel = employeeProfileModelFromJson(jsonString);

import 'dart:convert';

EmployeeProfileModel employeeProfileModelFromJson(String str) =>
    EmployeeProfileModel.fromJson(json.decode(str));

String employeeProfileModelToJson(EmployeeProfileModel data) =>
    json.encode(data.toJson());

class EmployeeProfileModel {
  EmployeeProfileModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  final bool success;
  final String messege;
  final List<EmployeeDatum> data;

  factory EmployeeProfileModel.fromJson(Map<String, dynamic> json) =>
      EmployeeProfileModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        data: List<EmployeeDatum>.from(
            json["Data"].map((x) => EmployeeDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class EmployeeDatum {
  EmployeeDatum({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.password,
    required this.address,
    required this.phoneNo,
    required this.email,
    // this.departmentId,
    required this.isActive,
    // this.createdby,
    // this.modifiedby,
    required this.dateOfBrith,
    required this.home,
    required this.homeNo,
    required this.workPhone,
    // this.hourlyRate,
    // this.salary,
    // this.startDate,
    // this.lastDayOfWork,
    required this.companyid,
    required this.photo,
    // this.createdAt,
    // this.updatedAt,
    required this.userid,
  });

  final int id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String password;
  final String address;
  final String phoneNo;
  final String email;
  // final dynamic departmentId;
  final String isActive;
  // final dynamic createdby;
  // final dynamic modifiedby;
  final String dateOfBrith;
  final String home;
  final String homeNo;
  final String workPhone;
  // final dynamic hourlyRate;
  // final dynamic salary;
  // final dynamic startDate;
  // final dynamic lastDayOfWork;
  final String companyid;
  final String photo;
  // final dynamic createdAt;
  // final String updatedAt;
  final int userid;

  factory EmployeeDatum.fromJson(Map<String, dynamic> json) => EmployeeDatum(
        id: json["id"] ?? 0,
        firstName: json["first_name"] ?? "",
        middleName: json["middle_name"] ?? "",
        lastName: json["last_name"] ?? "",
        password: json["password"] ?? "",
        address: json["address"] ?? "",
        phoneNo: json["phone_no"] ?? "",
        email: json["email"] ?? "",
        // departmentId: json["department_id"] ?? "",
        isActive: json["is_active"] ?? "",
        // createdby: json["createdby"] ?? "",
        // modifiedby: json["modifiedby"] ?? "",
        dateOfBrith: json["date_of_brith"] ?? "",
        home: json["home"] ?? "",
        homeNo: json["home_no"] ?? "",
        workPhone: json["work_phone"] ?? "",
        // hourlyRate: json["hourly_rate"] ?? "",
        // salary: json["salary"] ?? "",
        // startDate: json["start_date"] ?? "",
        // lastDayOfWork: json["last_day_of_work"] ?? "",
        companyid: json["companyid"] ?? "0",
        photo: json["photo"] ?? "",
        // createdAt: json["created_at"] ?? "",
        // updatedAt: DateTime.parse(json["updated_at"]) ?? "",
        userid: json["userid"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "password": password,
        "address": address,
        "phone_no": phoneNo,
        "email": email,
        // "department_id": departmentId,
        "is_active": isActive,
        // "createdby": createdby,
        // "modifiedby": modifiedby,
        "date_of_brith": dateOfBrith,
        "home": home,
        "home_no": homeNo,
        "work_phone": workPhone,
        // "hourly_rate": hourlyRate,
        // "salary": salary,
        // "start_date": startDate,
        // "last_day_of_work": lastDayOfWork,
        "companyid": companyid,
        "photo": photo,
        // "created_at": createdAt,
        // "updated_at": updatedAt.toIso8601String(),
        "userid": userid,
      };
}
