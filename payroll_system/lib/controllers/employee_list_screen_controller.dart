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
  String companyName = Get.arguments[1];

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  List<CopanyWiseDepartmentData> allCompanyWiseEmployeeList = [];

  // int roleId = 0;
  // int userId = 0;

  // Get All Employee
  Future<void> getCompanyWiseEmployeeFunction() async {
    isLoading(true);
    String url = "${ApiUrl.getCompanyWiseEmployeeApi}$companyId";
    log('Get Company wise Employee List Api Url :$url');
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

  // Company Wise Employee
  // Future<void> getCompanyEmployeeFunction() async {
  //   isLoading(true);
  //   String url = "${ApiUrl.getCompanyWiseEmployeeApi}$companyId";
  //   log('Company Wise Employee Api Url : $url');

  //   try {
  //     http.Response response = await http.get(Uri.parse(url));

  //     CompanyWiseEmployeeModel companyWiseEmployeeModel =
  //         CompanyWiseEmployeeModel.fromJson(json.decode(response.body));
  //     isSuccessStatus = companyWiseEmployeeModel.success.obs;

  //     if (isSuccessStatus.value) {
  //       allCompanyWiseEmployeeList.clear();
  //       allCompanyWiseEmployeeList.addAll(companyWiseEmployeeModel.data);
  //     } else {
  //       log('getAllCompanyFunction Else');
  //     }
  //   } catch (e) {
  //     log('getCompanyEmployeeFunction Error :$e');
  //     rethrow;
  //   } finally {
  //     isLoading(false);
  //   }
  // }

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
    getCompanyWiseEmployeeFunction();
    // getAllEmployeeFunction();
    // getCompanyEmployeeFunction();
    super.onInit();
  }
}
