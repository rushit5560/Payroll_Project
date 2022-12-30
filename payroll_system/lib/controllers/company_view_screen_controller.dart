import 'dart:developer';

import 'package:get/get.dart';

class CompanyViewScreenController extends GetxController {
  final String companyId = Get.arguments[0];
  final String companyName = Get.arguments[1];



  @override
  void onInit() {
    log('companyId : $companyId');
    log('companyName : $companyName');
    super.onInit();
  }

}