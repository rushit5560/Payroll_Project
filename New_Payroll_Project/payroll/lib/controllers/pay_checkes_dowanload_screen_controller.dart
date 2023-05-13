import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/state_manager.dart';
import 'package:payroll/utils/api_url.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:payroll/models/pay_checkes_download_screen_model/pay_checkes_dowanload_screen_model.dart';

import '../utils/extension_methods/user_preference.dart';

class PayCheckesDowanloadScreenController extends GetxController {
  String employeeId = Get.arguments[0];
  String employeeName = Get.arguments[1];

  UserPreference userPreference = UserPreference();

  final TextEditingController textSearchEditingController =
      TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  RxString selectedValue = "Choose Option".obs;
  List<String> isPayperList = ["Choose Option", "Salary", "Hourly"];
  List<PayCheckDwanloadListData> payCheckDwanloadListData = [];
  TextEditingController hourlyRateController = TextEditingController();

  String prefsDateFormat = "";

  Future<void> getPaycheckesDowanlodeListFunction() async {
    isLoading(true);
    String url = "${ApiUrl.payCheckesDowanloadDocumentApi}$employeeId";
    log("getPaycheckesListFunction url:$url");
    log("getPaycheckesListFunction employeeId: $employeeId");

    try {
      http.Response response = await http.get(Uri.parse(url));
      log('getPaycheckesDowanlodeListFunction : ${response.body}');
      PayCheckDwanloadListModel payCheckDwanloadListModel =
          PayCheckDwanloadListModel.fromJson(json.decode(response.body));
      log("getPaycheckesListFunction response  : ${response.body}");
      isSuccessStatus = payCheckDwanloadListModel.success.obs;
      if (isSuccessStatus.value) {
        payCheckDwanloadListData.clear();
        payCheckDwanloadListData.addAll(payCheckDwanloadListModel.data);

        payCheckDwanloadListData = payCheckDwanloadListModel.data;
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    initMethod();
  }


  Future<void> initMethod() async {
    prefsDateFormat = await userPreference.getStringValueFromPrefs(
        keyId: UserPreference.dateFormatKey);
    await getPaycheckesDowanlodeListFunction();
  }
}
