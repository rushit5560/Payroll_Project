import 'dart:convert';

DocumentModel employeeDocumentModelFromJson(String str) =>
    DocumentModel.fromJson(json.decode(str));

String employeeDocumentModelToJson(DocumentModel data) =>
    json.encode(data.toJson());

class DocumentModel {
  DocumentModel({
    required this.success,
    required this.messege,
    required this.data,
  });

  bool success;
  String messege;
  List<DocumentDatumData> data;

  factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
        success: json["success"] ?? false,
        messege: json["messege"] ?? "",
        data: List<DocumentDatumData>.from((json["Data"] ?? [])
            .map((x) => DocumentDatumData.fromJson(x ?? {}))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messege": messege,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DocumentDatumData {
  DocumentDatumData({
    required this.id,
    required this.name,
    required this.doctype,
    required this.employeeId,
    required this.createdby,
    // required this.modifiedby,
    // required this.createdAt,
    // required this.updatedAt,
  });

  int id;
  String name;
  String doctype;
  String employeeId;
  String createdby;
  // dynamic modifiedby;
  // DateTime createdAt;
  // DateTime updatedAt;

  factory DocumentDatumData.fromJson(Map<String, dynamic> json) =>
      DocumentDatumData(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        doctype: json["doctype"] ?? "",
        employeeId: json["employee_id"] ?? "",
        createdby: json["createdby"] ?? "",
        // modifiedby: json["modifiedby"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "doctype": doctype,
        "employee_id": employeeId,
        "createdby": createdby,
        // "modifiedby": modifiedby,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
      };
}
