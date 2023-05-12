// To parse this JSON data, do
//
//     final payrollCreateModel = payrollCreateModelFromJson(jsonString);

import 'dart:convert';

PayrollCreateModel? payrollCreateModelFromJson(String str) =>
    PayrollCreateModel.fromJson(json.decode(str));

String payrollCreateModelToJson(PayrollCreateModel? data) =>
    json.encode(data!.toJson());

class PayrollCreateModel {
  PayrollCreateModel({
    this.success,
    this.messege,
    this.data,
  });

  final bool? success;
  final String? messege;
  final PayrollCreateData? data;

  factory PayrollCreateModel.fromJson(Map<String, dynamic> json) =>
      PayrollCreateModel(
        success: json["success"],
        messege: json["messege"],
        data: PayrollCreateData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        // "Data": data!.toJson(),
      };
}

class PayrollCreateData {
  PayrollCreateData({
    this.startdate,
    this.enddate,
    this.days,
    this.payPeriod,
    this.salary,
    this.ragularhour,
    this.overtime,
    this.bonus,
    this.otherearning,
    this.commission,
    this.paydate,
    this.companyid,
    this.employeeid,
    this.subTotal,
    this.finalAmount,
    this.createdby,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  final String? startdate;
  final String? enddate;
  final int? days;
  final String? payPeriod;
  final String? salary;
  final String? ragularhour;
  final String? overtime;
  final String? bonus;
  final String? otherearning;
  final String? commission;
  final String? paydate;
  final String? companyid;
  final String? employeeid;
  final String? subTotal;
  final int? finalAmount;
  final String? createdby;
  final String? updatedAt;
  final String? createdAt;
  final int? id;

  factory PayrollCreateData.fromJson(Map<String, dynamic> json) =>
      PayrollCreateData(
        startdate: json["startdate"] ?? "",
        enddate: json["enddate"] ?? "",
        days: json["days"] ?? 0,
        payPeriod: json["pay_period"] ?? "",
        salary: json["salary"] ?? "",
        ragularhour: json["ragularhour"] ?? "",
        overtime: json["overtime"] ?? "",
        bonus: json["bonus"] ?? "",
        otherearning: json["otherearning"] ?? "",
        commission: json["commission"] ?? "",
        paydate: json["paydate"] ?? "",
        companyid: json["companyid"] ?? "",
        employeeid: json["employeeid"] ?? "",
        subTotal: json["sub_total"] ?? "",
        finalAmount: json["final_amount"] ?? 0,
        createdby: json["createdby"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        createdAt: json["created_at"] ?? "",
        id: json["id"] ?? 0,
      );

  // Map<String, dynamic> toJson() => {
  //     "startdate": startdate,
  //     "enddate": enddate,
  //     "days": days,
  //     "pay_period": payPeriod,
  //     "salary": salary,
  //     "ragularhour": ragularhour,
  //     "overtime": overtime,
  //     "bonus": bonus,
  //     "otherearning": otherearning,
  //     "commission": commission,
  //     "paydate": paydate,
  //     "companyid": companyid,
  //     "employeeid": employeeid,
  //     "sub_total": subTotal,
  //     "final_amount": finalAmount,
  //     "createdby": createdby,
  //     "updated_at": updatedAt?.toIso8601String(),
  //     "created_at": createdAt?.toIso8601String(),
  //     "id": id,
  // };
}
