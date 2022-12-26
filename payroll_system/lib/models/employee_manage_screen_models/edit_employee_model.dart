// To parse this JSON data, do
//
//     final employeeEditModel = employeeEditModelFromJson(jsonString);

import 'dart:convert';

EmployeeEditModel employeeEditModelFromJson(String str) =>
    EmployeeEditModel.fromJson(json.decode(str));

String employeeEditModelToJson(EmployeeEditModel data) =>
    json.encode(data.toJson());

class EmployeeEditModel {
  EmployeeEditModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  final bool success;
  final String messege;
  final Data data;

  factory EmployeeEditModel.fromJson(Map<String, dynamic> json) =>
      EmployeeEditModel(
        success: json["success"],
        messege: json["messege"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        "Data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.password,
    required this.address,
    required this.phoneNo,
    required this.email,
    required this.departmentId,
    required this.isActive,
    required this.createdby,
    required this.modifiedby,
    required this.dateOfBrith,
    required this.home,
    required this.homeNo,
    required this.workPhone,
    required this.hourlyRate,
    required this.salary,
    required this.startDate,
    required this.lastDayOfWork,
    required this.companyid,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String password;
  final String address;
  final String phoneNo;
  final String email;
  final int departmentId;
  final String isActive;
  final int createdby;
  final int modifiedby;
  final String dateOfBrith;
  final String home;
  final String homeNo;
  final String workPhone;
  final int hourlyRate;
  final int salary;
  final String startDate;
  final int lastDayOfWork;
  final int companyid;
  final String photo;
  final String createdAt;
  final String updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        password: json["password"],
        address: json["address"],
        phoneNo: json["phone_no"],
        email: json["email"],
        departmentId: json["department_id"],
        isActive: json["is_active"],
        createdby: json["createdby"],
        modifiedby: json["modifiedby"],
        dateOfBrith: json["date_of_brith"],
        home: json["home"],
        homeNo: json["home_no"],
        workPhone: json["work_phone"],
        hourlyRate: json["hourly_rate"],
        salary: json["salary"],
        startDate: json["start_date"],
        lastDayOfWork: json["last_day_of_work"],
        companyid: json["companyid"],
        photo: json["photo"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
        "department_id": departmentId,
        "is_active": isActive,
        "createdby": createdby,
        "modifiedby": modifiedby,
        "date_of_brith": dateOfBrith,
        "home": home,
        "home_no": homeNo,
        "work_phone": workPhone,
        "hourly_rate": hourlyRate,
        "salary": salary,
        "start_date": startDate,
        "last_day_of_work": lastDayOfWork,
        "companyid": companyid,
        "photo": photo,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
