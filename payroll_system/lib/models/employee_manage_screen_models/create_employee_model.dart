// To parse this JSON data, do
//
//     final craeteEmployeeModel = craeteEmployeeModelFromJson(jsonString);

import 'dart:convert';

CraeteEmployeeModel craeteEmployeeModelFromJson(String str) => CraeteEmployeeModel.fromJson(json.decode(str));

String craeteEmployeeModelToJson(CraeteEmployeeModel data) => json.encode(data.toJson());

class CraeteEmployeeModel {
    CraeteEmployeeModel({
        required this.success,
        required this.messege,
        required this.data,
    });

    final bool success;
    final String messege;
    final CraeteEmployeeData data;

    factory CraeteEmployeeModel.fromJson(Map<String, dynamic> json) => CraeteEmployeeModel(
        success: json["success"]??false,
        messege: json["messege"]??"",
        data: CraeteEmployeeData.fromJson(json["Data"]??{}),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        "Data": data.toJson(),
    };
}

class CraeteEmployeeData {
    CraeteEmployeeData({
        required this.firstName,
        required this.middleName,
        required this.lastName,
        required this.password,
        required this.mobileNumber,
        required this.email,
        required this.departmentId,
        required this.locationId,
        required this.dateOfBirth,
        required this.hourlyRate,
        required this.salary,
        required this.employmentStartDate,
        required this.employmentEndDate,
        required this.companyid,
        required this.payPeriod,
        required this.isActive,
        required this.createdby,
        required this.street,
        required this.town,
        required this.state,
        required this.city,
        required this.zipcode,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    final String firstName;
    final String middleName;
    final String lastName;
    final String password;
    final String mobileNumber;
    final String email;
    final String departmentId;
    final String locationId;
    final String dateOfBirth;
    final String hourlyRate;
    final String salary;
    final String employmentStartDate;
    final String employmentEndDate;
    final String companyid;
    final String payPeriod;
    final String isActive;
    final String createdby;
    final String street;
    final String town;
    final String state;
    final String city;
    final String zipcode;
    final String updatedAt;
    final String createdAt;
    final int id;

    factory CraeteEmployeeData.fromJson(Map<String, dynamic> json) => CraeteEmployeeData(
        firstName: json["first_name"]??"",
        middleName: json["middle_name"]??"",
        lastName: json["last_name"]??"",
        password: json["password"]??"",
        mobileNumber: json["mobile_number"]??"",
        email: json["email"]??"",
        departmentId: json["department_id"]??"",
        locationId: json["location_id"]??"",
        dateOfBirth: json["date_of_birth"]??"",
        hourlyRate: json["hourly_rate"]??"",
        salary: json["salary"]??"",
        employmentStartDate: json["employment_start_date"]??"",
        employmentEndDate: json["employment_end_date"]??"",
        companyid: json["companyid"]??"",
        payPeriod: json["pay_period"]??"",
        isActive: json["is_active"]??"",
        createdby: json["createdby"]??"",
        street: json["street"]??"",
        town: json["town"]??"",
        state: json["state"]??"",
        city: json["city"]??"",
        zipcode: json["zipcode"]??"",
        updatedAt: json["updated_at"]??"",
        createdAt: json["created_at"]??"",
        id: json["id"]??0,
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "password": password,
        "mobile_number": mobileNumber,
        "email": email,
        "department_id": departmentId,
        "location_id": locationId,
        "date_of_birth": dateOfBirth,
        "hourly_rate": hourlyRate,
        "salary": salary,
        "employment_start_date": employmentStartDate,
        "employment_end_date": employmentEndDate,
        "companyid": companyid,
        "pay_period": payPeriod,
        "is_active": isActive,
        "createdby": createdby,
        "street": street,
        "town": town,
        "state": state,
        "city": city,
        "zipcode": zipcode,
        "updated_at": updatedAt,
        "created_at": createdAt,
        "id": id,
    };
}






//CraeteEmployeeData