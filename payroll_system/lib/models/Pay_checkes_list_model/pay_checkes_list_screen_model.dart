// To parse this JSON data, do
//
//     final payCheckListModel = payCheckListModelFromJson(jsonString);

import 'dart:convert';

PayCheckListModel payCheckListModelFromJson(String str) =>
    PayCheckListModel.fromJson(json.decode(str));

String payCheckListModelToJson(PayCheckListModel data) =>
    json.encode(data.toJson());

class PayCheckListModel {
  PayCheckListModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  final bool success;
  final String messege;
  final List<PayCheckesListData> data;

  factory PayCheckListModel.fromJson(Map<String, dynamic> json) =>
      PayCheckListModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        data: List<PayCheckesListData>.from(
            json["Data"].map((x) => PayCheckesListData.fromJson(x)) ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        // "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PayCheckesListData {
  PayCheckesListData({
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
    required this.holidaypay,
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
    required this.employeehourlyRate,
  });

  final String id;
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
  final String holidaypay;
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
  final String employeehourlyRate;

  factory PayCheckesListData.fromJson(Map<String, dynamic> json) =>
      PayCheckesListData(
        id: (json["id"] ?? 0).toString(),
        type: json["type"] ?? "",
        startdate: json["startdate"] ?? "",
        enddate: json["enddate"] ?? "",
        days: json["days"] ?? "",
        payPeriod: json["pay_period"] ?? "",
        companyid: (json["companyid"] ?? 0).toString(),
        employeeid: (json["employeeid"] ?? 0).toString(),
        salary: json["salary"] ?? "",
        ragularhour: (json["ragularhour"] ?? 0).toString(),
        overtime: (json["overtime"] ?? 0).toString(),
        holidaypay: (json["holidaypay"] ?? 0).toString(),
        bonus: json["bonus"] ?? "",
        otherearning: json["otherearning"] ?? "",
        sickpay: json["sickpay"] ?? "",
        vacationhours: json["vacationhours"] ?? "",
        commission: json["commission"] ?? "",
        paydate: json["paydate"] ?? "",
        tax: (json["tax"] ?? 0).toString(),
        tip: (json["tip"] ?? 0).toString(),
        subTotal: json["sub_total"] ?? "",
        finalAmount: json["final_amount"] ?? "",
        isActive: json["is_active"] ?? "",
        memo: json["memo"] ?? "",
        approvepaychecks: json["approvepaychecks"] ?? "",
        createdby: (json["createdby"] ?? 0).toString(),
        modifiedby: json["modifiedby"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        companyname: json["companyname"] ?? "",
        firstName: json["first_name"] ?? "",
        middleName: json["middle_name"] ?? "",
        lastName: json["last_name"] ?? "",
        eid: (json["eid"] ?? 0).toString(),
        employeehourlyRate: (json["employeehourly_rate"] ?? 0).toString(),
      );

}
