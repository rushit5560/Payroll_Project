import 'dart:convert';

PaychecksCreateModel paychecksCreateModelFromJson(String str) => PaychecksCreateModel.fromJson(json.decode(str));

String paychecksCreateModelToJson(PaychecksCreateModel data) => json.encode(data.toJson());

class PaychecksCreateModel {
  PaychecksCreateModel({
    required this.success,
    required this.messege,
    // this.data,
  });

  bool success;
  String messege;
  // Data data;

  factory PaychecksCreateModel.fromJson(Map<String, dynamic> json) => PaychecksCreateModel(
    success: json["success"] ?? false,
    messege: json["messege"] ?? "",
    // data: Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "messege": messege,
    // "Data": data.toJson(),
  };
}

/*class Data {
  Data({
    this.type,
    this.startdate,
    this.enddate,
    this.days,
    this.payPeriod,
    this.ragularhour,
    this.holidaypay,
    this.overtime,
    this.bonus,
    this.otherearning,
    this.commission,
    this.sickpay,
    this.vacationhours,
    this.paydate,
    this.companyid,
    this.employeeid,
    this.subTotal,
    this.finalAmount,
    this.memo,
    this.tip,
    this.tax,
    this.approvepaychecks,
    this.createdby,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String type;
  String startdate;
  String enddate;
  String days;
  String payPeriod;
  String ragularhour;
  String holidaypay;
  String overtime;
  String bonus;
  String otherearning;
  String commission;
  String sickpay;
  String vacationhours;
  String paydate;
  String companyid;
  String employeeid;
  int subTotal;
  int finalAmount;
  String memo;
  String tip;
  String tax;
  String approvepaychecks;
  String createdby;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"],
    startdate: json["startdate"],
    enddate: json["enddate"],
    days: json["days"],
    payPeriod: json["pay_period"],
    ragularhour: json["ragularhour"],
    holidaypay: json["holidaypay"],
    overtime: json["overtime"],
    bonus: json["bonus"],
    otherearning: json["otherearning"],
    commission: json["commission"],
    sickpay: json["sickpay"],
    vacationhours: json["vacationhours"],
    paydate: json["paydate"],
    companyid: json["companyid"],
    employeeid: json["employeeid"],
    subTotal: json["sub_total"],
    finalAmount: json["final_amount"],
    memo: json["memo"],
    tip: json["tip"],
    tax: json["tax"],
    approvepaychecks: json["approvepaychecks"],
    createdby: json["createdby"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "startdate": startdate,
    "enddate": enddate,
    "days": days,
    "pay_period": payPeriod,
    "ragularhour": ragularhour,
    "holidaypay": holidaypay,
    "overtime": overtime,
    "bonus": bonus,
    "otherearning": otherearning,
    "commission": commission,
    "sickpay": sickpay,
    "vacationhours": vacationhours,
    "paydate": paydate,
    "companyid": companyid,
    "employeeid": employeeid,
    "sub_total": subTotal,
    "final_amount": finalAmount,
    "memo": memo,
    "tip": tip,
    "tax": tax,
    "approvepaychecks": approvepaychecks,
    "createdby": createdby,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}*/
