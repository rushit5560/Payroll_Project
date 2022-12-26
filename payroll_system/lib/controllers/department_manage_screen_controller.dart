import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/constants/anums.dart';
import 'package:payroll_system/controllers/department_list_screen_controller.dart';
import 'package:payroll_system/models/company_manage_screen_model/create_company_model.dart';
import 'package:payroll_system/models/department_manage_screen_models/department_get_by_id_model.dart';
import 'package:payroll_system/models/department_manage_screen_models/update_department_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/utils/extension_methods/user_details.dart';



class DepartmentManageScreenController extends GetxController {
  DepartmentOption departmentOption = Get.arguments[0];
  String departmentId = Get.arguments[1] ?? "";

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  DepartmentListScreenController departmentListScreenController = Get.find<DepartmentListScreenController>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameFieldController = TextEditingController();
  List<String> isActiveOptionList = ["Choose Option", "active", "inactive"];
  RxString selectedValue = "Choose Option".obs;


  Future<void> createDepartmentFunction() async {
    isLoading(true);
    String url = ApiUrl.createDepartmentApi;
    log('Create department Api Url : $url');

    try {
      Map<String, dynamic> bodyData = {
        "department_name": nameFieldController.text.trim(),
        "userid": "${UserDetails.userId}",
        "is_active": selectedValue.value == "active" ? "1" : "0"
      };

      http.Response response = await http.post(
        Uri.parse(url),
        body: bodyData,
      );

      CreateCompanyModel createCompanyModel = CreateCompanyModel.fromJson(json.decode(response.body));

      isSuccessStatus = createCompanyModel.success.obs;

      if(isSuccessStatus.value) {
        Fluttertoast.showToast(msg: createCompanyModel.messege);
        Get.back();
        await departmentListScreenController.getAllDepartmentFunction();
      } else {
        log('createDepartmentFunction Else');
      }

    } catch(e) {
      log('createDepartmentFunction Error : $e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> departmentGetByIdFunction() async {
    isLoading(true);
    String url = "${ApiUrl.getDepartmentDetailsApi}$departmentId";
    log('Department Get By Id Api Url :$url');

    try {

      http.Response response = await http.get(Uri.parse(url));
      log('response : ${response.body}');

      DepartmentGetByIdModel departmentGetByIdModel = DepartmentGetByIdModel.fromJson(json.decode(response.body));
      isSuccessStatus = departmentGetByIdModel.success.obs;

      if(isSuccessStatus.value) {
        nameFieldController.text = departmentGetByIdModel.data.departmentName;
        selectedValue.value = departmentGetByIdModel.data.isActive == "1" ? "active" : "inactive";
      } else {
        log('departmentGetByIdFunction Else');
      }


    } catch(e) {
      log('departmentGetByIdFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }

  }

  Future<void> updateDepartmentFunction() async {
    isLoading(true);
    String url = ApiUrl.updateDepartmentApi;
    log('Update Department Api Url : $url');

    try {

      Map<String, dynamic> bodyData = {
        "department_name" : nameFieldController.text.trim(),
        "userid" : "${UserDetails.userId}",
        "id" : departmentId,
        "is_active" : selectedValue.value == "active" ? "1" : "0"
      };
      log('bodyData : $bodyData');
      http.Response response = await http.post(
          Uri.parse(url),
          body: bodyData
      );

      UpdateDepartmentModel updateDepartmentModel = UpdateDepartmentModel.fromJson(json.decode(response.body));

      isSuccessStatus = updateDepartmentModel.success.obs;

      if(isSuccessStatus.value) {
        Fluttertoast.showToast(msg: updateDepartmentModel.messege);
        Get.back();
        await departmentListScreenController.getAllDepartmentFunction();
      } else {
        log('updateDepartmentFunction Else');
      }


    } catch(e) {
      log("updateDepartmentFunction Error :$e");
      rethrow;
    } finally {
      isLoading(false);
    }

  }


  loadUI() {
    isLoading(true);
    isLoading(false);
  }


  @override
  void onInit() {
    if(departmentOption == DepartmentOption.update) {
      departmentGetByIdFunction();
    }
    super.onInit();
  }

}