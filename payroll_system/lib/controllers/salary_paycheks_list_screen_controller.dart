import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/models/Pay_checkes_list_model/pay_checkes_list_screen_model.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/models/approval_paycheckes_manage_screen_model/approval_paycheckes_delete_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';



class SalaryPaychecksListScreenController extends GetxController {
  String companyId = Get.arguments[0];
  String companyName = Get.arguments[1];

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  List<PayCheckesListData> salaryPayChecksList = [];
  List<PayCheckesListData> filterSalaryPayChecksList = [];

  List<String> filterList = ["All", "Approved", "Not Approved"];
  RxString selectedFilterValue = "All".obs;

  UserPreference userPreference = UserPreference();

  Future<void> getSalaryPaycheckesFunction() async {
    isLoading(true);
    String url = ApiUrl.getPayCheckesListApi;
    log("getSalaryPaycheckesFunction url:$url");
    log("getSalaryPaycheckesFunction companyId: $companyId");
    int userId = await userPreference.getIntValueFromPrefs(keyId: UserPreference.userIdKey);

    try {
      Map<String, dynamic> bodyData = {
        "userid": "$userId",
        "cid": companyId,
        "pay_period": "salary"
      };
      http.Response response = await http.post(Uri.parse(url), body: bodyData);
      log("getSalaryPaycheckesFunction response  : ${response.body}");

      PayCheckListModel payCheckListModel = PayCheckListModel.fromJson(json.decode(response.body));
      isSuccessStatus = payCheckListModel.success.obs;
      if (isSuccessStatus.value) {
        salaryPayChecksList.clear();
        salaryPayChecksList.addAll(payCheckListModel.data);
        filterSalaryPayChecksList = salaryPayChecksList;
        // payrollListDataList = payrollListModel.data;
      } else {
        log('getSalaryPaycheckesFunction Else');
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteSalaryPaychecksFunction(String approvalId) async {
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
        await getSalaryPaycheckesFunction();

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
    await getSalaryPaycheckesFunction();
  }
}