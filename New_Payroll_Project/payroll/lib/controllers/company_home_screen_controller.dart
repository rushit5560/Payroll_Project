import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:payroll/models/employee_list_screen_models/employee_list_model.dart';
import 'package:payroll/models/employee_manage_screen_models/employee_delete_model.dart';
import 'package:payroll/utils/api_url.dart';
import 'package:payroll/utils/extension_methods/user_preference.dart';

class CompanyHomeScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  List<CompanyWiseEmployeeData> allCompanyWiseEmployeeList = [];
  List<CompanyWiseEmployeeData> searchEmployeeList = [];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController textSearchEditingController =
      TextEditingController();

  int companyId = 0;
  String companyName = "";

  UserPreference userPreference = UserPreference();

  RxBool isDepartmentShowPermission = false.obs;
  RxBool isLocationShowPermission = false.obs;
  RxBool isEmployeeShowPermission = false.obs;
  RxBool isPaychecksShowPermission = false.obs;

  List<String> filterList = ["All", "Active", "In-Active", "Terminated"];
  RxString selectedFilterValue = "All".obs;

  // Get All Employee
  Future<void> getCompanyWiseEmployeeFunction() async {
    isLoading(true);
    String url = "${ApiUrl.getCompanyWiseEmployeeApi}$companyId";
    log('Get All Company List Api Url :$url');
    try {
      http.Response response = await http.get(Uri.parse(url));

      CompanyWiseEmployeeModel companyWiseEmployeeModel =
          CompanyWiseEmployeeModel.fromJson(json.decode(response.body));
      isSuccessStatus = companyWiseEmployeeModel.success.obs;
      log("getCompanyWiseEmployeeFunction ${response.body}");
      if (isSuccessStatus.value) {
        allCompanyWiseEmployeeList.clear();
        allCompanyWiseEmployeeList.addAll(companyWiseEmployeeModel.data);

        allCompanyWiseEmployeeList = companyWiseEmployeeModel.data;

        searchEmployeeList = allCompanyWiseEmployeeList;
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

// Delete Employee
  Future<void> deleteEmployeeFunction(String employeeId, int index) async {
    isLoading(true);
    String url = "${ApiUrl.deleteEmployeeApi}$employeeId/$companyId";
    log('Delete Company Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));
      log('response : ${response.body}');

      EmployeeDeleteModel deleteCompanyModel =
          EmployeeDeleteModel.fromJson(json.decode(response.body));
      isSuccessStatus = deleteCompanyModel.success.obs;

      if (isSuccessStatus.value) {
        Fluttertoast.showToast(msg: deleteCompanyModel.messege);
        allCompanyWiseEmployeeList.removeAt(index);
        Get.back();
      } else {
        log('deleteCompanyFunction Else');
      }
    } catch (e) {
      log('deleteCompanyFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  getLoggedInUserDataFromPrefs() async {
    companyId = await userPreference.getIntValueFromPrefs(
        keyId: UserPreference.userIdKey);
    companyName = await userPreference.getStringValueFromPrefs(
        keyId: UserPreference.userNameKey);
    if (isEmployeeShowPermission.value == true) {
      await getCompanyWiseEmployeeFunction();
    } else {
      isLoading(false);
    }
  }

  void filterDropdownWiseFunction(String value) {
    if (value == "All") {
      searchEmployeeList = allCompanyWiseEmployeeList;
    } else if (value == "Active") {
      searchEmployeeList = allCompanyWiseEmployeeList
          .where((element) => element.isActive == "1")
          .toList();
    } else if (value == "In-Active") {
      searchEmployeeList = allCompanyWiseEmployeeList
          .where((element) => element.isActive == "0")
          .toList();
    } else if (value == "Terminated") {
      searchEmployeeList = allCompanyWiseEmployeeList
          .where((element) => element.isActive == "2")
          .toList();
    }
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  initMethod() async {
    isLoading(true);
    isDepartmentShowPermission.value = await userPreference
        .getBoolPermissionFromPrefs(keyId: UserPreference.departmentViewKey);
    isLocationShowPermission.value = await userPreference
        .getBoolPermissionFromPrefs(keyId: UserPreference.locationViewKey);
    isEmployeeShowPermission.value = await userPreference
        .getBoolPermissionFromPrefs(keyId: UserPreference.employeeViewKey);
    isPaychecksShowPermission.value = await userPreference
        .getBoolPermissionFromPrefs(keyId: UserPreference.payChecksViewKey);
    await getLoggedInUserDataFromPrefs();
  }
}
