import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/Utils/api_url.dart';
import 'package:payroll_system/Utils/extension_methods/user_preference.dart';
import 'package:payroll_system/models/approve_paycheckes_list_screen_model/approve_paycheckes_list_screen_model.dart';
import 'package:payroll_system/models/approve_paycheckes_list_screen_model/approve_paycheckes_model.dart';

class ApprovePaychecksListScreenController extends GetxController {
  String companyId = Get.arguments[0];
  String companyName = Get.arguments[1];

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  List approvePaychecksList = [];
  List<ApprovePayCheckListData> approvePayCheckListdata = [];

  UserPreference userPreference = UserPreference();

  Future<void> approvePaycheckesListFunction() async {
    isLoading(true);
    String url = "${ApiUrl.getApprovePayChecksListApi}$companyId";
    log("approvePaycheckesListFunction url:$url");
    log("approvePaycheckesListFunction companyId: $companyId");

    try {
      http.Response response = await http.get(Uri.parse(url));
      log("approvePaycheckesListFunction response  : ${response.body}");


      ApprovePayCheckListModel approvePayCheckListModel =
          ApprovePayCheckListModel.fromJson(json.decode(response.body));

      isSuccessStatus = approvePayCheckListModel.success.obs;
      if (isSuccessStatus.value) {
        approvePayCheckListdata.clear();
        approvePayCheckListdata.addAll(approvePayCheckListModel.data);

        approvePaychecksList = approvePayCheckListModel.data;
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

 

  @override
  void onInit() {
    approvePaycheckesListFunction();
    super.onInit();
  }
}
