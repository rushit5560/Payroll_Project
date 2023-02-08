import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/controllers/approve_paychecks_list_screen_controller.dart';
import 'package:payroll_system/models/approval_paycheckes_manage_screen_model/approval_paycheckes_delete_model.dart';
import 'package:payroll_system/models/approve_paycheckes_list_screen_model/approve_paycheckes_list_screen_model.dart';
import 'package:payroll_system/models/approve_paycheckes_list_screen_model/approve_paycheckes_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/utils/extension_methods/user_preference.dart';

class ApprovePayCheckesDetailsScreenController extends GetxController {
  String companyId = Get.arguments[0];
  String companyName = Get.arguments[1];
  ApprovePayCheckListData approvalData = Get.arguments[2];

  final approvePaychecksListScreenController =
      Get.find<ApprovePaychecksListScreenController>();
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  List<ApprovePayCheckListData> approvePayCheckListData = [];

  UserPreference userPreference = UserPreference();
  String prefsDateFormat = "";

  // Delete Employee
  Future<void> deleteApprovalFunction(String approvalId) async {
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
        // approvePayCheckListData.removeAt(index);
        isLoading(true);
        await approvePaychecksListScreenController.approvePaycheckesListFunction();
        isLoading(false);

        Get.back();
        Get.back();
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

  Future<void> payrollApproveApiFunction(String approvalId) async {
    isLoading(true);
    log("message");
    String url = "${ApiUrl.payrollapproveApi}$companyId/$approvalId";
    log('payrollApproveApiFunction Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));
      log('response : ${response.body}');

      ApprovalPermissionModel approvalPermissionModel =
          ApprovalPermissionModel.fromJson(json.decode(response.body));

      isSuccessStatus = approvalPermissionModel.success.obs;
      if (isSuccessStatus.value) {
        Fluttertoast.showToast(msg: approvalPermissionModel.messege);
        approvalData.approvepaychecks = "1";
        Get.back();
      } else {
        log('payrollApproveApiFunction Else');
      }
    } catch (e) {
      log('payrollApproveApiFunction Error :$e');

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
  }
}
