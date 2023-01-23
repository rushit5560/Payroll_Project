// To parse this JSON data, do
//
//     final payCheckDwanloadListModel = payCheckDwanloadListModelFromJson(jsonString);

import 'dart:convert';

PayCheckDwanloadListModel payCheckDwanloadListModelFromJson(String str) =>
    PayCheckDwanloadListModel.fromJson(json.decode(str));

String payCheckDwanloadListModelToJson(PayCheckDwanloadListModel data) =>
    json.encode(data.toJson());

class PayCheckDwanloadListModel {
  PayCheckDwanloadListModel({
    required this.success,
    required this.messege,
    required this.data,
    required this.payroll,
  });

  final bool success;
  final String messege;
  final List<PayCheckDwanloadListData> data;
  final List<PayCheckDwanloadListData> payroll;

  factory PayCheckDwanloadListModel.fromJson(Map<String, dynamic> json) =>
      PayCheckDwanloadListModel(
        success: json["success"],
        messege: json["messege"],
        data: List<PayCheckDwanloadListData>.from(
            json["Data"].map((x) => PayCheckDwanloadListData.fromJson(x))),
        payroll: List<PayCheckDwanloadListData>.from(
            json["payroll"].map((x) => PayCheckDwanloadListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
        "payroll": List<dynamic>.from(payroll.map((x) => x.toJson())),
      };
}

class PayCheckDwanloadListData {
  PayCheckDwanloadListData({
    required this.id,
    required this.type,
    required this.startdate,
    required this.enddate,
    required this.days,
    required this.payPeriod,
    required this.companyid,
    required this.employeeid,
    required this.salary,
    required this.ragularhour,
    required this.holidaypay,
    required this.overtime,
    required this.bonus,
    required this.otherearning,
    required this.sickpay,
    required this.vacationhours,
    required this.commission,
    required this.paydate,
    required this.tax,
    required this.tip,
    required this.subTotal,
    required this.finalAmount,
    required this.isActive,
    required this.memo,
    required this.approvepaychecks,
    required this.createdby,
    required this.modifiedby,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.eid,
    required this.address,
    required this.mobileNumber,
    required this.departmentId,
    required this.locationId,
    required this.street,
    required this.town,
    required this.state,
    required this.city,
    required this.zipcode,
    required this.email,
    required this.hourlyRate,
  });

  final int id;
  final String type;
  final String startdate;
  final String enddate;
  final String days;
  final String payPeriod;
  final String companyid;
  final String employeeid;
  final String salary;
  final String ragularhour;
  final String holidaypay;
  final String overtime;
  final String bonus;
  final String otherearning;
  final String sickpay;
  final String vacationhours;
  final String commission;
  final String paydate;
  final String tax;
  final String tip;
  final String subTotal;
  final String finalAmount;
  final String isActive;
  final String memo;
  final String approvepaychecks;
  final String createdby;
  final String modifiedby;
  final String createdAt;
  final String updatedAt;
  final String firstName;
  final String middleName;
  final String lastName;
  final String eid;
  final String address;
  final String mobileNumber;
  final String departmentId;
  final String locationId;
  final String street;
  final String town;
  final String state;
  final String city;
  final String zipcode;
  final String email;
  final String hourlyRate;

  factory PayCheckDwanloadListData.fromJson(Map<String, dynamic> json) =>
      PayCheckDwanloadListData(
        id: json["id"] ?? 0,
        type: json["type"] ?? "",
        startdate: json["startdate"] ?? "",
        enddate: json["enddate"] ?? "",
        days: json["days"] ?? "",
        payPeriod: json["pay_period"] ?? "",
        companyid: json["companyid"] ?? "",
        employeeid: json["employeeid"] ?? "",
        salary: json["salary"] ?? "",
        ragularhour: json["ragularhour"] ?? "",
        holidaypay: json["holidaypay"] ?? "",
        overtime: json["overtime"] ?? "",
        bonus: json["bonus"] ?? "",
        otherearning: json["otherearning"] ?? "",
        sickpay: json["sickpay"] ?? "",
        vacationhours: json["vacationhours"] ?? "",
        commission: json["commission"] ?? "",
        paydate: json["paydate"] ?? "",
        tax: json["tax"] ?? "",
        tip: json["tip"] ?? "",
        subTotal: json["sub_total"] ?? "",
        finalAmount: json["final_amount"] ?? "",
        isActive: json["is_active"] ?? "",
        memo: json["memo"] ?? "",
        approvepaychecks: json["approvepaychecks"] ?? "",
        createdby: json["createdby"] ?? "",
        modifiedby: json["modifiedby"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        firstName: json["first_name"] ?? "",
        middleName: json["middle_name"] ?? "",
        lastName: json["last_name"] ?? "",
        eid: json["eid"] ?? "",
        address: json["address"] ?? "",
        mobileNumber: json["mobile_number"] ?? "",
        departmentId: json["department_id"] ?? "",
        locationId: json["location_id"] ?? "",
        street: json["street"] ?? "",
        town: json["town"] ?? "",
        state: json["state"] ?? "",
        city: json["city"] ?? "",
        zipcode: json["zipcode"] ?? "",
        email: json["email"] ?? "",
        hourlyRate: json["hourly_rate"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "startdate": startdate,
        "enddate": enddate,
        "days": days,
        "pay_period": payPeriod,
        "companyid": companyid,
        "employeeid": employeeid,
        "salary": salary,
        "ragularhour": ragularhour,
        "holidaypay": holidaypay,
        "overtime": overtime,
        "bonus": bonus,
        "otherearning": otherearning,
        "sickpay": sickpay,
        "vacationhours": vacationhours,
        "commission": commission,
        "paydate": paydate,
        "tax": tax,
        "tip": tip,
        "sub_total": subTotal,
        "final_amount": finalAmount,
        "is_active": isActive,
        "memo": memo,
        "approvepaychecks": approvepaychecks,
        "createdby": createdby,
        "modifiedby": modifiedby,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "eid": eid,
        "address": address,
        "mobile_number": mobileNumber,
        "department_id": departmentId,
        "location_id": locationId,
        "street": street,
        "town": town,
        "state": state,
        "city": city,
        "zipcode": zipcode,
        "email": email,
        "hourly_rate": hourlyRate,
      };
}
