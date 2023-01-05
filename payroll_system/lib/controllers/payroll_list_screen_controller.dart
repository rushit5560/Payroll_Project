import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayRollListScreenController extends GetxController {
  // int companyId = 0;
  // String companyName = "";
  String companyId = Get.arguments[0];
  String companyName = Get.arguments[1];
  final TextEditingController textSearchEditingController =
      TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  RxString selectedValue = "Choose Option".obs;

  List<String> isPayperList = ["Choose Option", "Salary", "Hourly"];
  TextEditingController hourlyRateController = TextEditingController();
}
