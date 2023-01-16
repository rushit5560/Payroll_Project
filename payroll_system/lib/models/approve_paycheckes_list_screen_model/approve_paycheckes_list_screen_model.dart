// To parse this JSON data, do
//
//     final payCheckListModel = payCheckListModelFromJson(jsonString);

import 'dart:convert';

ApprovePayCheckListModel payCheckListModelFromJson(String str) =>
    ApprovePayCheckListModel.fromJson(json.decode(str));

String payCheckListModelToJson(ApprovePayCheckListModel data) =>
    json.encode(data.toJson());

class ApprovePayCheckListModel {
  ApprovePayCheckListModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  final bool success;
  final String messege;
  final List<ApprovePayCheckListData> data;

  factory ApprovePayCheckListModel.fromJson(Map<String, dynamic> json) =>
      ApprovePayCheckListModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        data: List<ApprovePayCheckListData>.from(
            json["Data"].map((x) => ApprovePayCheckListData.fromJson(x)) ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        // "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ApprovePayCheckListData {
  ApprovePayCheckListData({
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
    required this.companyname,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.eid,
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
  final String companyname;

  final String firstName;
  final String middleName;
  final String lastName;
  final String eid;

  factory ApprovePayCheckListData.fromJson(Map<String, dynamic> json) =>
      ApprovePayCheckListData(
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
        companyname: json["companyname"] ?? "",
        firstName: json["first_name"] ?? "",
        middleName: json["middle_name"] ?? "",
        lastName: json["last_name"] ?? "",
        eid: json["eid"] ?? "",
      );

  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "type": type,
  //     "startdate": startdate.toIso8601String(),
  //     "enddate": enddate.toIso8601String(),
  //     "days": days,
  //     "pay_period": payPeriod,
  //     "companyid": companyid,
  //     "employeeid": employeeid,
  //     "salary": salary,
  //     "ragularhour": ragularhour,
  //     "overtime": overtime,
  //     "bonus": bonus,
  //     "otherearning": otherearning,
  //     "sickpay": sickpay,
  //     "vacationhours": vacationhours,
  //     "commission": commission,
  //     "paydate": paydate.toIso8601String(),
  //     "tax": tax,
  //     "tip": tip,
  //     "sub_total": subTotal,
  //     "final_amount": finalAmount,
  //     "is_active": isActive,
  //     "memo": memo,
  //     "approvepaychecks": approvepaychecks,
  //     "createdby": createdby,
  //     "modifiedby": modifiedby,
  //     "created_at": createdAt.toIso8601String(),
  //     "updated_at": updatedAt.toIso8601String(),
  //     "first_name": firstName,
  //     "middle_name": middleName,
  //     "last_name": lastName,
  //     "eid": eid,
  // };
}
