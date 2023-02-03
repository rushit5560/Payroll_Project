import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:payroll_system/constants/enums.dart';
import 'package:payroll_system/controllers/department_list_screen_controller.dart';
import 'package:payroll_system/models/department_manage_screen_models/create_department_model.dart';
import 'package:payroll_system/models/department_manage_screen_models/department_get_by_id_model.dart';
import 'package:payroll_system/models/department_manage_screen_models/update_department_model.dart';
import 'package:payroll_system/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:payroll_system/utils/extension_methods/user_preference.dart';

class DepartmentManageScreenController extends GetxController {
  DepartmentOption departmentOption = Get.arguments[0];
  String departmentId = Get.arguments[1] ?? "";
  String companyId = Get.arguments[2] ?? "";

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  DepartmentListScreenController departmentListScreenController =
      Get.find<DepartmentListScreenController>();
  UserPreference userPreference = UserPreference();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameFieldController = TextEditingController();
  List<String> isActiveOptionList = ["Choose Option", "Active", "In-Active"];
  RxString selectedValue = "Choose Option".obs;

  Future<void> createDepartmentFunction() async {
    isLoading(true);
    String url = ApiUrl.createDepartmentApi;
    log('Create department Api Url : $url');

    try {
      int userId = await userPreference.getIntValueFromPrefs(
          keyId: UserPreference.userIdKey);

      Map<String, dynamic> bodyData = {
        "department_name": nameFieldController.text.trim(),
        "userid": "$userId", // LoggedIn UserId Put in this field
        "is_active": selectedValue.value == "Active" ? "1" : "0",
        "cid": companyId // Out here company id
      };
      log("bodyData : $bodyData");
      http.Response response = await http.post(
        Uri.parse(url),
        body: bodyData,
      );

      log('response : ${response.body}');
      CreateDepartmentModel createDepartmentModel =
          CreateDepartmentModel.fromJson(json.decode(response.body));

      isSuccessStatus = createDepartmentModel.success.obs;

      if (isSuccessStatus.value) {
        Fluttertoast.showToast(msg: createDepartmentModel.messege);
        Get.back();
        await departmentListScreenController.getCompanyWiseDepartmentFunction();
      } else {
        log('createDepartmentFunction Else');
        if (createDepartmentModel.messege.toString().contains("The department name has already been taken")) {
          Fluttertoast.showToast(
              msg: createDepartmentModel.messege.toString());
        }
      }
    } catch (e) {
      log('createDepartmentFunction Error : $e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> departmentGetByIdFunction() async {
    isLoading(true);
    String url = "${ApiUrl.getDepartmentDetailsApi}$departmentId/$companyId";
    log('Department Get By Id Api Url :$url');

    try {
      http.Response response = await http.get(Uri.parse(url));
      log('response8989 : ${response.body}');

      DepartmentGetByIdModel departmentGetByIdModel =
          DepartmentGetByIdModel.fromJson(json.decode(response.body));
      isSuccessStatus = departmentGetByIdModel.success.obs;

      if (isSuccessStatus.value) {
        nameFieldController.text = departmentGetByIdModel.data.departmentName;
        selectedValue.value = departmentGetByIdModel.data.isActive == "1"
            ? "Active"
            : "In-Active";
      } else {
        log('departmentGetByIdFunction Else');
      }
    } catch (e) {
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
      int userId = await userPreference.getIntValueFromPrefs(
          keyId: UserPreference.userIdKey);

      Map<String, dynamic> bodyData = {
        "department_name": nameFieldController.text.trim(),
        "userid": "$userId",
        "id": departmentId,
        "is_active": selectedValue.value == "Active" ? "1" : "0",
        "cid": companyId // Out here company id
      };
      log('bodyData : $bodyData');
      http.Response response = await http.post(Uri.parse(url), body: bodyData);
      log('response1212 : ${response.body}');
      UpdateDepartmentModel updateDepartmentModel =
          UpdateDepartmentModel.fromJson(json.decode(response.body));

      isSuccessStatus = updateDepartmentModel.success.obs;

      if (isSuccessStatus.value) {
        Fluttertoast.showToast(msg: updateDepartmentModel.messege);
        Get.back();
        await departmentListScreenController.getCompanyWiseDepartmentFunction();
      } else {
        Fluttertoast.showToast(
            msg: updateDepartmentModel.messege);
        // log(updateDepartmentModel.error!.departmentName[0].toString());
      }
    } catch (e) {
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
    log('companyId : $companyId');
    if (departmentOption == DepartmentOption.update) {
      departmentGetByIdFunction();
    }
    super.onInit();
  }
}
