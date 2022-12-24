import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_system/Models/company_manage_screen_model/company_get_by_id_model.dart';
import 'package:payroll_system/Models/company_manage_screen_model/create_company_model.dart';
import 'package:payroll_system/Models/company_manage_screen_model/get_all_department_model.dart';
import 'package:payroll_system/Models/company_manage_screen_model/update_company_model.dart';
import 'package:payroll_system/Utils/api_url.dart';
import 'package:payroll_system/Utils/extension_methods/user_details.dart';
import 'package:payroll_system/constants/anums.dart';

import 'company_list_screen_controller.dart';

class CompanyManageScreenController extends GetxController {
  CompanyOption companyOption = Get.arguments[0];
  String companyId = Get.arguments[1] ?? "";

  CompanyListScreenController companyListScreenController = Get.find<CompanyListScreenController>();

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  List<DepartmentData> departmentList = [];
  List<String> departmentStringList = [];
  RxList<String> selectedDepartmentList = RxList<String>([]);
  // List<String> selectedDepartmentList = [];
  List<String> selectedDepartmentIdList = [];
  RxString selectedDepartmentOption = "".obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameFieldController = TextEditingController();
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController phoneNumberFieldController = TextEditingController();
  TextEditingController addressFieldController = TextEditingController();


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
        departmentList.clear();
        departmentList.addAll(allDepartmentModel.data);

        departmentStringList.clear();
        for(int i=0; i < departmentList.length; i++) {
          departmentStringList.add(departmentList[i].departmentName);
          log('${departmentList[i].id} : ${departmentList[i].departmentName}');
        }

        log('departmentList Length : ${departmentList.length}');

      } else {
        log('getAllDepartmentFunction Else');
      }

    } catch(e) {
      log('getAllDepartmentFunction Error :$e');
      rethrow;
    } finally {
      if(companyOption == CompanyOption.update) {
        // when update company that time
        await getCompanyDetailsFunction();
      } else if(companyOption == CompanyOption.create) {
        // when create new company
        isLoading(false);
      }
    }

  }

  /// Create Company
  Future<void> createCompanyFunction() async {
    isLoading(true);
    String url = ApiUrl.createCompanyApi;
    log('Create Company Api Url :$url');

    try {

      Map<String, dynamic> bodyData = {
        "userid": "${UserDetails.userId}",
        "user_name": nameFieldController.text.trim(),
        "email": emailFieldController.text.trim().toLowerCase(),
        "phoneno": phoneNumberFieldController.text,
        "department_id": "$selectedDepartmentIdList",
        "address": addressFieldController.text.trim(),
      };

      log('bodyData : $bodyData');

      http.Response response = await http.post(
        Uri.parse(url),
        body: bodyData,
      );
      log('response : ${response.body}');

      CreateCompanyModel createCompanyModel = CreateCompanyModel.fromJson(json.decode(response.body));

      isSuccessStatus = createCompanyModel.success.obs;

      if(isSuccessStatus.value) {
        Fluttertoast.showToast(msg: createCompanyModel.messege);
        Get.back();
        await companyListScreenController.getAllCompanyFunction();
      } else {
        log('createCompanyFunction Else');
      }


    } catch(e) {
      log('createCompanyFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  /// Get Company Details
  Future<void> getCompanyDetailsFunction() async {
    isLoading(true);
    String url = "${ApiUrl.getCompanyDetailsApi}$companyId";
    log('Company Details Get By Id Api Url : $url');

    try {
      http.Response response = await http.get(Uri.parse(url));
      CompanyGetByIdModel companyGetByIdModel = CompanyGetByIdModel.fromJson(json.decode(response.body));

      isSuccessStatus = companyGetByIdModel.success.obs;

      if(isSuccessStatus.value) {
        nameFieldController.text = companyGetByIdModel.data.userName;
        emailFieldController.text = companyGetByIdModel.data.email;
        phoneNumberFieldController.text = companyGetByIdModel.data.phoneno;
        addressFieldController.text = companyGetByIdModel.data.address;

        // Remove Braces From Api String
        log('companyGetByIdModel.data.departmentId : ${companyGetByIdModel.data.departmentId}');
        String removedBracesString = companyGetByIdModel.data.departmentId
            .substring(1, companyGetByIdModel.data.departmentId.length - 1);

        // Set Api Id list into local selected list
        List<String> apiDepartmentList = removedBracesString.split(',');
        selectedDepartmentIdList = apiDepartmentList;

        // Clear show list
        selectedDepartmentList = <String>[].obs;

        // For Dropdown Show Selected Value show in dropdown
        for(int i=0; i < departmentList.length; i++) {
          for(int j=0; j < selectedDepartmentIdList.length; j++) {
            if(departmentList[i].id.toString().trim() == selectedDepartmentIdList[j].trim()) {
              selectedDepartmentList.add(departmentList[i].departmentName);
            }
          }
        }
        log('selectedDepartmentList : $selectedDepartmentList');

      } else {
        log('getCompanyDetailsFunction Else');
      }

    } catch(e) {
      log('getCompanyDetailsFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }

  }

  /// Update Company Details
  Future<void> updateCompanyDetailsFunction() async {
    isLoading(true);
    String url = ApiUrl.updateCompanyDetailsApi;
    log('Update Company Api URl : $url');

    try {

      Map<String, dynamic> bodyData = {
        "id": companyId,
        "userid": "${UserDetails.userId}",
        "user_name": nameFieldController.text.trim(),
        "email": emailFieldController.text.trim().toLowerCase(),
        "phoneno": phoneNumberFieldController.text,
        "department_id": "$selectedDepartmentIdList",
        "address": addressFieldController.text.trim(),
      };

      http.Response response = await http.post(
        Uri.parse(url),
        body: bodyData,
      );

      UpdateCompanyModel updateCompanyModel = UpdateCompanyModel.fromJson(json.decode(response.body));
      isSuccessStatus = updateCompanyModel.success.obs;

      if(isSuccessStatus.value) {
        Fluttertoast.showToast(msg: updateCompanyModel.messege);
        Get.back();
        await companyListScreenController.getAllCompanyFunction();
      } else {
        log('updateCompanyDetailsFunction Else');
      }


    } catch(e) {
      log('updateCompanyDetailsFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    getAllDepartmentFunction();
    log("$companyOption");
    super.onInit();
  }

  /// Selected department convert into string & remove white space
  String convertDepartmentIdListToStringFunction() {
    String selectedDepartmentIdString = "";
    String selectedDepartmentIdString2 = "";

    selectedDepartmentIdString = selectedDepartmentIdList.toString().substring(1, selectedDepartmentIdList.toString().length -1);
    selectedDepartmentIdString2 = selectedDepartmentIdString.replaceAll(" ", "");
    log('selectedDepartmentIdString2 :$selectedDepartmentIdString2');
    return selectedDepartmentIdString2;
  }


  loadUI() {
    isLoading(true);
    isLoading(false);
  }

}