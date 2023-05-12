import 'dart:convert';

CompanyWiseEmployeeModel companyWiseEmployeeModelFromJson(String str) =>
    CompanyWiseEmployeeModel.fromJson(json.decode(str));

String companyWiseEmployeeModelToJson(CompanyWiseEmployeeModel data) =>
    json.encode(data.toJson());

class CompanyWiseEmployeeModel {
  CompanyWiseEmployeeModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  final bool success;
  final String messege;
  final List<CompanyWiseEmployeeData> data;

  factory CompanyWiseEmployeeModel.fromJson(Map<String, dynamic> json) =>
      CompanyWiseEmployeeModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        data: List<CompanyWiseEmployeeData>.from(
            json["Data"].map((x) => CompanyWiseEmployeeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        // "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CompanyWiseEmployeeData {
  CompanyWiseEmployeeData({
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
    // required this.dateOfBirth,
    // this.home,
    // this.homeNo,
    // this.workPhone,
    required this.hourlyRate,
    required this.salary,
    // this.employmentStartDate,
    // this.employmentEndDate,
    required this.street,
    required this.town,
    required this.state,
    required this.city,
    required this.zipcode,
    // this.photo,
    required this.createdby,
    required this.modifiedby,
    required this.isChecked,
    required this.regularTextFieldValue,
    required this.otTextFieldValue,
    required this.holidayPayTextFieldValue,
    required this.bonusTextFieldValue,
    required this.otherEarningTextFieldValue,
    required this.commissionTextFieldValue,
    required this.sickPayHoursTextFieldValue,
    required this.vacationHoursTextFieldValue,
    required this.tipTextFieldValue,
    required this.taxTextFieldValue,

    // this.createdAt,
    // this.updatedAt,
  });

  final int id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String password;
  final String address;
  final String mobileNumber;
  final String email;
  final String companyid;
  final String departmentId;
  final String locationId;
  final String isActive;
  final String payPeriod;
  // final DateTime dateOfBirth;
  // final dynamic home;
  // final dynamic homeNo;
  // final dynamic workPhone;
  final String hourlyRate;
  final String salary;
  // final DateTime employmentStartDate;
  // final DateTime employmentEndDate;
  final String street;
  final String town;
  final String state;
  final String city;
  final String zipcode;
  // final dynamic photo;
  final String createdby;
  final String modifiedby;
  bool isChecked;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  String regularTextFieldValue;
  String otTextFieldValue;
  String holidayPayTextFieldValue;
  String bonusTextFieldValue;
  String otherEarningTextFieldValue;
  String commissionTextFieldValue;
  String sickPayHoursTextFieldValue;
  String vacationHoursTextFieldValue;
  String tipTextFieldValue;
  String taxTextFieldValue;

  factory CompanyWiseEmployeeData.fromJson(Map<String, dynamic> json) =>
      CompanyWiseEmployeeData(
        id: json["id"] ?? 0,
        firstName: json["first_name"] ?? "",
        middleName: json["middle_name"] ?? "",
        lastName: json["last_name"] ?? "",
        password: json["password"] ?? "",
        address: json["address"] ?? "",
        mobileNumber: json["mobile_number"] ?? "",
        email: json["email"] ?? "",
        companyid: (json["companyid"] ?? 0).toString(),
        departmentId: (json["department_id"] ?? 0).toString(),
        locationId: (json["location_id"] ?? 0).toString(),
        isActive: json["is_active"] ?? "",
        payPeriod: json["pay_period"] ?? "",
        // dateOfBirth: DateTime.parse(json["date_of_birth"]),
        // home: json["home"],
        // homeNo: json["home_no"],
        // workPhone: json["work_phone"],
        hourlyRate: (json["hourly_rate"] ?? 0).toString(),
        salary: (json["salary"] ?? 0).toString(),
        // employmentStartDate: DateTime.parse(json["employment_start_date"]),
        // employmentEndDate: DateTime.parse(json["employment_end_date"]),
        street: json["street"] ?? "",
        town: json["town"] ?? "",
        state: json["state"] ?? "",
        city: json["city"] ?? "",
        zipcode: json["zipcode"] ?? "",
        // photo: json["photo"],
        createdby: (json["createdby"] ?? 0).toString(),
        modifiedby: (json["modifiedby"] ?? 0).toString(),
        isChecked: false,

        regularTextFieldValue: "0",
        otTextFieldValue: "0",
        holidayPayTextFieldValue: "0",
        bonusTextFieldValue: "0",
        otherEarningTextFieldValue: "0",
        commissionTextFieldValue: "0",
        sickPayHoursTextFieldValue: "0",
        vacationHoursTextFieldValue: "0",
        tipTextFieldValue: "0",
        taxTextFieldValue: "0",

        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
      );

  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "first_name": firstName,
  //     "middle_name": middleName,
  //     "last_name": lastName,
  //     "password": password,
  //     "address": address,
  //     "mobile_number": mobileNumber,
  //     "email": email,
  //     "companyid": companyid,
  //     "department_id": departmentId,
  //     "location_id": locationId,
  //     "is_active": isActive,
  //     "pay_period": payPeriod,
  //     "date_of_birth": dateOfBirth.toIso8601String(),
  //     "home": home,
  //     "home_no": homeNo,
  //     "work_phone": workPhone,
  //     "hourly_rate": hourlyRate,
  //     "salary": salary,
  //     // "employment_start_date": employmentStartDate.toIso8601String(),
  //     // "employment_end_date": employmentEndDate.toIso8601String(),
  //     "street": street,
  //     "town": town,
  //     "state": state,
  //     "city": city,
  //     "zipcode": zipcode,
  //     // "photo": photo,
  //     "createdby": createdby,
  //     "modifiedby": modifiedby,
  //     // "created_at": createdAt.toIso8601String(),
  //     // "updated_at": updatedAt.toIso8601String(),
  // };
}
