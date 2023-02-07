import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/models/genral_setting_model/genral_setting_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:http/http.dart' as http;

class GeneralSettingsScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<String> generalSettingsOptionList = [
    "Choose Option",
    "m-d-Y",
    "d-m-Y",
    "Y-m-d",
    "m/d/Y",
    "Y/m/d",
    "Y-M-d",
    "M-d-y",
    "d-M-Y"
  ];
  RxString selectedValue = "Choose Option".obs;

  Future<void> getDateFormatFunction() async {
    isLoading(true);
    String url = ApiUrl.getDateFormatApi;
    log('Get getDateFormatFunction Api Url :$url');
    try {
      http.Response response = await http.get(Uri.parse(url));

      GenralSettingModel genralSettingModel =
          GenralSettingModel.fromJson(json.decode(response.body));
      isSuccessStatus = genralSettingModel.success.obs;
      log("getCompanyWiseEmployeeFunction ${response.body}");
      if (isSuccessStatus.value) {
        selectedValue.value = genralSettingModel.data;
        log("getDateFormatFunction :: ${selectedValue.value}");
      } else {
        log('getAllCompanyFunction Else'); 
      }
    } catch (e) {
      log('getAllCompanyFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    getDateFormatFunction();
    super.onInit();
  }
}
