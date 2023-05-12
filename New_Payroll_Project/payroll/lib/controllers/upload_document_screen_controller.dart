import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:payroll/utils/api_url.dart';
import 'package:payroll/utils/extension_methods/user_preference.dart';
import 'package:payroll/models/uplode_document_screen_model/delete_document_model.dart';
import 'package:payroll/models/uplode_document_screen_model/uplode_document_screen_model.dart';
import 'package:payroll/models/employee_upload_document_models/delete_employee_document_model.dart';
import 'package:payroll/screen/employee_screens/document_download_screen/document_download_screen.dart';

class UploadDocumentScreenController extends GetxController {
  String employeeId = Get.arguments[0];
  String employeeName = Get.arguments[1];
  // String companyId = Get.arguments[2];

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  UserPreference userPreference = UserPreference();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<String> documentTypeList = ["Choose Option", "W-4", "I-9", "W-2s"];
  RxString documentSelectedTypeValue = "Choose Option".obs;

  List<File> selectedDocumentList = [];
  List<DocumentDatumData> uploadedDocumentList = [];

  bool uploadDocumentPermission = false;

  // final documentDownloadScreenController =
  //     Get.find<DocumentDownloadScreenController>();
  // final documentDownloadScreenController = Get.find<DocumentDownloadScreenController>();

  Future<void> pickDocumentFunction() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf'],
    );

    if (result != null) {
      isLoading(true);

      for (int i = 0; i < result.paths.length; i++) {
        selectedDocumentList.add(File(result.paths[i]!));
      }
      log('files Inner :${selectedDocumentList.length}');
      isLoading(false);
    } else {
      // User canceled the picker
    }
  }

  Future<void> getDocumentFunction() async {
    isLoading(true);
    String url = "${ApiUrl.getEmployeeDocumentApi}$employeeId";
    log('Employee Document Api Url : $url');
    log('employeeId : $employeeId');

    try {
      http.Response response = await http.get(Uri.parse(url));
      log("getEmployeeDocumentFunction  :${response.body}");

      DocumentModel documentModel =
          DocumentModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = documentModel.success;

      if (isSuccessStatus.value) {
        uploadedDocumentList.clear();
        uploadedDocumentList.addAll(documentModel.data);
        log('employeeUploadedDocumentList Length : ${uploadedDocumentList.length}');
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

      DeleteAndUploadDocumentModel deleteAndUploadDocumentModel =
          DeleteAndUploadDocumentModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = deleteAndUploadDocumentModel.success;

      if (isSuccessStatus.value) {
        Fluttertoast.showToast(msg: deleteAndUploadDocumentModel.messege);
        uploadedDocumentList.removeAt(index);
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

  Future<void> uploadDocumentFunction() async {
    Fluttertoast.showToast(msg: "Please wait");
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

      for (int i = 0; i < selectedDocumentList.length; i++) {
        request.files.add(await http.MultipartFile.fromPath(
            "fileupload[]", selectedDocumentList[i].path));
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
          selectedDocumentList.clear();
          documentSelectedTypeValue = "Choose Option".obs;

          Get.off(() => DocumentDownloadScreen(),
              arguments: [employeeId.toString(), employeeName]);

          // await    documentDownloadScreenController.getEmployeeDocumentFunction();
        } else {
          log('uploadEmployeeDocumentFunction Else');
          log('uploadEmployeeDocumentModel : ${uploadEmployeeDocumentModel.messege}');
        }
      });
    } catch (e) {
      log('uploadEmployeeDocumentFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);

      // await documentDownloadScreenController.getEmployeeDocumentFunction();
    }
    // await getDocumentFunction();
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  initMethod() async {
    log('employeeId : $employeeId');
    // log('companyId : $companyId');
    // await getDocumentFunction();
  }
}
