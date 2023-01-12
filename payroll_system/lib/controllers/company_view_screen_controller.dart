import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyViewScreenController extends GetxController {
  final String companyId = Get.arguments[0];
  final String companyName = Get.arguments[1];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;



  
}
