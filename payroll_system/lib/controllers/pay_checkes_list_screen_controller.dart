import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:payroll_system/models/Pay_checkes_list_model/pay_checkes_list_screen_model.dart';
import 'package:payroll_system/models/approval_paycheckes_manage_screen_model/approval_paycheckes_delete_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import 'package:permission_handler/permission_handler.dart';

class PayCheckesListScreenController extends GetxController {
  String companyId = Get.arguments[0];
  String companyName = Get.arguments[1];
  final TextEditingController textSearchEditingController =
      TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  RxString selectedValue = "Choose Option".obs;
  List<String> isPayperList = ["Choose Option", "Salary", "Hourly"];
  List<PayCheckesListData> payCheckesListData = [];
  List<PayCheckesListData> filterPayChecksListData = [];
  TextEditingController hourlyRateController = TextEditingController();

  UserPreference userPreference = UserPreference();

  List<String> filterList = ["All", "Approved", "Not Approved"];
  RxString selectedFilterValue = "All".obs;

  String prefsDateFormat = "";



  Future<void> getPaycheckesListFunction() async {
    isLoading(true);
    String url = ApiUrl.getPayCheckesListApi;
    log("getPaycheckesListFunction url:$url");
    log("getPaycheckesListFunction companyId: $companyId");

    int userId = await userPreference.getIntValueFromPrefs(keyId: UserPreference.userIdKey);

    try {
      Map<String, dynamic> bodyData = {
        "userid": "$userId",
        "cid": companyId,
        "pay_period": "hourly"
      };
      log('bodyData : $bodyData');
      http.Response response = await http.post(Uri.parse(url), body: bodyData);
      log("getPaycheckesListFunction response  : ${response.body}");

      PayCheckListModel payCheckListModel =
          PayCheckListModel.fromJson(json.decode(response.body));

      isSuccessStatus = payCheckListModel.success.obs;
      if (isSuccessStatus.value) {
        payCheckesListData.clear();
        payCheckesListData.addAll(payCheckListModel.data);
        filterPayChecksListData = payCheckesListData;

        log('payCheckesListData : ${payCheckesListData.length}');
        log('filterPayChecksListData : ${filterPayChecksListData.length}');
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteHourlyPaychecksFunction(String approvalId) async {
    isLoading(true);
    String url =
        "${ApiUrl.deleteApprovePayCheckesListApi}$companyId/$approvalId";
    log('Delete deleteApprovalFunction Api Url :$url');
    log('Delete deleteApprovalFunction companyId :$companyId');
    log('Delete deleteApprovalFunction approvalId :$approvalId');

    try {
      http.Response response = await http.get(Uri.parse(url));
      log('response : ${response.body}');

      ApprovalDeleteModel approvalDeleteModel =
      ApprovalDeleteModel.fromJson(json.decode(response.body));
      isSuccessStatus = approvalDeleteModel.success.obs;

      if (isSuccessStatus.value) {
        Fluttertoast.showToast(msg: approvalDeleteModel.messege);
        Get.back();
        await getPaycheckesListFunction();

        // Get.back();
      } else {
        log('deleteApprovalFunction Else');
      }
    } catch (e) {
      log('deleteApprovalFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  initMethod() async {
    prefsDateFormat = await userPreference.getStringValueFromPrefs(keyId: UserPreference.dateFormatKey);
    log('prefsDateFormat Init Method : $prefsDateFormat');
    await getPaycheckesListFunction();
  }


  /// Download Pdf
  Future<void> downloadFile() async {
    Dio dio = Dio();

    final status = await Permission.storage.request();
    if (status.isGranted) {
      String dirLocation = "";
      dirLocation = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
      log('dirLocation : $dirLocation');

      try {
        // await dio.download();
      } catch(e) {
        log('downloadFile Error :$e');
        rethrow;
      }
    }

  }


}
