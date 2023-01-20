import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/models/company_manage_screen_model/get_all_department_model.dart';
import 'package:payroll_system/models/employee_manage_screen_models/employee_delete_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/utils/extension_methods/user_preference.dart';

class DepartmentListScreenController extends GetxController {
  String companyId = Get.arguments[0];
  String companyName = Get.arguments[1];
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  final TextEditingController textSearchEditingController =
      TextEditingController();

  List<DepartmentData> allDepartmentList = [];
  List<DepartmentData> searchDepartmentDataList = [];

  /// Get All Department
  // Future<void> getAllDepartmentFunction() async {
  //   isLoading(true);
  //   String url = ApiUrl.allDepartmentApi;
  //   log('Get All Department Api Url :$url');

  //   try {
  //     http.Response response = await http.get(Uri.parse(url));

  //     AllDepartmentModel allDepartmentModel =
  //         AllDepartmentModel.fromJson(json.decode(response.body));
  //     isSuccessStatus = allDepartmentModel.success.obs;

  //     if (isSuccessStatus.value) {
  //       allDepartmentList.clear();
  //       allDepartmentList.addAll(allDepartmentModel.data);

  //       allDepartmentList = allDepartmentModel.data;

  //       searchDataList = allDepartmentList;

  //       log('departmentList Length : ${allDepartmentList.length}');
  //     } else {
  //       log('getAllDepartmentFunction Else');
  //     }
  //   } catch (e) {
  //     log('getAllDepartmentFunction Error :$e');
  //     rethrow;
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  /// Delete Department
  Future<void> deleteDepartmentFunction(String departmentId, int index) async {
    isLoading(true);
    String url = "${ApiUrl.deleteDepartmentApi}$departmentId/$companyId";
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

  Future<void> getCompanyWiseDepartmentFunction() async {
    isLoading(true);
    String url = "${ApiUrl.getCompanyDepartmentApi}$companyId";
    log('Get Company Department Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));
      AllDepartmentModel companyDepartmentModel =
          AllDepartmentModel.fromJson(json.decode(response.body));
      isSuccessStatus = companyDepartmentModel.success.obs;
      log("getCompanyWiseDepartmentFunction: ${response.body}");
      if (isSuccessStatus.value) {
        allDepartmentList.clear();
        allDepartmentList.addAll(companyDepartmentModel.data);
        searchDepartmentDataList = allDepartmentList;
        log("searchDataList:: ${searchDepartmentDataList.toString()}");
        log('allDepartmentList : ${allDepartmentList.toString()}');
      } else {
        log('getAllCompanyFunction Else');
      }
      // });
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong !");
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }
  
  initMethod() async {
    await getCompanyWiseDepartmentFunction();
  }
  
}
