import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/state_manager.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:payroll_system/models/pay_checkes_download_screen_model/pay_checkes_dowanload_screen_model.dart';

class PayCheckesDowanloadScreenController extends GetxController {
  String employeeId = Get.arguments[0];
  String employeeName = Get.arguments[1];

  final TextEditingController textSearchEditingController =
      TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  RxString selectedValue = "Choose Option".obs;
  List<String> isPayperList = ["Choose Option", "Salary", "Hourly"];
  List<PayCheckDwanloadListData> payCheckDwanloadListData = [];
  TextEditingController hourlyRateController = TextEditingController();

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
    getPaycheckesDowanlodeListFunction();
  }
}
