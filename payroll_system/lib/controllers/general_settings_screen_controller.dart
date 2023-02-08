import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/models/genral_setting_model/genral_setting_model.dart';
import 'package:payroll_system/models/genral_setting_update_model/genral_setting_update_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:http/http.dart' as http;
import '../utils/extension_methods/user_preference.dart';

class GeneralSettingsScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int userIdPrefs = 0;
  UserPreference userPreference = UserPreference();

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

  RxBool isGeneralSettingEditPermission = false.obs;

  Future<void> getDateFormatFunction() async {
    log("userIdPrefsuserIdPrefs:   $userIdPrefs");
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
        await userPreference.setDateFormatInPrefs(dateFormat: selectedValue.value);

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

  Future<void> updateDateFormatFunction() async {
    isLoading(true);
    String url = ApiUrl.updateDateFormatApi;
    log("updateDateFormatFunction Api Url : $url");
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['datetype'] = selectedValue.value;
      request.fields['userid'] = "$userIdPrefs";
      request.fields['id'] = "1";

      var response = await request.send();

      response.stream
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .listen((value) async {
        log('value Update updateDateFormatFunction: $value');

        DateFormatUpdateModel dateFormatUpdateModel =
            DateFormatUpdateModel.fromJson(json.decode(value));

        isSuccessStatus = dateFormatUpdateModel.success.obs;

        if (isSuccessStatus.value) {
          Fluttertoast.showToast(msg: dateFormatUpdateModel.messege);
          await userPreference.setDateFormatInPrefs(dateFormat: selectedValue.value);
          Get.back();
        } else {
          log("updateDateFormatFunction");
        }
      });
    } catch (e) {
      log('updateDateFormatFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  getLoggedInUserIdFromPrefs() async {
    userIdPrefs = await userPreference.getIntValueFromPrefs(keyId: UserPreference.userIdKey);
    isGeneralSettingEditPermission.value = await userPreference.getBoolPermissionFromPrefs(keyId: UserPreference.generalSettingEditKey);
    await getDateFormatFunction();
  }

  @override
  void onInit() {
    getLoggedInUserIdFromPrefs();
    super.onInit();
  }
}
