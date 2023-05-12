import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll/models/payroll_list_screen_model/payroll_list_screen_model.dart';
import 'package:payroll/utils/api_url.dart';

class PayRollListScreenController extends GetxController {
  String companyId = Get.arguments[0];
  String companyName = Get.arguments[1];
  final TextEditingController textSearchEditingController =
      TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  RxString selectedValue = "Choose Option".obs;
  List<PayrollListData> payrollListDataList = [];
  List<String> isPayperList = ["Choose Option", "Salary", "Hourly"];
  TextEditingController hourlyRateController = TextEditingController();

  Future<void> getPayrollListFunction() async {
    isLoading(true);
    String url = "${ApiUrl.getPayCheckesListApi}$companyId";
    log("getPayrollListFunction url:   $url");
    log("getPayrollListFunction companyId:   $companyId");

    try {
      http.Response response = await http.get(Uri.parse(url));

      PayrollListModel payrollListModel =
          PayrollListModel.fromJson(json.decode(response.body));
      log("getPayrollListFunction response  : ${response.body}");
      isSuccessStatus = payrollListModel.success.obs;
      if (isSuccessStatus.value) {
        payrollListDataList.clear();
        payrollListDataList.addAll(payrollListModel.data);

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
    getPayrollListFunction();
    super.onInit();
  }
}
