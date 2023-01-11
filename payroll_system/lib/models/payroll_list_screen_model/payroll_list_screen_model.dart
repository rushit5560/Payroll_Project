// To parse this JSON data, do
//
//     final payrollListModel = payrollListModelFromJson(jsonString);

import 'dart:convert';

PayrollListModel payrollListModelFromJson(String str) =>
    PayrollListModel.fromJson(json.decode(str));

String payrollListModelToJson(PayrollListModel data) =>
    json.encode(data.toJson());

class PayrollListModel {
  PayrollListModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  final bool success;
  final String messege;
  final List<PayrollListData> data;

  factory PayrollListModel.fromJson(Map<String, dynamic> json) =>
      PayrollListModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        data: List<PayrollListData>.from(
            json["Data"].map((x) => PayrollListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        // "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PayrollListData {
  PayrollListData({
    required this.id,
    required this.startdate,
    required this.enddate,
    required this.days,
    required this.payPeriod,
    required this.companyid,
    required this.employeeid,
    required this.salary,
    required this.ragularhour,
    required this.overtime,
    required this.bonus,
    required this.otherearning,
    required this.sickpay,
    required this.vacationhours,
    required this.commission,
    required this.paydate,
    required this.tax,
    required this.subTotal,
    required this.finalAmount,
    required this.isActive,
    required this.createdby,
    required this.modifiedby,
    required this.createdAt,
    required this.updatedAt,
    required this.companyname,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.eid,
  });

  final String id;
  final String startdate;
  final String enddate;
  final String days;
  final String payPeriod;
  final String companyid;
  final String employeeid;
  final String salary;
  final String ragularhour;
  final String overtime;
  final String bonus;
  final String otherearning;
  final String sickpay;
  final String vacationhours;
  final String commission;
  final String paydate;
  final String tax;
  final String subTotal;
  final String finalAmount;
  final String isActive;
  final String createdby;
  final String modifiedby;
  final String createdAt;
  final String updatedAt;
  final String companyname;
  final String firstName;
  final String middleName;
  final String lastName;
  final String eid;

  factory PayrollListData.fromJson(Map<String, dynamic> json) =>
      PayrollListData(
        id: json["id"] ?? "0",
        startdate: json["startdate"] ?? "",
        enddate: json["enddate"] ?? "",
        days: json["days"] ?? "",
        payPeriod: json["pay_period"] ?? "",
        companyid: json["companyid"] ?? "0",
        employeeid: json["employeeid"] ?? "0",
        salary: json["salary"] ?? "",
        ragularhour: json["ragularhour"] ?? "0",
        overtime: json["overtime"] ?? "0",
        bonus: json["bonus"] ?? "0",
        otherearning: json["otherearning"] ?? "0",
        sickpay: json["sickpay"] ?? "",
        vacationhours: json["vacationhours"] ?? "",
        commission: json["commission"] ?? "0",
        paydate: json["paydate"] ?? "",
        tax: json["tax"] ?? "",
        subTotal: json["sub_total"] ?? "",
        finalAmount: json["final_amount"] ?? "",
        isActive: json["is_active"] ?? "",
        createdby: json["createdby"] ?? "0",
        modifiedby: json["modifiedby"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        companyname: json["companyname"] ?? "",
        firstName: json["first_name"] ?? "",
        middleName: json["middle_name"] ?? "",
        lastName: json["last_name"] ?? "",
        eid: json["eid"] ?? "0",
      );

  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "startdate": startdate.toIso8601String(),
  //     "enddate": enddate.toIso8601String(),
  //     "days": days,
  //     "pay_period": payPeriod,
  //     "companyid": companyid,
  //     "employeeid": employeeid,
  //     "salary": salary == null ? null : salary,
  //     "ragularhour": ragularhour == null ? null : ragularhour,
  //     "overtime": overtime,
  //     "bonus": bonus,
  //     "otherearning": otherearning,
  //     "sickpay": sickpay,
  //     "vacationhours": vacationhours,
  //     "commission": commission,
  //     "paydate": paydate.toIso8601String(),
  //     "tax": tax,
  //     "sub_total": subTotal,
  //     "final_amount": finalAmount,
  //     "is_active": isActive,
  //     "createdby": createdby,
  //     "modifiedby": modifiedby,
  //     "created_at": createdAt.toIso8601String(),
  //     "updated_at": updatedAt.toIso8601String(),
  //     "companyname": companyname,
  //     "first_name": firstName,
  //     "middle_name": middleName,
  //     "last_name": lastName,
  //     "eid": eid,
  // };
}
