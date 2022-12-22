import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Models/company_manage_screen_model/get_all_department_model.dart';
import 'package:payroll_system/Utils/api_url.dart';
import 'package:payroll_system/constants/anums.dart';

class CompanyManageScreenController extends GetxController {
  CompanyOption companyOption = Get.arguments[0];

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  List<DepartmentData> departmentList = [];
  List<String> departmentStringList = [];
  Rx<List<String>> selectedDepartmentList = Rx<List<String>>([]);
  List<String> selectedDepartmentIdList = [];
  RxString selectedDepartmentOption = "".obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameFieldController = TextEditingController();
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController phoneNumberFieldController = TextEditingController();
  TextEditingController addressFieldController = TextEditingController();



  Future<void> getAllDepartmentFunction() async {
    isLoading(true);
    String url = ApiUrl.allDepartmentApi;
    log('Get All Department Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));

      AllDepartmentModel allDepartmentModel = AllDepartmentModel.fromJson(json.decode(response.body));
      isSuccessStatus = allDepartmentModel.success.obs;

      if(isSuccessStatus.value) {
        departmentList.clear();
        departmentList.addAll(allDepartmentModel.data);

        departmentStringList.clear();
        for(int i=0; i < departmentList.length; i++) {
          departmentStringList.add(departmentList[i].departmentName);
        }

        log('departmentList Length : ${departmentList.length}');

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



  @override
  void onInit() {
    getAllDepartmentFunction();
    if(companyOption == CompanyOption.update) {
      // when update company that time
    } else if(companyOption == CompanyOption.create) {
      // when create new company
    }

    log("$companyOption");
    super.onInit();
  }
}