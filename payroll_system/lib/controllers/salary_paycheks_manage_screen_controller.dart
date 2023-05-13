import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../models/employee_list_screen_models/employee_list_model.dart';
import '../models/pay_checkes_manage_screen_model/paychecks_create_model.dart';
import '../utils/api_url.dart';
import '../utils/extension_methods/user_preference.dart';
import 'salary_paycheks_list_screen_controller.dart';

class SalaryPayChecksManageScreenController extends GetxController {
  String companyId = Get.arguments[0];
  String companyName = Get.arguments[1];

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  String prefsDateFormat = "";

  final salaryPaychecksListScreenController =
      Get.find<SalaryPaychecksListScreenController>();

  List<String> isSalaryPayChecksList = [
    "Choose Option",
    "Bi-Weekly",
    "Monthly"
  ];
  RxString selectedSalaryChecksValue = "Choose Option".obs;

  UserPreference userPreference = UserPreference();

  List<CompanyWiseEmployeeData> allSalaryPaychecksWiseEmployeeList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> employeeFormKey = GlobalKey<FormState>();

  DateTime birthDate = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime payDate = DateTime.now().subtract(const Duration(days: 1));

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController payDateController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  TextEditingController startDateShowController = TextEditingController();
  TextEditingController endDateShowController = TextEditingController();
  TextEditingController payDateShowController = TextEditingController();

  List<Map<String, dynamic>> data = [];

  List<String> bonusList = [];
  List<String> otherEarningList = [];
  List<String> commissionList = [];
  List<String> sickPayList = [];
  List<String> vacationHoursList = [];
  List<String> tipList = [];
  List<String> taxList = [];
  List<String> selectedEmployeeList = [];

  Future<void> getSalaryPaycheckWiseEmployeeFunction() async {
    isLoading(true);
    String url = ApiUrl.payCheckWiseEmployeeApi;
    log('Get All Company List Api Url :$url');
    int userId = await userPreference.getIntValueFromPrefs(
        keyId: UserPreference.userIdKey);

    try {
      Map<String, dynamic> bodyData = {
        "userid": "$userId",
        "cid": companyId,
        "pay_period": "salary"
      };

      http.Response response = await http.post(Uri.parse(url), body: bodyData);
      log("getCompanyWiseEmployeeFunction ${response.body}");
      CompanyWiseEmployeeModel companyWiseEmployeeModel =
          CompanyWiseEmployeeModel.fromJson(json.decode(response.body));
      isSuccessStatus = companyWiseEmployeeModel.success.obs;

      if (isSuccessStatus.value) {
        allSalaryPaychecksWiseEmployeeList.clear();
        for (int i = 0; i < companyWiseEmployeeModel.data.length; i++) {
          if (companyWiseEmployeeModel.data[i].isActive == "1") {
            allSalaryPaychecksWiseEmployeeList
                .add(companyWiseEmployeeModel.data[i]);
          }
        }

        // allSalaryPaychecksWiseEmployeeList.addAll(companyWiseEmployeeModel.data);
        log('allSalaryPaychecksWiseEmployeeList : ${allSalaryPaychecksWiseEmployeeList.length}');
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

  Future<void> createSalaryPaycheckFunction() async {
    isLoading(true);
    String url = ApiUrl.createSalaryPayChecksApi;
    log('createPaycheckFunction Api Url :$url');

    int userId = await userPreference.getIntValueFromPrefs(
        keyId: UserPreference.userIdKey);
    int daysCount = endDate.difference(startDate).inDays;

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['cid'] = companyId;
      request.fields['userid'] = "$userId";
      request.fields['typeid'] = selectedSalaryChecksValue.value.toLowerCase();
      request.fields['startdate'] = startDateController.text.trim();
      request.fields['enddate'] = endDateController.text.trim();
      request.fields['paydate'] = payDateController.text.trim();
      request.fields['days'] = "$daysCount";
      request.fields['memo'] = memoController.text.trim();
      request.fields['data'] = jsonEncode(data);

      log('request.fields : ${request.fields}');

      var response = await request.send();

      response.stream
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .listen((value) async {
        log('value : $value');

        PaychecksCreateModel paychecksCreateModel =
            PaychecksCreateModel.fromJson(json.decode(value));
        isSuccessStatus.value = paychecksCreateModel.success;

        if (isSuccessStatus.value) {
          Fluttertoast.showToast(msg: paychecksCreateModel.messege);
          Get.back();
          await salaryPaychecksListScreenController
              .getSalaryPaycheckesFunction();
        } else {
          log('createPaycheckFunction Else');
        }
      });
    } catch (e) {
      log('createPaycheckFunction Error : $e');
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
    prefsDateFormat = await userPreference.getStringValueFromPrefs(
        keyId: UserPreference.dateFormatKey);
    await getSalaryPaycheckWiseEmployeeFunction();
  }
}
