// To parse this JSON data, do
//
//     final employeeEditModel = employeeEditModelFromJson(jsonString);

import 'dart:convert';

EmployeeGetByIdModel employeeEditModelFromJson(String str) =>
    EmployeeGetByIdModel.fromJson(json.decode(str));

String employeeEditModelToJson(EmployeeGetByIdModel data) =>
    json.encode(data.toJson());

class EmployeeGetByIdModel {
  EmployeeGetByIdModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  final bool success;
  final String messege;
  final EmployeeGEtByIdModelData data;

  factory EmployeeGetByIdModel.fromJson(Map<String, dynamic> json) =>
      EmployeeGetByIdModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        data: EmployeeGEtByIdModelData.fromJson(json["Data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        // "Data": data.toJson(),
      };
}

class EmployeeGEtByIdModelData {
  EmployeeGEtByIdModelData({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.password,
    required this.address,
    required this.mobileNumber,
    required this.email,
    required this.companyid,
    required this.departmentId,
    required this.locationId,
    required this.isActive,
    required this.payPeriod,
    required this.dateOfBirth,
    required this.home,
    required this.homeNo,
    required this.workPhone,
    required this.hourlyRate,
    required this.salary,
    required this.employmentStartDate,
    required this.employmentEndDate,
    required this.street,
    required this.town,
    required this.state,
    required this.city,
    required this.zipcode,
    required this.photo,
    required this.createdby,
    required this.modifiedby,
    // required this.createdAt,
    // required this.updatedAt,
  });
  int id;
  String firstName;
  String middleName;
  String lastName;
  String password;
  String address;
  String mobileNumber;
  String email;
  String companyid;
  String departmentId;
  String locationId;
  String isActive;
  String payPeriod;
  DateTime dateOfBirth;
  String home;
  String homeNo;
  String workPhone;
  String hourlyRate;
  String salary;
  DateTime employmentStartDate;
  DateTime employmentEndDate;
  String street;
  String town;
  String state;
  String city;
  String zipcode;
  String photo;
  String createdby;
  String modifiedby;
  // DateTime createdAt;
  // DateTime updatedAt;

  factory EmployeeGEtByIdModelData.fromJson(Map<String, dynamic> json) =>
      EmployeeGEtByIdModelData(
        id: json["id"] ?? 0,
        firstName: json["first_name"] ?? "",
        middleName: json["middle_name"] ?? "",
        lastName: json["last_name"] ?? "",
        password: json["password"] ?? "",
        address: json["address"] ?? "",
        mobileNumber: json["mobile_number"] ?? "",
        email: json["email"] ?? "",
        companyid: json["companyid"] ?? "0",
        departmentId: json["department_id"] ?? "0",
        locationId: json["location_id"] ?? "0",
        isActive: json["is_active"] ?? "",
        payPeriod: json["pay_period"] ?? "",
        dateOfBirth: DateTime.parse(json["date_of_birth"] ?? DateTime.now()),
        home: json["home"] ?? "",
        homeNo: json["home_no"] ?? "",
        workPhone: json["work_phone"] ?? "",
        hourlyRate: json["hourly_rate"] ?? "0",
        salary: json["salary"] ?? "0",
        employmentStartDate:
            DateTime.parse(json["employment_start_date"] ?? DateTime.now()),
        employmentEndDate:
            DateTime.parse(json["employment_end_date"] ?? DateTime.now()),
        street: json["street"] ?? "",
        town: json["town"] ?? "",
        state: json["state"] ?? "",
        city: json["city"] ?? "",
        zipcode: json["zipcode"] ?? "",
        photo: json["photo"] ?? "",
        createdby: json["createdby"] ?? "0",
        modifiedby: json["modifiedby"] ?? "0",
        // createdAt: DateTime.parse(json["created_at"] ?? DateTime.now()),
        // updatedAt: DateTime.parse(json["updated_at"] ?? DateTime.now()),
      );
}
