import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:payroll_system/models/company_list_screen_model/get_all_company_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';

class HomeScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<CompanyData> allCompanyList = [];
  UserPreference userPreference = UserPreference();
  RxInt roleId = 0.obs;
  RxInt userid = 0.obs;


  getUserIdFunctionFromPrefs() async {
    isLoading(true);
    int userIdPrefs = await userPreference.getIntValueFromPrefs(keyId: UserPreference.userIdKey);
    int roleIdPrefs = await userPreference.getIntValueFromPrefs(keyId: UserPreference.roleIdKey);
    userid.value = userIdPrefs;
    roleId.value = roleIdPrefs;

    // log('Home Screen Init userid : ${userid.value}');
    await getAllCompanyFunction(userid);
    isLoading(false);
  }

  /// Get All Company
  Future<void> getAllCompanyFunction(userId) async {
    isLoading(true);
    // String url = ApiUrl.allCompanyApi;
    String url = roleId.value == 1
        ? ApiUrl.allCompanyApi
        : "${ApiUrl.getSubAdminWiseCompanyApi}$userId";
    log('Get All Company List Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));
      log('response : ${response.body}');
      AllCompanyModel allCompanyModel =
          AllCompanyModel.fromJson(json.decode(response.body));
      isSuccessStatus = allCompanyModel.success.obs;
      // log("getAllCompanyFunction data ::${response.body}");
      if (isSuccessStatus.value) {
        allCompanyList.clear();
        allCompanyList.addAll(allCompanyModel.data);
        log('allCompanyList Length : ${allCompanyList.length}');
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
    getUserIdFunctionFromPrefs();
    super.onInit();
  }
}
