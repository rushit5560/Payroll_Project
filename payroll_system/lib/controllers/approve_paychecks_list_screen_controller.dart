import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
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

  List<ApprovePayCheckListData> approvePaychecksList = [];
  List<ApprovePayCheckListData> searchApprovePayCheckList = [];

  TextEditingController textSearchEditingController = TextEditingController();

  UserPreference userPreference = UserPreference();
  String prefsDateFormat = "";

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
        approvePaychecksList.clear();
        approvePaychecksList.addAll(approvePayCheckListModel.data);
        searchApprovePayCheckList = approvePaychecksList;
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  searchListFromSearchTextFunction(String value) {
    // List<PayCheckesListData> tempList = [];

    searchApprovePayCheckList = approvePaychecksList.where((element) =>
    element.firstName.toLowerCase().contains(value) ||
        element.middleName.toLowerCase().contains(value) ||
        element.lastName.toLowerCase().contains(value) ||
        element.companyname.toLowerCase().contains(value)
    ).toList();
    log('Search List = ${searchApprovePayCheckList.length}');
    // filterPayChecksListData = tempList;
  }

 

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  initMethod() async {
    prefsDateFormat = await userPreference.getStringValueFromPrefs(keyId: UserPreference.dateFormatKey);
    await approvePaycheckesListFunction();
  }
}
