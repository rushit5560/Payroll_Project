import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../Models/employee_list_model/employee_list_model.dart';
import '../Utils/api_url.dart';
import 'package:http/http.dart' as http;

import '../models/employee_manage_screen_models/employee_delete_model.dart';

class EmployeeListScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  List<EmployeeData> allEmployeeList = [];

  Future<void> getAllEmployeeFunction() async {
    isLoading(true);
    String url = ApiUrl.allEmployeeApi;
    log('Get All Company List Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));

      AllEmployeeModele allEmployeeModel =
          AllEmployeeModele.fromJson(json.decode(response.body));
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

  /// Delete Employee
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
        // deleteEmployeeFunction(employeeId, index);
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

  @override
  void onInit() {
    getAllEmployeeFunction();
    // TODO: implement onInit
    super.onInit();
  }
}
