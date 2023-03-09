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
import 'package:payroll_system/controllers/home_screen_controller.dart';
import 'package:payroll_system/models/location_list_screen_model/location_list_screen_model.dart';
import 'package:payroll_system/utils/extension_methods/user_preference.dart';
import '../constants/enums.dart';

class CompanyManageScreenController extends GetxController {
  CompanyOption companyOption = Get.arguments[0];
  String companyId = Get.arguments[1] ?? "";

  HomeScreenController homeScreenController = Get.find<HomeScreenController>();
  UserPreference userPreference = UserPreference();

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  List<DepartmentData> departmentList = [];
  List<LocationListData> allLocationList = [];

  List<String> departmentStringList = [];
  List<String> locationStringList = [];

  RxList<String> selectedDepartmentList = RxList<String>([]);
  RxList<String> selectedLocationList = RxList<String>([]);

  List<String> selectedDepartmentIdList = [];
  List<String> selectedLocationIdList = [];
  RxString selectedDepartmentOption = "".obs;
  RxString selectedLocationOption = "".obs;
  RxBool isPasswordVisible = true.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameFieldController = TextEditingController();
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController phoneNumberFieldController = TextEditingController();
  TextEditingController passwordFieldController =
      TextEditingController(text: '12345678');
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController landmarkAddressController = TextEditingController();
  TextEditingController zipcodeAddressController = TextEditingController();
  TextEditingController cityAddressController = TextEditingController();
  TextEditingController stateAddressController = TextEditingController();

  /// Create Company
  Future<void> createCompanyFunction() async {
    isLoading(true);
    String url = ApiUrl.createCompanyApi;
    log('Create Company Api Url :$url');

    int userId = await userPreference.getIntValueFromPrefs(
        keyId: UserPreference.userIdKey);

    try {
      Map<String, dynamic> bodyData = {
        "userid": "$userId",
        "user_name": nameFieldController.text.trim(),
        "password": passwordFieldController.text.trim(),
        "email": emailFieldController.text.trim().toLowerCase(),
        "phoneno": phoneNumberFieldController.text,
        "street": streetAddressController.text,
        "town": landmarkAddressController.text,
        "state": stateAddressController.text,
        "city": cityAddressController.text,
        "zipcode": zipcodeAddressController.text,
      };

      log('bodyData : $bodyData');

      http.Response response = await http.post(
        Uri.parse(url),
        body: bodyData,
      );
      log('response : ${response.body}');

      CreateCompanyModel createCompanyModel =
          CreateCompanyModel.fromJson(json.decode(response.body));

      isSuccessStatus = createCompanyModel.success.obs;

      if (isSuccessStatus.value) {
        Fluttertoast.showToast(msg: createCompanyModel.messege);
        Get.back();
        await homeScreenController.getAllCompanyFunction(userId);
      } else {
       if (createCompanyModel.error.email.isNotEmpty) {
            log("error");
            log("employeeCreateModel.error : ${createCompanyModel.error}");
            Fluttertoast.showToast(msg: createCompanyModel.error.email[0]);
          }

        log('createCompanyFunction Else');
      }
    } catch (e) {
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
      CompanyGetByIdModel companyGetByIdModel =
          CompanyGetByIdModel.fromJson(json.decode(response.body));

      isSuccessStatus = companyGetByIdModel.success.obs;

      if (isSuccessStatus.value) {
        nameFieldController.text = companyGetByIdModel.data.userName;
        emailFieldController.text = companyGetByIdModel.data.email;
        phoneNumberFieldController.text = companyGetByIdModel.data.phoneno;
        streetAddressController.text = companyGetByIdModel.data.street;
        landmarkAddressController.text = companyGetByIdModel.data.town;
        cityAddressController.text = companyGetByIdModel.data.city;
        stateAddressController.text = companyGetByIdModel.data.state;
        zipcodeAddressController.text = companyGetByIdModel.data.zipcode;

        // Remove Braces From Api String
        log('companyGetByIdModel.data.departmentId : ${companyGetByIdModel.data.departmentId}');
        // String removedBracesString = companyGetByIdModel.data.departmentId
        //     .substring(1, companyGetByIdModel.data.departmentId.length - 1);

        // Set Api Id list into local selected list
        List<String> apiDepartmentList =
            companyGetByIdModel.data.departmentId.split(',');
        selectedDepartmentIdList = apiDepartmentList;
        log('selectedDepartmentIdList : $selectedDepartmentIdList');

        // Clear show list
        selectedDepartmentList = <String>[].obs;

        // For Dropdown Show Selected Value show in dropdown
        for (int i = 0; i < departmentList.length; i++) {
          for (int j = 0; j < selectedDepartmentIdList.length; j++) {
            if (departmentList[i].id.toString().trim() ==
                selectedDepartmentIdList[j].trim()) {
              selectedDepartmentList.add(departmentList[i].departmentName);
            }
          }
        }
        log('selectedDepartmentList : $selectedDepartmentList');
      } else {
        log('getCompanyDetailsFunction Else');
      }
    } catch (e) {
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
      int userId = await userPreference.getIntValueFromPrefs(
          keyId: UserPreference.userIdKey);

      Map<String, dynamic> bodyData = {
        "id": companyId,
        "userid": "$userId",
        "user_name": nameFieldController.text.trim(),
        "email": emailFieldController.text.trim().toLowerCase(),
        "phoneno": phoneNumberFieldController.text,
        "street": streetAddressController.text,
        "town": landmarkAddressController.text,
        "state": stateAddressController.text,
        "city": cityAddressController.text,
        "zipcode": zipcodeAddressController.text,
      };

      log('bodyData : $bodyData');

      http.Response response = await http.post(
        Uri.parse(url),
        body: bodyData,
      );

      UpdateCompanyModel updateCompanyModel =
          UpdateCompanyModel.fromJson(json.decode(response.body));
      isSuccessStatus = updateCompanyModel.success.obs;

      if (isSuccessStatus.value) {
        Fluttertoast.showToast(msg: updateCompanyModel.messege);
        Get.back();
        await homeScreenController.getAllCompanyFunction(userId);
      } else {
        log('updateCompanyDetailsFunction Else');
        log('${updateCompanyModel.messege}');
      }
    } catch (e) {
      log('updateCompanyDetailsFunction Error :$e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    if (companyOption == CompanyOption.update) {
      getCompanyDetailsFunction();
    }

    log("$companyOption");
    super.onInit();
  }

  /// Selected department convert into string & remove white space
  String convertDepartmentIdListToStringFunction() {
    String selectedDepartmentIdString = "";
    String selectedDepartmentIdString2 = "";

    selectedDepartmentIdString = selectedDepartmentIdList
        .toString()
        .substring(1, selectedDepartmentIdList.toString().length - 1);
    selectedDepartmentIdString2 =
        selectedDepartmentIdString.replaceAll(" ", "");
    log('selectedDepartmentIdString2 :$selectedDepartmentIdString2');
    return selectedDepartmentIdString2;
  }

  loadUI() {
    isLoading(true);
    isLoading(false);
  }
}
