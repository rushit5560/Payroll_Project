import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/constants/enums.dart';

class LocationManageScreenController extends GetxController {
  RxBool isLoading = false.obs;

  LocationOption locationOption = Get.arguments[0];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController locationName = TextEditingController();
  List<String> isActiveOptionList = ["Choose Option", "active", "inactive"];
  RxString selectedValue = "Choose Option".obs;
}
