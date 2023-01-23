import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:payroll_system/models/employee_upload_document_models/delete_employee_document_model.dart';
import 'package:payroll_system/models/employee_upload_document_models/employee_document_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';

class EmployeeUploadDocumentScreenController extends GetxController {
  String employeeName = Get.arguments[0];
  String employeeId = Get.arguments[1];
  String companyId = Get.arguments[2];

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  UserPreference userPreference = UserPreference();
  final TextEditingController textSearchEditingController =
      TextEditingController();


  List<String> documentTypeList = ["Choose Option", "W-4", "I-9", "W-2s"];
  RxString documentSelectedTypeValue = "Choose Option".obs;

  List<File> employeeSelectedDocumentList = [];
  List<DocumentDatum> employeeUploadedDocumentList = [];
  List<DocumentDatum> searchEmployeeUploadedDocumentList = [];

  Future<void> pickEmployeeDocumentFunction() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf'],
    );

    if (result != null) {
      isLoading(true);

      for (int i = 0; i < result.paths.length; i++) {
        employeeSelectedDocumentList.add(File(result.paths[i]!));
      }
      log('files Inner :${employeeSelectedDocumentList.length}');
      isLoading(false);
    } else {
      // User canceled the picker
    }
  }

  Future<void> getEmployeeDocumentFunction() async {
    isLoading(true);
    String url = "${ApiUrl.getEmployeeDocumentApi}$employeeId";
    log('Employee Document Api Url : $url');

    try {
      http.Response response = await http.get(Uri.parse(url));
      log("getEmployeeDocumentFunction  :${response.body}");

      EmployeeDocumentModel employeeDocumentModel =
          EmployeeDocumentModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = employeeDocumentModel.success;

      if (isSuccessStatus.value) {
        employeeUploadedDocumentList.clear();
        employeeUploadedDocumentList.addAll(employeeDocumentModel.data);
        searchEmployeeUploadedDocumentList = employeeUploadedDocumentList;

        log('employeeUploadedDocumentList Length : ${employeeUploadedDocumentList.length}');
      } else {
        log('getEmployeeDocumentFunction Else');
      }
    } catch (e) {
      log('getEmployeeDocumentFunction Error : $e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteDocumentFunction(String docId, int index) async {
    isLoading(true);
    String url = "${ApiUrl.deleteEmployeeDocumentApi}$docId";
    log('deleteDocumentFunction Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));
      log('deleteDocumentFunction Response : ${response.body}');

      DeleteAndUploadEmployeeDocumentModel deleteEmployeeDocumentModel =
          DeleteAndUploadEmployeeDocumentModel.fromJson(
              json.decode(response.body));
      isSuccessStatus.value = deleteEmployeeDocumentModel.success;

      if (isSuccessStatus.value) {
        Fluttertoast.showToast(msg: deleteEmployeeDocumentModel.messege);
        employeeUploadedDocumentList.removeAt(index);
        Get.back();
      } else {
        log('deleteDocumentFunction Else');
      }
    } catch (e) {
      log('deleteDocumentFunction Error : $e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> uploadEmployeeDocumentFunction() async {
    isLoading(true);
    String url = ApiUrl.uploadEmployeeDocumentApi;
    log('uploadEmployeeDocumentFunction Api Url :$url');

    int userId = await userPreference.getIntValueFromPrefs(
        keyId: UserPreference.userIdKey);

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['employee_id'] = employeeId;
      request.fields['userid'] = "$userId";
      request.fields['doctype'] = documentSelectedTypeValue.value;

      // request.files.add(await http.MultipartFile.fromPath("fileupload[]", employeeSelectedDocumentList));

      for (int i = 0; i < employeeSelectedDocumentList.length; i++) {
        request.files.add(await http.MultipartFile.fromPath(
            "fileupload[]", employeeSelectedDocumentList[i].path));
      }

      log('request.fields : ${request.fields}');
      log('request.files : ${request.files}');
      var response = await request.send();

      response.stream
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .listen((value) async {
        log('value : $value');
        DeleteAndUploadEmployeeDocumentModel uploadEmployeeDocumentModel =
            DeleteAndUploadEmployeeDocumentModel.fromJson(json.decode(value));
        isSuccessStatus.value = uploadEmployeeDocumentModel.success;
        log('uploadEmployeeDocumentModel : ${uploadEmployeeDocumentModel.messege}');

        if (isSuccessStatus.value) {
          Fluttertoast.showToast(msg: uploadEmployeeDocumentModel.messege);
          employeeSelectedDocumentList.clear();
          documentSelectedTypeValue = "Choose Option".obs;
        } else {
          log('uploadEmployeeDocumentFunction Else');
          log('uploadEmployeeDocumentModel : ${uploadEmployeeDocumentModel.messege}');
        }
      });
    } catch (e) {
      log('uploadEmployeeDocumentFunction Error :$e');
      rethrow;
    }
    // finally {
    //   isLoading(false);
    // }
    await getEmployeeDocumentFunction();
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  initMethod() async {
    log('employeeId : $employeeId');
    log('companyId : $companyId');
    await getEmployeeDocumentFunction();
  }
}
