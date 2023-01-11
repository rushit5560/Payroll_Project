import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:payroll_system/models/Pay_checkes_list_model/pay_checkes_list_screen_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:http/http.dart' as http;

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
  TextEditingController hourlyRateController = TextEditingController();

  Future<void> getPaycheckesListFunction() async {
    isLoading(true);
    String url = "${ApiUrl.getPayCheckesListApi}$companyId";
    log("getPaycheckesListFunction url:   $url");
    log("getPaycheckesListFunction companyId:   $companyId");

    try {
      http.Response response = await http.get(Uri.parse(url));

      PayCheckListModel payCheckListModel =
          PayCheckListModel.fromJson(json.decode(response.body));
      log("getPaycheckesListFunction response  : ${response.body}");
      isSuccessStatus = payCheckListModel.success.obs;
      if (isSuccessStatus.value) {
        payCheckesListData.clear();
        payCheckesListData.addAll(payCheckListModel.data);

        // payrollListDataList = payrollListModel.data;
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    getPaycheckesListFunction();
    super.onInit();
  }
}
