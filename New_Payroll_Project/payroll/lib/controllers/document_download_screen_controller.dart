import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:payroll/models/employee_upload_document_models/employee_document_model.dart';
import 'package:payroll/utils/api_url.dart';
import 'package:payroll/utils/extension_methods/user_preference.dart';

class DocumentDownloadScreenController extends GetxController {
  String employeeId = Get.arguments[0];
  String employeeName = Get.arguments[1];

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  UserPreference userPreference = UserPreference();

  TextEditingController textSearchEditingController = TextEditingController();

  List<DocumentDatum> employeeUploadedDocumentList = [];
  List<DocumentDatum> searchEmployeeUploadedDocumentList = [];

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

  @override
  void onInit() {
    getLoggedInEmployeeIdFunction();
    super.onInit();
  }

  getLoggedInEmployeeIdFunction() async {
    await getEmployeeDocumentFunction();
  }
}
