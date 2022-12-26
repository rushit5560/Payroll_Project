import 'dart:convert';

CraeteEmployeeModel aboutDetailsModelFromJson(String str) =>
    CraeteEmployeeModel.fromJson(json.decode(str));

String aboutDetailsModelToJson(CraeteEmployeeModel data) =>
    json.encode(data.toJson());

class CraeteEmployeeModel {
  CraeteEmployeeModel({
    required this.success,
    required this.messege,
    // required this.data,
  });

  final bool success;
  final String messege;
  // final CraeteEmployeeData data;

  factory CraeteEmployeeModel.fromJson(Map<String, dynamic> json) =>
      CraeteEmployeeModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        // data: CraeteEmployeeData.fromJson(json["Data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        // "Data": data.toJson(),
      };
}

class CraeteEmployeeData {
  CraeteEmployeeData({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.password,
    required this.address,
    required this.phoneNo,
    required this.email,
    required this.departmentId,
    required this.dateOfBrith,
    required this.home,
    required this.homeNo,
    required this.workPhone,
    required this.hourlyRate,
    required this.salary,
    required this.startDate,
    required this.lastDayOfWork,
    required this.companyid,
    required this.createdby,
    required this.updatedAt,
    required this.createdAt,
    required this.photo,
    required this.id,
  });

  final String firstName;
  final String middleName;
  final String lastName;
  final String password;
  final String address;
  final String phoneNo;
  final String email;
  final String departmentId;
  final String dateOfBrith;
  final String home;
  final String homeNo;
  final String workPhone;
  final String hourlyRate;
  final String salary;
  final String startDate;
  final String lastDayOfWork;
  final String companyid;
  final String createdby;
  final String updatedAt;
  final String createdAt;
  final String photo;
  final int id;

  factory CraeteEmployeeData.fromJson(Map<String, dynamic> json) =>
      CraeteEmployeeData(
        firstName: json["first_name"] ?? "",
        middleName: json["middle_name"] ?? "",
        lastName: json["last_name"] ?? "",
        password: json["password"] ?? "",
        address: json["address"] ?? "",
        phoneNo: json["phone_no"] ?? "",
        email: json["email"] ?? "",
        departmentId: json["department_id"] ?? "",
        dateOfBrith: json["date_of_brith"] ?? "",
        home: json["home"] ?? "",
        homeNo: json["home_no"] ?? "",
        workPhone: json["work_phone"] ?? "",
        hourlyRate: json["hourly_rate"] ?? "",
        salary: json["salary"] ?? "",
        startDate: json["start_date"] ?? "",
        lastDayOfWork: json["last_day_of_work"] ?? "",
        companyid: json["companyid"] ?? "",
        createdby: json["createdby"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        createdAt: json["created_at"] ?? "",
        photo: json["photo"] ?? "",
        id: json["id"] ?? 0,
      );

  // Map<String, dynamic> toJson() => {
  //     "first_name": firstName,
  //     "middle_name": middleName,
  //     "last_name": lastName,
  //     "password": password,
  //     "address": address,
  //     "phone_no": phoneNo,
  //     "email": email,
  //     "department_id": departmentId,
  //     "date_of_brith": "${dateOfBrith.year.toString().padLeft(4, '0')}-${dateOfBrith.month.toString().padLeft(2, '0')}-${dateOfBrith.day.toString().padLeft(2, '0')}",
  //     "home": home,
  //     "home_no": homeNo,
  //     "work_phone": workPhone,
  //     "hourly_rate": hourlyRate,
  //     "salary": salary,
  //     "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
  //     "last_day_of_work": lastDayOfWork,
  //     "companyid": companyid,
  //     "createdby": createdby,
  //     "updated_at": updatedAt.toIso8601String(),
  //     "created_at": createdAt.toIso8601String(),
  //     "id": id,
  // };
}
