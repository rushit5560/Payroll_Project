import 'dart:convert';

EmployeeDocumentModel employeeDocumentModelFromJson(String str) =>
    EmployeeDocumentModel.fromJson(json.decode(str));

String employeeDocumentModelToJson(EmployeeDocumentModel data) =>
    json.encode(data.toJson());

class EmployeeDocumentModel {
  EmployeeDocumentModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  bool success;
  String messege;
  List<DocumentDatum> data;

  factory EmployeeDocumentModel.fromJson(Map<String, dynamic> json) =>
      EmployeeDocumentModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        data: List<DocumentDatum>.from(
            (json["Data"] ?? []).map((x) => DocumentDatum.fromJson(x ?? {}))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DocumentDatum {
  DocumentDatum({
    required this.id,
    required this.name,
    required this.doctype,
    required this.employeeId,
    // required this.createdby,
    // required this.modifiedby,
    // required this.createdAt,
    // required this.updatedAt,
  });

  int id;
  String name;
  String doctype;
  String employeeId;
  // String createdby;
  // dynamic modifiedby;
  // DateTime createdAt;
  // DateTime updatedAt;

  factory DocumentDatum.fromJson(Map<String, dynamic> json) => DocumentDatum(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        doctype: json["doctype"] ?? "",
        employeeId: json["employee_id"] ?? "",
        // createdby: json["createdby"] ?? "",
        // modifiedby: json["modifiedby"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "doctype": doctype,
        "employee_id": employeeId,
        // "createdby": createdby,
        // "modifiedby": modifiedby,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
      };
}
