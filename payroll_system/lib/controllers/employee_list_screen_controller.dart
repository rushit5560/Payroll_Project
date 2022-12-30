import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/models/employee_list_screen_models/employee_list_model.dart';
import '../utils/api_url.dart';
import 'package:http/http.dart' as http;
import '../models/employee_manage_screen_models/employee_delete_model.dart';


class EmployeeListScreenController extends GetxController {
  String companyId = Get.arguments[0];

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  List<EmployeeData> allEmployeeList = [];

  // int roleId = 0;
  // int userId = 0;

  // Get All Employee
  Future<void> getAllEmployeeFunction() async {
    isLoading(true);
    String url = ApiUrl.allEmployeeApi;
    log('Get All Company List Api Url :$url');
    try {
      http.Response response = await http.get(Uri.parse(url));

      AllEmployeeModel allEmployeeModel =
          AllEmployeeModel.fromJson(json.decode(response.body));
      isSuccessStatus = allEmployeeModel.success.obs;

      if (isSuccessStatus.value) {
        allEmployeeList.clear();
        allEmployeeList.addAll(allEmployeeModel.data);
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
    String url = "${ApiUrl.deleteEmployeeApi}$employeeId";
    log('Delete Company Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));
      log('response : ${response.body}');

      EmployeeDeleteModel deleteCompanyModel =
          EmployeeDeleteModel.fromJson(json.decode(response.body));
      isSuccessStatus = deleteCompanyModel.success.obs;

      if (isSuccessStatus.value) {
        Fluttertoast.showToast(msg: deleteCompanyModel.messege);
        allEmployeeList.removeAt(index);
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

  // Company Wise Employee
  Future<void> getCompanyEmployeeFunction() async {
    isLoading(true);
    String url = "${ApiUrl.getCompanyWiseEmployeeApi}$companyId";
    log('Company Wise Employee Api Url : $url');

    try {
      http.Response response = await http.get(Uri.parse(url));

      AllEmployeeModel allEmployeeModel =
          AllEmployeeModel.fromJson(json.decode(response.body));
      isSuccessStatus = allEmployeeModel.success.obs;

      if (isSuccessStatus.value) {
        allEmployeeList.clear();
        allEmployeeList.addAll(allEmployeeModel.data);
      } else {
        log('getAllCompanyFunction Else');
      }
    } catch (e) {
      log('getCompanyEmployeeFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  /*getLoggedInUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    roleId = prefs.getInt(UserPreference.roleIdKey) ?? 0;
    userId = prefs.getInt(UserPreference.userIdKey) ?? 0;

    if (roleId == 1 || roleId == 2) {
      await getAllEmployeeFunction();
    } else if (roleId == 3) {
      await getCompanyEmployeeFunction();
    }
  }*/

  @override
  void onInit() {
    getCompanyEmployeeFunction();
    super.onInit();
  }
}
