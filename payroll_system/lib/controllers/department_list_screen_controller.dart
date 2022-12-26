import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/models/company_manage_screen_model/get_all_department_model.dart';
import 'package:payroll_system/models/employee_manage_screen_models/employee_delete_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:http/http.dart' as http;


class DepartmentListScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  List allDepartmentList = [];


  /// Get All Department
  Future<void> getAllDepartmentFunction() async {
    isLoading(true);
    String url = ApiUrl.allDepartmentApi;
    log('Get All Department Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));

      AllDepartmentModel allDepartmentModel = AllDepartmentModel.fromJson(json.decode(response.body));
      isSuccessStatus = allDepartmentModel.success.obs;

      if(isSuccessStatus.value) {
        allDepartmentList.clear();
        allDepartmentList.addAll(allDepartmentModel.data);


        log('departmentList Length : ${allDepartmentList.length}');

      } else {
        log('getAllDepartmentFunction Else');
      }

    } catch(e) {
      log('getAllDepartmentFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }

  }

  /// Delete Department
  Future<void> deleteDepartmentFunction(String departmentId, int index) async {
    isLoading(true);
    String url = "${ApiUrl.deleteDepartmentApi}$departmentId";
    log('Delete Department Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));
      log('response : ${response.body}');

      EmployeeDeleteModel deleteCompanyModel =
      EmployeeDeleteModel.fromJson(json.decode(response.body));
      isSuccessStatus = deleteCompanyModel.success.obs;

      if (isSuccessStatus.value) {
        Fluttertoast.showToast(msg: deleteCompanyModel.messege);
        // deleteEmployeeFunction(employeeId, index);
        allDepartmentList.removeAt(index);
        Get.back();
      } else {
        log('deleteDepartmentFunction Else');
      }
    } catch (e) {
      log('deleteDepartmentFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }



  @override
  void onInit() {
    getAllDepartmentFunction();
    super.onInit();
  }

}