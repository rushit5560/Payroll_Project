import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:payroll_system/models/company_list_screen_model/get_all_company_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';

class HomeScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<CompanyData> allCompanyList = [];
  UserPreference userPreference = UserPreference();
  RxInt roleId = 0.obs;

  /*getRoleIdFunctionFromPrefs() async {
    isLoading(true);
    int roleIdPrefs = await userPreference.getIntValueFromPrefs(keyId: UserPreference.roleIdKey);
    roleId.value = roleIdPrefs;
    log('Home Screen Init roleId : $roleId');
    isLoading(false);
  }*/

  /// Get All Company
  Future<void> getAllCompanyFunction() async {
    isLoading(true);
    String url = ApiUrl.allCompanyApi;
    log('Get All Company List Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));

      AllCompanyModel allCompanyModel =
      AllCompanyModel.fromJson(json.decode(response.body));
      isSuccessStatus = allCompanyModel.success.obs;

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
    // getRoleIdFunctionFromPrefs();
    getAllCompanyFunction();
    super.onInit();
  }

}
